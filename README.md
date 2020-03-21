# Python Pipeline Example 🐍

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/edumco/python-pipeline-example)

Simple example of a pipeline on Docker to test your python code.

## Pipeline on a container

Although several pipeline solutions exist, they are too complex for small projects. With this solution you just need a Dockerfile.

### Implementation

In this repo i've add a very basic python project with only four elements: a requirements file, a Dockerfile, a pytest.ini file and a simple python test that always pass.

#### 1. Requirements file 📃

The requirements file lists all the project dependencies. This allows the pip (Python package manager) to download the correct versions of wich dependency. [See the dependencies stage to more details.](pipeline/dependencies.md)

#### 2. Sample test ✅

Our project does not have a software but we need at least a single test to prove that our test library is working, so we add a simple function with the name test-pass.py.

When the PyTest framework execute it will find the test by the name test\*.py

#### Pytest configuration 💻

The PyTest configuration is used to define the root folder for the tests and to add options to PyTest. In this example it is used to disable a warning message when used with JUnit.

#### Dockerfile 🐳

The Dockerfile uses the multistage build feature to create the pipeline. Each stage can be executed by a diferent image and only the output artifacts will be reused.

## The pipeline stages

You can put several stages to your pipeline:

- [Dependencies](pipeline/dependencies.md)

- [Static analisys](pipeline/static-analisys.md)

- [Tests](pipeline/tests.md)

- [Code lint](pipeline/lint.md)

- [Report Publishing](pipeline/reports.md)

- [Automatic tag generation](pipeline/tagging.md)
