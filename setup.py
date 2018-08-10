from setuptools import setup

setup(
    name='robotframeworklibraries',
    version='1.0',
    description=(
        'Collection of Robot Framework Libraries '
    ),
    install_requires=[
        'selenium == 3.9.0',
        'urllib3',
        'python-dateutil >= 2.4.2, <= 2.4.3',
        'requests',
        'robotframework',
        'robotframework-lint',
        'robotframework-pabot',
        'robotframework-selenium2library >= 1.8.0, <= 3.2.0',
        'robotframework-extendedselenium2library >= 0.9, < 1.0',
        'robotframework-xvfb',
        'robotframework-httplibrary',
        'robotframework-requests',
        'robotframework-imaplibrary',
        'robotframework-faker',
        'robotframework-zoomba',
        'robotframework-ride',
        'sauceclient',
    ]
)
