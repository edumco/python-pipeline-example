# Python Pipeline Example 🐍

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/edumco/python-pipeline-example)

Simple example of a pipeline on Docker to test your python code.

## Pipeline on a container

Although several pipeline solutions exist, they are too complex for small projects. With this solution you just need a Dockerfile.

### Implementation

In this repo i've add a very basic python project with only four elements: a requirements file, a Dockerfile, a pytest.ini file and a simple python test that always pass.

#### Requirements file 📃

The requirements file lists all the project dependencies. This allows the pip (Python package manager) to download the correct versions of wich dependency. [See the dependencies tutorial to more details.](pipeline/dependencies.md)

#### Sample test ✅

Our project does not have a software but we need at least a single test to prove that our test library is working, so we add a simple function with the name test-pass.py.

When the PyTest framework execute it will find the test by the name test\*.py

#### Pytest configuration 💻

The PyTest configuration is used to define the root folder for the tests and to add options to PyTest. In this example it is used to disable a warning message when used with JUnit.

#### Dockerfile 🐳

The Dockerfile uses the multistage build feature to create the pipeline. Each stage can be executed by a diferent image and only the output artifacts will be reused.

## The pipeline stages

You can put several stages to your pipeline, but the most common stages are:

| 1     | 2    | 3    | 4        | 5      | 6   |
| ----- | ---- | ---- | -------- | ------ | --- |
| Build | Test | Lint | Analisys | Report | Tag |

### Build

Python does not have a build stage but has a pre-execution stage of build the dependency tree by download packages and resolving sub dependencies.

[Access the "Building the Dependency Tree" tutorial](pipeline/dependencies.md)

### Test

After gather all the packages now we can test our application. The most common type of tests is the unit test but to achieve a good code quality we should add other types of test as well.

[Access the "Testing with PyTest" tutorial](pipeline/tests.md)

### Lint

When the tests are passing is time to check the code checking if guidelines for the code style are being followed. A consistent code style helps with readability and mantainece.

- [Access the Lint tutorial](pipeline/lint.md)

### Analisys

With a consistent code base its easier to find code patterns that could lead to errors or make your code prone to atacks. Another advantage is the complexity management.

- [Access the Static Analisys tutorial](pipeline/static-analisys.md)

### Report

With all quality checks done it is necessary to comunicate the results. Its possible to send a message to external tools notifying the complete result.

- [Access the Report tutorial](pipeline/reports.md)

### Tag

Now that all the steps complete we can define that this build is production ready and should receive a tag with its version number using some of the common tag practicies used world-wide.

- [Access the Tag tutorial](pipeline/tagging.md)
