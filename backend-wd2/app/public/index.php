<?php

require_once __DIR__ . '/../vendor/autoload.php';

use App\Services\EnvService;
use App\Services\ErrorReportingService;
use App\Services\ResponseService;
use App\Controllers\UserController;
use App\Controllers\EventController;
use App\Controllers\ParkingController;
use App\Controllers\ComplaintController;
use App\Controllers\RecommendationController;
use App\Controllers\AuthController;

// require vendor libraries
use Steampixel\Route;

// initialize global environment variables
EnvService::Init();

// initialize error reporting (on in local env)
ErrorReportingService::Init();

// set CORS headers
ResponseService::SetCorsHeaders();

/**
 * Main application routes
 */
try {
    /**
     * Auth routes
     */
    Route::add('/auth/register', function () {
        $authController = new AuthController();
        $authController->register();
    }, ["post"]);

    Route::add('/auth/login', function () {
        $authController = new AuthController();
        $authController->login();
    }, ["post"]);

    Route::add('/auth/me', function () {
        $authController = new AuthController();
        $authController->me();
    }, ["get"]);

    Route::add('/auth/is-me/([0-9]*)', function ($id) {
        $authController = new AuthController();
        $authController->isMe($id);
    }, 'get');

    /**
     * User routes
     */
    Route::add('/users', function () {
        $userController = new UserController();
        $userController->getAll();
    });

    Route::add('/users/([0-9]*)', function ($id) {
        $userController = new UserController();
        $userController->get($id);
    });

    Route::add('/users', function () {
        $userController = new UserController();
        $userController->create($_POST);
    }, ["post"]);

    Route::add('/users/([0-9]*)', function ($id) {
        $userController = new UserController();
        $userController->delete($id);
    }, 'delete');

    /**
     * Event routes
     */
    Route::add('/events', function () {
        $eventController = new EventController();
        $eventController->getAll();
    });

    Route::add('/events', function () {
        $eventController = new EventController();
        $eventController->create($_POST);
    }, ["post"]);

    Route::add('/events/([0-9]*)', function ($id) {
        $eventController = new EventController();
        $eventController->delete($id);
    }, 'delete');

        /**
     * parking routes
     */

    Route::add('/parking', function () {
        $parkingController = new ParkingController();
        $parkingController->getAll();
    }, 'get');

    Route::add('/parking/([0-9]*)', function ($id) {
        $data = json_decode(file_get_contents("php://input"), true);
        
        $parkingController = new ParkingController();
        
        $parkingController->update($id, $data);
    }, 'put');


    /**
     * Complaint routes
     */
    Route::add('/complaints', function () {
        $complaintController = new ComplaintController();
        $complaintController->getAll();
    });

    Route::add('/complaints', function () {
        $complaintController = new ComplaintController();
        $complaintController->create($_POST);
    }, ["post"]);

    Route::add('/complaints/([0-9]*)', function ($id) {
        $complaintController = new ComplaintController();
        $complaintController->delete($id);
    }, 'delete');

    /**
     * Recommendation routes
     */
    Route::add('/recommendations', function () {
        $recommendationController = new RecommendationController();
        $recommendationController->getAll();
    });

    Route::add('/recommendations', function () {
        $recommendationController = new RecommendationController();
        $recommendationController->create($_POST);
    }, ["post"]);

    /**
     * 404 route handler
     */
    Route::pathNotFound(function () {
        ResponseService::Error("route is not defined", 404);
    });
} catch (\Throwable $error) {
    if ($_ENV["environment"] == "LOCAL") {
        var_dump($error);
    } else {
        error_log($error);
    }
    ResponseService::Error("A server error occurred");
}

Route::run();
