FROM python:3.8-alpine as requirements

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install --compile --requirement requirements.txt && pip check

COPY . .



FROM requirements as test

RUN pip install --compile --requirement tests/requirements.txt && pip check

RUN pytest .



FROM python:3.8-alpine as production

COPY --from=requirements /usr/local /usr/local

COPY --from=requirements /app /app