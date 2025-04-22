<?php

namespace App\Models;

require_once __DIR__ . '/Model.php';

class RecommendationModel extends Model
{
    public function getAll()
    {
        $stmt = self::$pdo->prepare("SELECT * FROM recommendations");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function create($data)
    {
        $stmt = self::$pdo->prepare("INSERT INTO recommendations (title, user_id, content, created_at) VALUES (?, ?, ?, NOW())");
        return $stmt->execute([$data['title'], $data['user_id'], $data['content']]);
    }
}