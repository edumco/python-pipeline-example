# Dependencies

## Choose the version

Its very important to pin the exact version when creating a container image.

    5.3.5 instead of 5.3

Otherwise when some dependency got updated pip will update your project ands this cause troubles that are hard to find.

Pip always uses the latest version within the limits you choose when describing the version:

Ex: Imagine a dependency that is on version 8.0

| Dependency  | Pip undertanding           | Result |
| ----------- | -------------------------- | ------ |
| name        | latest version             | 8.0    |
| name==5     | latest version ≧ 5.0 < 6.0 | 5.9.9  |
| name==5.3   | latest version ≧ 5.3 < 6.0 | 5.9.9  |
| name==5.3.5 | exact version              | 5.3.5  |

## Fixing dependency tree

If you use a dependency that dont fix its dependencies you'll still not getting a reproducible image.

Imagine a project that depends on "external-package" in version 3.2.1, its requirements would be like:

    external-package==3.2.1

But if we look at this package requirements we find

    ...
    six

This depency will change everytime pip finds a newer version greater than 0.8. By now this package is already on version 1.14 but you developed and tested your project on version 1.12 and cannot risk jump to the latest version now.

To fix this probyourlem you can freeze your dependency tree so you'll always get the same results. In the root of your project use the command:

    pip freeze > requirements.txt

This will print the exact versions of every pip package in a file that will look like this:

```python
asn1crypto==0.24.0
chardet==3.0.4
configparser==3.5.0b2
cryptography==2.6.1
...
six==1.12.0
```

Now you have total control over the packages that will be instaled on your container. You have a version that is greater than 0.8 so "external-package" depency is respected without the risk of a imcompatibility issue.

## Updating the versions

There are several services that alerts you of an update and even trigger your CI by applying a pull request updating your depencies, if all your tests passes you can upgrade the depencies more safely and keep your project more secure.

Using a CI on docker build you can also do the same. You just have to isolate the upgrades by testing and publishing a new image for every upgrade.

To see wich dependencies were updated you can use the following command:

    pip list --outdated

Resulting in a list like this:

    Package      Version Latest Type
    ------------ ------- ------ -----
    asn1crypto   0.24.0  1.3.0  wheel
    configparser 3.5.0b2 4.0.2  wheel
    cryptography 2.6.1   2.8    wheel
    dbus-python  1.2.12  1.2.16 sdist
    six          1.12.0  1.14.0 wheel

So for every item on this list you have to:

Upgrade the item

    pip install --upgrade NAME_OF_PACKAGE

Freeze the requirements

    pip freeze > requirements.txt

Test your build

    docker build my-dockerhub-user/my-project:$(VERSION)

Publish a new image version.

    docker push my-dockerhub-user/my-project:$(VERSION)

## Upgrading the pip itself

From time to time the pip gets updated and this can affect your dependency tree resolution. Verify the release notes before update your enviroment.
