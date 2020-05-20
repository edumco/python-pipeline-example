# Lint

## Choosing the rules

There are several sets of linting rules for every program language. For Python theese rules are defiened in a document [called PEP8](https://pep8.org/).

The more rules better results, so a good start point is the Pylama package that combines several linters together.

To understand python linterd I suggest you to read the article:

[Python Code Quality: Tools & Best Practices](https://realpython.com/python-code-quality/#style-guides)

See the example below:

```dockerfile
FROM cytopia/docker-pylint:latest as linter

COPY  s  rc /data

RUN pylint /data

...

FROM python:3.8-slim as production

COPY  src /app

USER app

CMD["python", "/app/start.py"]
```

In this Dockerfile we are using two images. The lint image and a python for production. The images are both used to create containers but only the last image will be used to create the final image.
