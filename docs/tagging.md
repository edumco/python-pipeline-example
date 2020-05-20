# Tagging

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
