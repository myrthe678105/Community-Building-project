<?php

namespace App\Controllers;

use App\Models\ParkingModel;
use App\Services\ResponseService;

class ParkingController extends Controller {
    private $parkingModel;
    public function __construct() {
        $this->parkingModel = new ParkingModel();
    }
    public function getAll() {
        ResponseService::Send($this->parkingModel->getAll());
    }
    
    public function update($id, $data) {
        ResponseService::Send($this->parkingModel->update($id, $data));
    }
}
