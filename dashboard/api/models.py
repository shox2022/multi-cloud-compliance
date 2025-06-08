from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Violation(Base):
    __tablename__ = "violations"

    id = Column(Integer, primary_key=True)
    timestamp = Column(DateTime, nullable=False)
    resource = Column(String, nullable=False)
    message = Column(String, nullable=False)
