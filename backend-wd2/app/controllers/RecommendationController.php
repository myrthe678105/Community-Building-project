<?php

namespace App\Controllers;

use App\Models\RecommendationModel;
use App\Services\ResponseService;

class RecommendationController extends Controller {
    private $recommendationmodel;
    public function __construct() {
        $this->recommendationmodel = new RecommendationModel();
    }
    public function getAll() {
        ResponseService::Send($this->recommendationmodel->getAll());
    }
    
    public function create() {
        $data = $this->decodePostData();
        $this->validateInput(['title', 'user_id', 'content'], $data);
        ResponseService::Send($this->recommendationmodel->create($data));
    }
}
