Robot Framework Test Suites Demo
======================================

This repository contains our entire Robot Framework Demo workspace
the covering the following:

  - Basic - bare bones robot framework script
  - Refactored - separating the variables, keywords into different .robot files
  - Composite - creating sub directories for variables, custom libraries and creating argument file to contain the variables
  - Extended - extending robot framework for jenkins, report portal, docker-selenium

Directory Structure
-------------------
`common` contains custom Robot Framework libraries and keywords that will be
used by the test suites.

`externals` contains extensions for external libraries by for the development /
deployment workflow but not by Robot Framework itself.

`src` contains the actual Robot Framework test suites.

`test_runner` contains helper scripts for running the test suites.

For more information on the directory structure, especially how tests are
organized within the `src` directory.

Setup
-----
Clone this repository to your local directory.
Open a terminal and cd to `RobotFrameworkDemoWorkspace` where setup.py is located.
Run the following in the terminal:

```bash
pip install -e .
```

Running Tests
-------------

Tests must be invoked to include the `argument_file.txt` found at the
top-level directory. To run a particular test suite:

```bash
pybot --argumentfile argument_file.txt --suite ContestInfoAvailabilityTest src/
```

Tests may also be filtered using tags defined in a test suite's `Default Tags`
setting table:

```bash
pybot --argumentfile argument_file.txt --include CONTEST src/
```
