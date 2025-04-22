<?php

namespace App\Controllers;

use App\Models\EventModel;
use App\Services\ResponseService;

class EventController extends Controller {
    private $eventModel;
    public function __construct() {
        $this->eventModel = new EventModel();
    }
    public function getAll() {
        ResponseService::Send($this->eventModel->getAll());
    }
    
    public function create() {
        $data = $this->decodePostData();
        $this->validateInput(['title', 'description', 'event_date', 'location'], $data);
        ResponseService::Send($this->eventModel->create($data));
    }
    public function delete($id) {
        ResponseService::Send($this->eventModel->delete($id));
    }
}