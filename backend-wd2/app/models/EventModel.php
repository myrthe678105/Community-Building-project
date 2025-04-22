<?php

namespace App\Models;

require_once __DIR__ . '/Model.php';

class EventModel extends Model
{
    public function getAll()
    {
        $stmt = self::$pdo->prepare("SELECT * FROM events");
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function create($data)
    {
        $stmt = self::$pdo->prepare("INSERT INTO events (title, description, event_date, location) VALUES (?, ?, ?, ?)");
        return $stmt->execute([$data['title'], $data['description'], $data['event_date'], $data['location']]);
    }

    public function delete($id)
    {
        $stmt = self::$pdo->prepare("DELETE FROM events WHERE id = ?");
        return $stmt->execute([$id]);
    }
}
