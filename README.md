# Python Pipeline Example 🐍

Simple example of a pipeline on Docker to test your python code.

## Pipeline on a container

Although several pipeline solutions exist, they are too complex for small projects. With this solution you just need a Dockerfile.

You can put several stages to your pipeline:

- [Dependencies](pipeline/dependencies.md)

- [Tests](pipeline/tests.md)

- [Code lint](pipeline/lint.md)

- [Static analisys](pipeline/static-analisys.md)

- [Report Publishing](pipeline/reports.md)

- [Automatic tag generation](pipeline/tagging.md)

In this repo i've add a very basic python project with only four elements: a requirements file, a Dockerfile, a pytest.ini file and a simple python test that always pass.

### Sample test ✅

Our project does not have a software but we need at least a single test to prove that our test library is working, so we add a simple function with the name test-pass.py.

When the PyTest framework execute it will find the test by the name test\*.py

### Pytest configuration 💻

The PyTest configuration is used to define the root folder for the tests and to add options to PyTest. In this example it is used to disable a warning message when used with JUnit.

### Requirements file 📃

The requirements file lists all the project dependencies. This allows the pip (Python package manager) to download the correct versions of wich dependency. [See the dependencies stage to more details.](pipeline/dependencies.md)

### Dockerfile 🐳

The Dockerfile uses the multistage build feature to create the pipeline. Each stage can be executed by a diferent image and only the output artifacts will be reused.

You can put a lint image and analize the code and on the next stage publish the results using another image. The previous image is completed descarted and does not interfere in the final production image. See the example below:

    from cytopia/docker-pylint:latest as linter

    COPY  src /data

    RUN pylint /data

    ...

    from python:3.8-slim as production

    COPY  src /app

    USER app

    CMD["python", "/app/start.py"]

In this Dockerfile we are using two images. The lint image and a python for production. The images are both used to create containers but only the last image will be used to create the final image.

You can use multiples images to create a more complex pipeline and every time you build the image youll have a new valid version.

If any stage of the build fails (test fail, instalation fails...) the entire build will fail and you have to fix it before continue. So if your image has a successful build it means that it passes all stages.

In the end of the build a hash code is generated uniquely identifying your build. Another way of identifying is by using user tags so every new successful build can receive a meaninful name like:

    myuser/project-name:1.45-ubuntu-1804
    myuser/project-name:1.45-ubuntu-1604
    myuser/project-name:1.44-ubuntu-1804
    myuser/project-name:1.44-ubuntu-1604

As you can see the tag (after the :) can be compose by any revelant info to identify the exact version. In the example above we have two versions of the app (1.45 and 1.44) installed on two versions of ubuntu (1604 and 1804).

If we need to add a minor fix to the 1.45 version them we just build another two images image:

    myuser/project-name:1.45.1-ubuntu-1804
    myuser/project-name:1.45.1-ubuntu-1604

    myuser/project-name:1.45-ubuntu-1804
    myuser/project-name:1.45-ubuntu-1604
    myuser/project-name:1.44-ubuntu-1804
    myuser/project-name:1.44-ubuntu-1604

All the other images still there and whenever you need it will be available and reproducible.
