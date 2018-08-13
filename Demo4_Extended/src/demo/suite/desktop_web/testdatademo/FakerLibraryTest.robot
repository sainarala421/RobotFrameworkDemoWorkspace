*** Settings ***
Documentation        [DEMO] This test suite should test the test data generation using the faker library.
...                  run via:  `pybot -A argument_file.robot -i FakerLibraryTest .`
Force Tags           FakerLibraryTest    Demo    FUNCTIONALITY    LOW
Test Setup           Log Environment Details In Suite Documentation
Resource             ${GLOBAL_RESOURCES_FILE_PATH}libraries.robot

*** Test Cases ***
Generate Names
    ${firstName}=    First Name Female
    ${lastName}=    Last Name
    Log    ${firstName} ${lastName}

Generate Address
    ${streetAdd}=    Street Address
    ${secondaryAdd}=    Secondary Address
    ${stateAdd}=    Street Address
    ${postCode}=    Postcode
    Log    ${streetAdd} ${secondaryAdd} ${stateAdd} ${postCode}
