from flask import Flask, jsonify, request
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

@app.route('/api/hello', methods=['POST'])
def hello():
    data = request.get_json()
    name = data.get('name')
    greeting = f'Hello, {name}!'
    return jsonify({'greeting': greeting})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555)