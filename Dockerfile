FROM python:3.9.5-alpine3.12 as requirements

USER nonroot

WORKDIR /app 

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt && pip check



FROM requirements as tests

COPY tests/requirements.txt tests/requirements.txt

RUN pip install -r tests/requirements.txt && pip check

COPY . /app

RUN python -m bandit --skip B101 -r tests

RUN pytest -n 4

RUN pylama --verbose --linters pydocstyle,pycodestyle,pyflakes tests/



FROM requirements as production

# Copy only the modules from the source
COPY module /module

WORKDIR /module

ENTRYPOINT [ "python", "main.py" ]
