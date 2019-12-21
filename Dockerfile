FROM python:3.7-slim as base

COPY requirements.txt /tmp/requirements.txt

RUN mkdir /install

RUN pip install --install-option="--prefix=/install" -r /tmp/requirements.txt



FROM base as unittests

COPY src /app

RUN mkdir /reports

RUN pytest --junit-xml=/reports/unit.xml



FROM python:3.7-slim as production

COPY --from=base /install /usr/local

RUN useradd --create-home appuser

USER appuser

COPY --from=test /app /home/appuser/app

WORKDIR /home/appuser/app

CMD ["python", "--version"]
