<?php

namespace App\Models;

require_once __DIR__ . '/Model.php';
use \PDO;

class ParkingModel extends Model
{
    public function getAll()
    {
        $stmt = self::$pdo->prepare("SELECT * FROM parking_spots");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    // public function getById($id)
    // {
    //     $stmt = self::$pdo->prepare("SELECT * FROM parking_spots WHERE id = ?");
    //     $stmt->execute([$id]);
    //     return $stmt->fetch();
    // }

    public function update($id, $data)
    {
        $stmt = self::$pdo->prepare("
            UPDATE parking_spots 
            SET status = :status
            WHERE id = :id
        ");
        $stmt->bindParam(':status', $data['status'], PDO::PARAM_STR);
        $stmt->bindParam(':id', $id, PDO::PARAM_INT);

        if ($stmt->execute()) {
            return $this->getById($id); 
        } else {
            return null;
        }
    }


    // public function create($data)
    // {
    //     $stmt = self::$pdo->prepare("INSERT INTO parking_spots (spot_number, user_id, status) VALUES (?, ?, ?)");
    //     return $stmt->execute([$data['spot_number'], $data['user_id'], $data['status']]);
    // }
}
