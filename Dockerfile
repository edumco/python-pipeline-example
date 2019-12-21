FROM python:3.7-slim as base

COPY requirements.txt /tmp/requirements.txt

RUN mkdir /install

WORKDIR /install

RUN pip install --install-option="--prefix=/install" -r /tmp/requirements.txt



FROM python:3.7-slim as test

COPY --from=base /install /usr/local

RUN mkdir /reports

COPY src /app

RUN pytest --junit-xml=/reports

# publish or collect the results 



FROM python:3.7-slim as production

COPY --from=base /install /usr/local

RUN useradd --create-home appuser

USER appuser

COPY --from=test /app /home/appuser/app

WORKDIR /home/appuser/app

CMD ["python", "--version"]
