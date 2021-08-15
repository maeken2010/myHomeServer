from flask import *
import psutil

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/api/ok")
def ok():
    return 1

@app.route("/api/monitor")
def monitor():
    cpu_percents = psutil.cpu_percent(interval=1, percpu=True)
    memory_percent = psutil.virtual_memory().percent
    return jsonify({
        "cpu_percents": cpu_percents,
        "memory_percent": memory_percent
    })
