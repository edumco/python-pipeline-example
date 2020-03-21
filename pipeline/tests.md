# Tests

The most essencial step is the test

    FROM python:3.8-slim as requirements
    COPY requirements.txt /tmp/requirements.txt
    RUN pip install -r /tmp/requirements.txt


    FROM requirements as unittests
    COPY src /app
    RUN mkdir /reports
    WORKDIR /app
    RUN pytest test-pass.py --junit-xml=/reports/unit.xml
