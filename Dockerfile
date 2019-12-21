FROM python:3.7-slim

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install -r /tmp/requirements.txt

RUN useradd --create-home appuser

WORKDIR /home/appuser

USER appuser

CMD ["python", "--version"]
