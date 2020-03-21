# Lint

You can put a lint image and analize the code and on the next stage publish the results using another image. The previous image is completed descarted and does not interfere in the final production image. See the example below:

    FROM cytopia/docker-pylint:latest as linter

    COPY  src /data

    RUN pylint /data

    ...

    FROM python:3.8-slim as production

    COPY  src /app

    USER app

    CMD["python", "/app/start.py"]

In this Dockerfile we are using two images. The lint image and a python for production. The images are both used to create containers but only the last image will be used to create the final image.
