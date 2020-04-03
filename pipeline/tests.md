# Testing with PyTest

To test an python app is necessary to use some test toll like nose or Pytest. Ins this example we use PyTest for simplicity.

## Writting the tests

Pytest searches for tests based on the naming convention in the test files:

1. Test cases are functions with name starting with `test_`

2. Test files should start with `test_`

3. Classes with tests should end with `_Tests`

All test cases should consist at least of an assertion

```python
def test_pass():
    assert True
```

## Configuring PyTest

If you want to use your own name convention or configure other properties you can do it by creating a `pytest.ini` in the root of the test folder.

In this example I just configure the junit report to generate files in the old format to be used on CI-CD tools

```ini
# content of pytest.ini
[pytest]
junit_family=legacy
```

## Test Requirements

Its a good practicie use a exclusive requiremts file for the testing because these tools should not be package together with the application.

So we create a second file called requirements-test.txt in the sample aplication folder.

```python
# Pytest dependency tree for pytest==5.4.1
attrs==19.3.0
importlib-metadata==1.5.0
more-itertools==8.2.0
packaging==20.3
pluggy==0.13.1
py==1.8.1
pyparsing==2.4.6
six==1.14.0
wcwidth==0.1.8
zipp==3.1.0

    pytest==5.4.1
```

The contents of this file are dependencies from the package `pytest` listed with the dependencies ccomming first and the dependants last.

## Dockerfile layer

On the Dockerfile we create a new layer reusing the requirement layer and naming it as test. Then we copy the app code and execute the tests:

```Dockerfile
FROM python:3.8-slim as requirements
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt


FROM requirements as test
COPY src /app
RUN mkdir /reports
WORKDIR /app
RUN pytest --junit-xml=/reports/unit.xml
```

The command who execute the tests is

```Dockerfile
RUN pytest --junit-xml=/reports/unit.xml
```

It calls the pytest packaging passing the option `--junit-xml` that generate a report in the given path.

The pytest command searches for python tests and find a simple test we added before.
