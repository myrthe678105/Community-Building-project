<?php

namespace App\Controllers;

use App\Models\UserModel;
use App\Services\ResponseService;

class UserController extends Controller {
    private $userModel;
    
    public function __construct() {
        $this->userModel = new UserModel();
    }
    
    public function getAll() {
        ResponseService::Send($this->userModel->getAll());
    }
    
    public function get($id) {
        ResponseService::Send($this->userModel->getById($id));
    }
    
    public function create() {
        $data = $this->decodePostData();
        $this->validateInput(['name', 'email', 'password'], $data);
        ResponseService::Send($this->userModel->create($data));
    }

    public function findByEmail($email){
        ResponseService::Send($this->userModel->findByEmail($email));
    }
    public function delete($id){
        ResponseService::Send($this->userModel->delete($id));
    }
}