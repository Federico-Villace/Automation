*** Settings ***
Documentation     Para evitar la recurrencia en cada caso de la función Close Browser se la ingresó en Test Teardown.
Test Teardown     Close All Browsers
Library           SeleniumLibrary

*** Variables ***
${browser}        Chrome
${user}           Admin
${password}       admin123

*** Test Cases ***
Ejercicio1
    Open Browser    http://google.com.ar    ${browser}
    Go To    https://neoris-ddc.github.io/testingautomation/selenium/basic.htm
    Go Back
    [Teardown]    Close Browser

Ejercicio 2
    Open Browser    http://google.com    ${browser}
    Go To    https://neoris-ddc.github.io/testingautomation/selenium/basic.htm
    Page Should Contain    Automatización con Selenium
    [Teardown]    Close Browser

Ejercicio 3
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/basic.htm    Chrome
    Maximize Browser Window
    Element Text Should Be    id:parrafo1    Parrafo 1
    Element Text Should Be    name:parrafo2    Parrafo 2
    Element Text Should Be    class:parrafo3    Parrafo 3
    Element Text Should Be    xpath:/html/body/section/p[4]    Parrafo 4
    [Teardown]    Close Browser

Ejercicio 4a
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/basic.htm    Chrome
    Element Text Should Be    id:parrafo1    Parrafo 2
    Element Text Should Be    name:parrafo2    Parrafo 2
    Element Text Should Be    class:parrafo3    Parrafo 3
    Element Text Should Be    xpath:/html/body/section/p[4]    Parrafo 4
    Capture Page Screenshot
    [Teardown]    Close Browser

Ejercicio 4b
    Open Browser    https://chromedriver.chromium.org/    ${browser}
    Scroll Element Into View    class:sites-system-link
    Sleep    2
    [Teardown]    Close Browser

Ejercicio 5
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/alerts.html    ${browser}
    Maximize Browser Window
    Click Button    id:show-alert
    Handle Alert
    Wait Until Element Is Visible    id:result
    Element Text Should Be    id:result-value    Alert
    [Teardown]    Close Browser

Ejercicio 6
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/alerts.html    ${browser}
    Maximize Browser Window
    Click Button    id:show-confirm
    Handle Alert    action=ACCEPT
    Wait Until Element Is Visible    id:result
    Element Text Should Be    id:result-value    OK
    [Teardown]    Close Browser

Ejercicio 7
    [Documentation]    La consigna del ejercicio 6 y 7 en el instructivo es la misma. En este caso se decidió probar el boton "Cancelar", y también que el resultado obtenido al presionarlo sea "Cancel".
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/alerts.html    ${browser}
    Maximize Browser Window
    Click Button    id:show-confirm
    Handle Alert    action=DISMISS
    Wait Until Element Is Visible    id:result
    Element Text Should Be    id:result-value    Cancel
    [Teardown]    Close Browser

Ejercicio 8
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/ajax.html    ${browser}
    Select From List By Value    id:make    Audi
    Wait Until Element Is Enabled    id:model    10
    Select From List By Value    id:model    A6
    Click Button    id:accept
    Wait Until Element Is Enabled    id:value    10
    Element Text Should Be    id:value    Audi-A6
    [Teardown]    Close Browser

Ejercicio 9a
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/drag_and_drop.html    ${browser}
    Mouse Down    id:draggable
    Mouse Up    id:droppable
    Element Text Should Be    id:droppable    Dropped
    [Teardown]    Close Browser

Ejercicio 9b
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/drag_and_drop.html    ${browser}
    Drag And Drop    id:draggable    id:droppable
    Element Text Should Be    id:droppable    Dropped
    [Teardown]    Close Browser

Ejercicio 10
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/selectable.html    ${browser}
    Click Element    xpath://*[@id="selectable"]/li[1]    CTRL
    Click Element    xpath://*[@id="selectable"]/li[3]    CTRL
    Click Element    xpath://*[@id="selectable"]/li[5]    CTRL
    Click Element    xpath://*[@id="selectable"]/li[7]    CTRL
    Element Text Should Be    id:select-result    \#1 \#3 \#5\ #7
    [Teardown]    Close Browser

Ejercicio 11
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/frames/index.html    ${browser}
    Maximize Browser Window
    Select Frame    name:content
    Click Element    xpath:/html/body/ul[1]/li[1]/a
    Click Element    xpath:/html/body/p/a
    Unselect Frame
    Select Frame    name:menu
    Click Element    xpath:/html/body/p[2]/a
    Unselect Frame
    Select Frame    name:content
    Element Text Should Be    xpath:/html/body/h1    Green Page
    [Teardown]    Close Browser

Ejercicio Login Invalido
    Open Browser    https://opensource-demo.orangehrmlive.com/    ${browser}
    Login    pepito    pepito123
    Wait Until Element Is Visible    id:spanMessage
    Element Should Contain    id:spanMessage    Invalid credentials
    [Teardown]    Close Browser

Ejercicio Login Valido
    Open Browser    https://opensource-demo.orangehrmlive.com/    ${browser}
    Login    Admin    admin123
    Wait Until Location Is    https://opensource-demo.orangehrmlive.com/index.php/dashboard
    [Teardown]    Close Browser

Ejercicio Intereses - Verificar contenidos un elemento
    [Documentation]    Al intentar seleccionar el radio button con la función "Select Radio Button" el test falla, por lo que se procedió a acceder al mismo mediante clicks utilizando al xpath correspondiente.
    Open Browser    https://neoris-ddc.github.io/testingautomation/selenium/interes.html    ${browser}
    Maximize Browser Window
    Input Text    id:amount    1000
    Input Text    name:rate    5
    Select From List By Value    name:rate_units    month
    Input Text    name:time    12
    Mouse Down    xpath://*[@id="interes-futuro"]/input[2]
    Mouse Up    xpath://*[@id="interes-futuro"]/input[2]
    Click Button    xpath://*[@id="interestForm"]/input
    Wait Until Element Is Visible    id:interest
    Element Text Should Be    id:interest    600
    [Teardown]    Close Browser

*** Keywords ***
Login
    [Arguments]    ${user}    ${password}
    Input Text    id:txtUsername    ${user}
    Input Password    id:txtPassword    ${password}
    Click Button    id:btnLogin
