<?php

namespace App\Controllers;

use App\Models\UserModel;
use App\Services\ResponseService;
use Firebase\JWT\JWT;

class AuthController extends Controller
{
    private $userModel;

    public function __construct()
    {
        $this->userModel = new UserModel();
    }

    public function register()
    {
        $data = $this->decodePostData();
    
        $this->validateInput(['email', 'password', 'name', 'role'], $data);
    
        if ($this->userModel->findByEmail($data['email'])) {
            ResponseService::Error('Email already exists', 400);
            return;
        }
    
        // Hash 
        $data['password'] = password_hash($data['password'], PASSWORD_DEFAULT);
    
        try {
            $this->userModel->create($data); 
            return ResponseService::Send(['message' => 'User registered successfully']);
        } catch (\Exception $e) {
            ResponseService::Error('Registration failed: ' . $e->getMessage(), 500);
        }
    }
    

    public function login()
    {
        $data = $this->decodePostData();

        $this->validateInput(['email', 'password'], $data);

        $user = $this->userModel->findByEmail($data['email']);

        if (!$user || !password_verify($data['password'], $user['password'])) {
            ResponseService::Error('Invalid credentials', 401);
            return;
        }

        $token = $this->generateJWT($user);

        ResponseService::Send([
            'token' => $token,
            'user' => [
                'id' => $user['id'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ]);    }

    public function me()
    {
        ResponseService::Send($this->getAuthenticatedUser());
    }

    private function generateJWT($user)
    {
        $issuedAt = time();
        $expire = $issuedAt + 3600 * 4; // 4 hours

        $payload = [
            'iat' => $issuedAt,
            'exp' => $expire,
            'user' => [
                'id' => $user['id'],
                'email' => $user['email'],
                'role' => $user['role']
            ]
        ];

        return JWT::encode($payload, $_ENV["JWT_SECRET"], 'HS256');
    }

    public function isMe($id)
    {
        $this->validateIsMe($id);
        ResponseService::Send(['message' => 'You are authorized to access this resource']);
    }
}
