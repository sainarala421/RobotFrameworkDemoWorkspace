*** Settings ***
Documentation     Resource file for product cart.
Resource          ${DEMO4_VARIABLE_DIR}demo_product_cart_constants.robot

*** Keywords ***
User Adds "${e_PRODUCT_QUANTITY}" "${e_PRODUCT_TYPE}" Products To Cart
    User Clicks "${e_PRODUCT_TYPE} Menu"

    ${t_productCount}=    Get Matching Locator "${FEATURED_PRODUCTS}" Count
    : FOR    ${INDEX}    IN RANGE    0    ${e_PRODUCT_QUANTITY}
    \    ${randomInteger} =    Evaluate    random.randint(1, ${t_productCount} - 1)    modules=random
    \    Comment    Scroll, focus and mouser over to element
    \    Scroll Element Into View    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Focus    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Mouse Over    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Comment    Click the add to cart button then click Continue shopping
    \    Run And Wait Until Keyword Succeeds
    ...    Click Element    ${FEATURED_PRODUCTS}:eq(${randomInteger}) .ajax_add_to_cart_button
    \    Focus And Click Element "${CONTINUE_SHOPPING_BUTTON}"
