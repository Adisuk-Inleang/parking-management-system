<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header("Access-Control-Allow-Methods: GET, POST, PUT, OPTIONS");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once 'connectdb.php';
session_start();

// ตั้งค่า Timezone ให้ตรงกับ Asia/Bangkok
date_default_timezone_set('Asia/Bangkok');

$action = isset($_GET['action']) ? $_GET['action'] : '';
$data = json_decode(file_get_contents("php://input"), true);

// ฟังก์ชันตรวจสอบและยกเลิกการจองที่หมดเวลา 30 นาทีอัตโนมัติ
function cleanupExpiredReservations($conn) {
    $now = date('Y-m-d H:i:s');
    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = 0, is_reserved = 0, reserved_by = NULL, reserved_until = NULL, plate = NULL WHERE is_reserved = 1 AND is_occupied = 0 AND reserved_until < ?");
    $stmt->bind_param("s", $now);
    $stmt->execute();
}

cleanupExpiredReservations($conn);

// 1. ลงทะเบียน (Register)
if ($action === 'register' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($data['email'] ?? $data['username'] ?? '');
    $password = trim($data['password'] ?? '');
    $role = trim($data['role'] ?? 'student');

    if (empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "กรุณากรอกข้อมูลให้ครบถ้วน"]);
        exit();
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL) || !preg_match('/\.ac\.th$/i', $email)) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ต้องใช้อีเมลมหาวิทยาลัยเท่านั้น (เช่น std@university.ac.th)"]);
        exit();
    }

    $check_stmt = $conn->prepare("SELECT id FROM users WHERE email = ?");
    $check_stmt->bind_param("s", $email);
    $check_stmt->execute();
    if ($check_stmt->get_result()->num_rows > 0) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "อีเมลนี้ถูกใช้งานในระบบแล้ว"]);
        exit();
    }

    $hashed_password = password_hash($password, PASSWORD_BCRYPT);
    $stmt = $conn->prepare("INSERT INTO users (email, password, role) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $email, $hashed_password, $role);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "ลงทะเบียนสำเร็จ"]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => "เกิดข้อผิดพลาดในการลงทะเบียน"]);
    }
    exit();
}

// 2. เข้าสู่ระบบ (Login)
if ($action === 'login' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($data['email'] ?? $data['username'] ?? '');
    $password = trim($data['password'] ?? '');

    $stmt = $conn->prepare("SELECT id, email, password, role FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        if (password_verify($password, $row['password']) || $password === $row['password']) {
            $_SESSION['user_id'] = $row['id'];
            $_SESSION['username'] = $row['email'];
            $_SESSION['role'] = $row['role'];
            echo json_encode([
                "status" => "success",
                "message" => "เข้าสู่ระบบสำเร็จ",
                "role" => $row['role'],
                "username" => $row['email'],
                "email" => $row['email'],
                "token" => session_id()
            ]);
            exit();
        }
    }

    http_response_code(401);
    echo json_encode(["status" => "error", "message" => "อีเมลหรือรหัสผ่านไม่ถูกต้อง"]);
    exit();
}

// 3. จองช่องจอด (Reserve Slot)
if ($action === 'reserve_slot' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $slotId = $data['id'] ?? '';
    $username = $data['username'] ?? $data['email'] ?? '';
    $plate = trim($data['plate'] ?? '');

    if (empty($slotId) || empty($username) || empty($plate)) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "กรุณาระบุช่องจอด ทะเบียนรถ และบัญชีผู้ใช้"]);
        exit();
    }

    $check_user = $conn->prepare("SELECT id FROM parking_slots WHERE reserved_by = ? AND (is_reserved = 1 OR is_occupied = 1)");
    $check_user->bind_param("s", $username);
    $check_user->execute();
    if ($check_user->get_result()->num_rows > 0) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "บัญชีของคุณมีการจองหรือใช้งานช่องจอดอยู่แล้ว (จำกัด 1 สิทธิ์/บัญชี)"]);
        exit();
    }

    $reservedUntil = date('Y-m-d H:i:s', strtotime('+30 minutes'));

    $stmt = $conn->prepare("UPDATE parking_slots SET is_reserved = 1, reserved_by = ?, reserved_until = ?, plate = ? WHERE id = ? AND is_occupied = 0 AND is_reserved = 0");
    $stmt->bind_param("ssss", $username, $reservedUntil, $plate, $slotId);

    if ($stmt->execute() && $stmt->affected_rows > 0) {
        echo json_encode([
            "status" => "success", 
            "message" => "จองช่องจอดสำเร็จ! กรุณา Check-in ภายใน 30 นาที",
            "reserved_until" => $reservedUntil
        ]);
    } else {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ช่องจอดนี้ไม่ว่างหรือถูกจองแล้ว"]);
    }
    exit();
}

