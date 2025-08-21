# Rails API Authentication Example

This project provides a simple Rails API with user authentication and basic endpoints for signup, login, and retrieving users.

## Endpoints
#### 1. Get Users

URL: http://127.0.0.1:3000/users

Method: GET

Auth required: ✅ Yes (Bearer Token in Authorization header)

Example Request (cURL):
(I added this just to check if all users are inserted and to play along)

#### 2. Signup

URL: http://127.0.0.1:3000/signup

Method: POST

Auth required: ❌ No

Request Body (JSON):

{  
  "email": "user@example.com",  
  "password": "your_password"  
}


Example Request (cURL):
curl -X POST http://127.0.0.1:3000/signup \ -H "Content-Type: application/json" \ -d '{"email": "user@example.com", "password": "your_password"}'

#### 3. Login

URL: http://127.0.0.1:3000/login

Method: POST

Auth required: ❌ No

Request Body (JSON):

{  
  "email": "user@example.com",  
  "password": "your_password"  
}


Example Request (cURL):
curl -X POST http://127.0.0.1:3000/login \ -H "Content-Type: application/json" \ -d '{"email": "user@example.com", "password": "your_password"}'

Successful Response Example:

{  
  "token": "<your_jwt_token>"  
}

### Authentication Flow

1. Sign up a new account via /signup.

2. Log in with the same credentials via /login to receive a JWT token.

3. Use the token in the Authorization header to access protected endpoints like /users.

### Tech Stack

Rails (API mode)

PostgreSQL (default DB)

JWT for authentication

### Running the Project

1. Install dependencies
bundle install

2. Setup the database
rails db:create db:migrate

3. Start the server
rails server

The API will be available at:
👉 http://127.0.0.1:3000