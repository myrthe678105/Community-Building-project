<?php

namespace App\Controllers;

use App\Models\ComplaintModel;
use App\Services\ResponseService;

class ComplaintController extends Controller {
    private $complaintModel;
    public function __construct() {
        $this->complaintModel = new ComplaintModel();
    }
    public function getAll() {
        ResponseService::Send($this->complaintModel->getAll());
    }
    
    public function create() {
        $data = $this->decodePostData();
        $this->validateInput(['user_id', 'description'], $data);
        ResponseService::Send($this->complaintModel->create($data));
    }
    public function delete($id) {
        ResponseService::Send($this->complaintModel->delete($id));
    }
}
