import datetime
import jwt
from flask import Flask, request, jsonify

app = Flask(__name__)

# Configuration
JWT_SECRET_KEY = 'your_jwt_secret_key'  # Change this to a secure key
API_KEY = "2f5ae96c-b558-4c7b-a590-a501ae1c3f6c"

def generate_jwt():
    """Generate a JWT that changes with each request."""
    payload = {
        'exp': datetime.datetime.utcnow() + datetime.timedelta(seconds=30),  # JWT expires in 30 seconds
        'iat': datetime.datetime.utcnow(),  # Issued at time
        'data': "unique_request_data"  # Can be any unique data related to the request
    }
    return jwt.encode(payload, JWT_SECRET_KEY, algorithm='HS256')

def validate_jwt(token):
    """Validate the JWT."""
    try:
        jwt.decode(token, JWT_SECRET_KEY, algorithms=['HS256'])
        return True
    except jwt.ExpiredSignatureError:
        return False
    except jwt.InvalidTokenError:
        return False

@app.route('/DevOps', methods=['POST'])
def devops():
    # Verify API Key
    if request.headers.get('X-Parse-REST-API-Key') != API_KEY:
        return "ERROR", 403

    # Validate JWT
    jwt_token = request.headers.get('X-JWT-KWY')
    if not jwt_token or not validate_jwt(jwt_token):
        return "ERROR", 403

    # Validate JSON payload
    data = request.get_json()
    if not data:
        return "ERROR", 400

    # Extract and validate the required fields
    if 'message' in data and 'to' in data and 'from' in data and 'timeToLifeSec' in data:
        # Return the appropriate JSON response
        return jsonify({"message": f"Hello {data['to']} your message will be send"}), 200
    else:
        return "ERROR", 400

# Handle other HTTP methods
@app.route('/DevOps', methods=['GET', 'PUT', 'DELETE', 'PATCH'])
def handle_non_post():
    return "ERROR", 405

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
