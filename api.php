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

$action = isset($_GET['action']) ? $_GET['action'] : '';
$data = json_decode(file_get_contents("php://input"), true);

// 1. ลงทะเบียน (Register) - เพิ่มระบบสมัครสมาชิกเพื่อแก้ Invalid API Action
if ($action === 'register' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($data['username'] ?? '');
    $password = trim($data['password'] ?? '');

    if (empty($username) || empty($password)) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "กรุณากรอกข้อมูลให้ครบถ้วน"]);
        exit();
    }

    // ตรวจสอบว่ามีชื่อผู้ใช้นี้ในระบบแล้วหรือยัง
    $check_stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
    $check_stmt->bind_param("s", $username);
    $check_stmt->execute();
    $check_result = $check_stmt->get_result();

    if ($check_result->num_rows > 0) {
        http_response_code(400);
        echo json_encode(["status" => "error", "message" => "ชื่อผู้ใช้นี้ถูกใช้งานแล้ว"]);
        exit();
    }

    // เข้ารหัสรหัสผ่านเพื่อความปลอดภัย
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
    $stmt->bind_param("ss", $username, $hashed_password);

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
    $username = trim($data['username'] ?? '');
    $password = trim($data['password'] ?? '');

    $stmt = $conn->prepare("SELECT id, username, password FROM users WHERE username = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        // ตรวจสอบรหัสผ่าน (รองรับทั้ง password_hash และรหัสผ่านธรรมดา)
        $is_password_valid = password_verify($password, $row['password']) || ($password === $row['password']);
        
        if ($is_password_valid) {
            $_SESSION['user_id'] = $row['id'];
            $_SESSION['username'] = $row['username'];
            echo json_encode([
                "status" => "success",
                "message" => "Login successful",
                "token" => session_id()
            ]);
            exit();
        }
    }

    http_response_code(401);
    echo json_encode(["status" => "error", "message" => "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"]);
    exit();
}

// 3. ออกจากระบบ (Logout)
if ($action === 'logout') {
    session_destroy();
    echo json_encode(["status" => "success", "message" => "Logged out successfully"]);
    exit();
}

// 4. ดึงข้อมูลช่องจอดทั้งหมด (Get Slots)
if ($action === 'get_slots' && $_SERVER['REQUEST_METHOD'] === 'GET') {
    $result = $conn->query("SELECT id, zone, is_occupied, plate FROM parking_slots ORDER BY id ASC");
    $slots = [];

    if ($result) {
        while ($row = $result->fetch_assoc()) {
            $row['is_occupied'] = (bool)$row['is_occupied'];
            $slots[] = $row;
        }
    }

    echo json_encode($slots);
    exit();
}

// 5. อัปเดตสถานะช่องจอด (Update Slot: Check-in / Check-out)
if ($action === 'update_slot' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $slotId = $data['id'] ?? '';
    $isOccupied = isset($data['is_occupied']) ? ($data['is_occupied'] ? 1 : 0) : 0;
    $plate = $data['plate'] ?? '';

    if (empty($slotId)) {
        http_response_code(400);
        echo json_encode(["message" => "Slot ID is required"]);
        exit();
    }

    $stmt = $conn->prepare("UPDATE parking_slots SET is_occupied = ?, plate = ? WHERE id = ?");
    $stmt->bind_param("iss", $isOccupied, $plate, $slotId);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Slot updated successfully"]);
    } else {
        http_response_code(500);
        echo json_encode(["status" => "error", "message" => "Failed to update slot"]);
    }
    exit();
}

// กรณีส่ง action ที่ไม่มีในระบบ
http_response_code(404);
echo json_encode(["message" => "Invalid API Action"]);
?>