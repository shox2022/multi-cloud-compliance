from flask import Flask, jsonify
from flask_cors import CORS
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import Base, Violation

# ─── App & DB Setup ────────────────────────────────────────────────────────────
app = Flask(__name__)
CORS(app)  # allow React dev server to talk to us

# SQLite in this same folder; creates violations.db if missing
engine = create_engine('sqlite:///violations.db', echo=False)
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)

# ─── Routes ────────────────────────────────────────────────────────────────────
@app.route('/api/violations')
def get_violations():
    session = Session()
    vs = session.query(Violation).order_by(Violation.timestamp.desc()).all()
    # return as a list of dicts
    return jsonify([
        {
            'time': v.timestamp.isoformat() + 'Z',
            'resource': v.resource,
            'message': v.message
        }
        for v in vs
    ])

if __name__ == '__main__':
    # make sure it listens on localhost:5000
    app.run(host='127.0.0.1', port=5000)
