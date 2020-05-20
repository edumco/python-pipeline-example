# Python Pipeline Example 🐍

Simple Docker pipeline to test your python code.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Build Status](https://travis-ci.com/edumco/python-pipeline-example.svg?branch=master)](https://travis-ci.com/edumco/python-pipeline-example)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/edumco/python-pipeline-example)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4c67f0e9fbd14497be3a2aaca064a6dc)](https://www.codacy.com/manual/edumco/python-pipeline-example?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=edumco/python-pipeline-example&amp;utm_campaign=Badge_Grade)

## About

Although several pipeline solutions exist, they are too complex for small projects. With this solution you just need a Dockerfile.

## Features

In this repo i've add a very basic python project with only four elements: a requirements file, a Dockerfile, a pytest.ini file and a simple python test that always pass.

You can put several stages to your pipeline, but the most common stages are:

| 1     | 2    | 3    | 4        | 5      | 6   |
| ----- | ---- | ---- | -------- | ------ | --- |
| Build | Test | Lint | Analisys | Report | Tag |

[Build](docs/dependencies.md): Downloads and build dependencies.

[Test](docs/tests.md): Executes all tests found.

[Lint](docs/lint.md): Checks code style and format.

[Analisys](docs/static-analisys.md): Checks for bad code practicies.

[Report](docs/reports.md): Exports the results to archiving.

[Tag](docs/tagging.md): Adds a unique identifier to the version.

## Installation

1. Clone or download this repository.

2. Move your code to this new structure or vice versa.

3. Make sure the `Dockerfile` is on project root folder.

4. Update the requiments with your dependencies or create your list of requirements. [See the dependencies tutorial to more details.](docs/dependencies.md)

5. Make sure the name patterns on `pytest.ini`

6. Make sure you have at least one passing test (there's one in test-pass.py)

7. In `Dockerfile` rename the `src` folder following your project organizaziton.

## Usage

Execute the docker build command

```bash
docker build -t your-docker-user/projetc-name:tag .
```

If every step works correctly the command `docker images` is going to list your newly created image.

If something goes wrong youll be promptly warned.

## License

[GNU General Public License v3.0](LICENSE)
