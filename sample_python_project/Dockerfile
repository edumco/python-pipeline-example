FROM python:3.8-slim as requirements

COPY requirements.txt /tmp/requirements.txt

RUN pip install -r /tmp/requirements.txt


FROM requirements as unittests

COPY src /app

RUN mkdir /reports

WORKDIR /app

RUN pytest test-pass.py --junit-xml=/reports/unit.xml


FROM python:3.8-slim as production

RUN useradd --create-home appuser

USER appuser

COPY --from=requirements /usr/local /usr/local

COPY --from=unittests /app /home/appuser/app

WORKDIR /home/appuser/app

CMD ["python", "--version"]