// 4. Check-in (เข้าจอด)
if ($action === 'check_in' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $slotId = $data['id'] ?? '';
    $username = $data['username'] ?? $data['email'] ?? '';

    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = 1, is_reserved = 0 WHERE (id = ? OR reserved_by = ?) AND (is_reserved = 1 OR reserved_by = ?)");
    $stmt->bind_param("sss", $slotId, $username, $username);

    if ($stmt->execute() && $stmt->affected_rows > 0) {
        echo json_encode(["status" => "success", "message" => "Check-in เข้าจอดเรียบร้อยแล้ว"]);
    } else {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ไม่สามารถ Check-in ได้ กรุณาตรวจสอบข้อมูลการจอง"]);
    }
    exit();
}

// 5. Check-out (นำรถออก / คืนช่องจอด)
if ($action === 'check_out' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $data['username'] ?? $data['email'] ?? '';

    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = 0, is_reserved = 0, reserved_by = NULL, reserved_until = NULL, plate = NULL WHERE reserved_by = ?");
    $stmt->bind_param("s", $username);

    if ($stmt->execute() && $stmt->affected_rows > 0) {
        echo json_encode(["status" => "success", "message" => "Check-out นำรถออกจากช่องจอดเรียบร้อยแล้ว"]);
    } else {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ไม่พบช่องจอดที่คุณกำลังใช้งานอยู่"]);
    }
    exit();
}

// 6. ปลดล็อกช่องจอดฉุกเฉิน (Staff)
if ($action === 'release_slot' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $slotId = $data['id'] ?? '';

    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = 0, is_reserved = 0, reserved_by = NULL, reserved_until = NULL, plate = NULL WHERE id = ?");
    $stmt->bind_param("s", $slotId);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "คืนช่องจอดเรียบร้อยแล้ว"]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => "ไม่สามารถทำรายการได้"]);
    }
    exit();
}

// 7. เซ็ตช่องจอดทั้งหมดให้เป็นว่าง (Reset All Slots)
if ($action === 'reset_all_slots' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = 0, is_reserved = 0, reserved_by = NULL, reserved_until = NULL, plate = NULL");

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "รีเซ็ตทุกช่องจอดให้เป็นว่างเรียบร้อยแล้ว"]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => "ไม่สามารถรีเซ็ตช่องจอดได้"]);
    }
    exit();
}

// 8. ดึงข้อมูลช่องจอดทั้งหมด
if ($action === 'get_slots' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $result = $conn->query("SELECT id, zone, is_occupied, is_reserved, reserved_by, reserved_until, plate FROM parking_slots ORDER BY id ASC");
    $slots = [];

    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $row['is_occupied'] = (bool)$row['is_occupied'];
            $row['is_reserved'] = (bool)$row['is_reserved'];
            $slots[] = $row;
        }
    }

    echo json_encode($slots);
    exit();
}

// 9. ออกจากระบบ (Logout)
if ($action === 'logout') {
    session_destroy();
    echo json_encode(["status" => "success", "message" => "Logged out successfully"]);
    exit();
}

http_response_code(404);
echo json_encode(["message" => "Invalid API Action"]);
?>