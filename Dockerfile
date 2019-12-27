FROM python:3.7-slim as base

COPY requirements.txt /tmp/requirements.txt

RUN mkdir /install

RUN pip install -r /tmp/requirements.txt



FROM base as unittests

COPY src /app

RUN mkdir /reports

WORKDIR /app

RUN pytest test-pass.py --junit-xml=/reports/unit.xml



FROM python:3.7-slim as production

COPY --from=base /usr/local /usr/local

RUN useradd --create-home appuser

USER appuser

COPY --from=unittests /app /home/appuser/app

WORKDIR /home/appuser/app

CMD ["python", "--version"]
