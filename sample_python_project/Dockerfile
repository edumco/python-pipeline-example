FROM python:3.8.3-slim as requirements

COPY requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt


FROM requirements as code

COPY src /app

WORKDIR /app


FROM code as test

COPY requirements-test.txt /app/requirements-test.txt

RUN  pip install -r /app/requirements-test.txt

RUN mkdir /reports

RUN pytest --junit-xml=/reports/unit.xml


FROM python:3.8.3-slim as production

RUN useradd --create-home appuser

USER appuser

COPY --from=requirements /usr/local /usr/local

COPY --from=code /app /home/appuser/app

WORKDIR /home/appuser/app
