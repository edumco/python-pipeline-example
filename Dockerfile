FROM python:3.8-alpine as requirements

COPY requirements.txt /app/requirements.txt

RUN pip install --compile --requirement /app/requirements.txt && pip check


FROM requirements as test

COPY tests/requirements.txt /app/tests/requirements.txt

RUN pip install --compile --requirement /app/tests/requirements.txt && pip check

COPY . /app

WORKDIR /app 

RUN pytest -n 4

RUN pylama --verbose --linters pydocstyle,pycodestyle,pyflakes,pylint tests/




FROM python:3.8-alpine as production

COPY --from=requirements /usr/local /usr/local

COPY --from=requirements /app /app
