#!/usr/bin/env python3

from setuptools import find_packages, setup

setup(
    name="ssh-autoconfig",
    version="1.0",
    packages=find_packages(),
    scripts=[
        "bin/ssh-autoconfig"
    ],
    author="Frederik Möllers",
    author_email="ssh-autoconfig@die-sinlosen.de",
    description="Auto-configure ssh depending on the environment",
    license="GPL3",
    url="https://github.com/frederikmoellers/ssh-autoconfig",
)
