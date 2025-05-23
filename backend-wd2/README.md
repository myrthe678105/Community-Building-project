
## About

This repo contains some starter code for new PHP API projects.

What's included:

- Docker setup including:
  - PHP interpreter
  - NGINX server
  - MySQL (MariaDB) database
  - PHP MyAdmin
- A directory structure organized around the MVC pattern
- Composer
- Autoload setup

## Usage

```bash
docker compose up
```
PHPMyAdmin is accessible on localhost:8080

If you want to stop the containers, press Ctrl+C.

Or run:

```bash
docker compose down
```

## Important files

- The entry point for the application is `app/public/index.php`. Start there and trace the control flow through the routes, controllers and models

## Code Architecture

The code follows an MVC pattern. Here is an outline of the code structure:

- `public/index.php` - the main entry point of the application with initialization and routes.
- `controllers` - responsible for logic
- `models` - responsible for database CRUD
- `services` - various self contained services. These are primarily used by the controllers and can contain logic for small local services or for interacting with external services (mail send, external apis, etc.).

accounts: 

user: admin@admin.com
pass: admin

user: user@user.com
pass: user

user: test@test.com
pass: test

Or register a new account

              (\_/)
      .-""-.-.-' a\
     /  \      _.--'
    (\  /_---\\_\_
     `'-.
      ,__)

