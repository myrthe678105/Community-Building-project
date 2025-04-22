<?php

namespace App\Models;

require_once __DIR__ . '/Model.php';

class ComplaintModel extends Model
{
    public function getAll()
    {
        $stmt = self::$pdo->prepare("SELECT * FROM complaints");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function create($data)
    {
        $stmt = self::$pdo->prepare("INSERT INTO complaints (user_id, description, created_at) VALUES (?, ?, NOW())");
        return $stmt->execute([$data['user_id'], $data['description']]);
    }

    public function delete($id)
    {
        $stmt = self::$pdo->prepare("DELETE FROM complaints WHERE id = ?");
        return $stmt->execute([$id]);
    }
}
