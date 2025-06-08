import sys
import json
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from models import Base, Violation

# Point at your SQLite DB file; it will be created on first run
engine = create_engine('sqlite:///violations.db')
Base.metadata.create_all(engine)
Session = sessionmaker(bind=engine)

def main():
    session = Session()

    # Read JSON array of strings (from stdin or first CLI arg)
    raw = sys.stdin.read() or sys.argv[1]
    violations = json.loads(raw)

    for msg in violations:
        # Split off the resource name vs. the rest of the message
        parts = msg.split(" ", 1)
        resource = parts[0]
        text = parts[1] if len(parts) > 1 else ""

        v = Violation(
            timestamp=datetime.utcnow(),
            resource=resource,
            message=text
        )
        session.add(v)

    session.commit()

if __name__ == "__main__":
    main()
