*** Keywords ***
User Adds "${e_PRODUCT_QUANTITY}" "${e_PRODUCT_TYPE}" Products To Cart
    User Clicks "${e_PRODUCT_TYPE} Menu"

    ${t_productCount}=    Get Matching Locator "${FEATURED_PRODUCTS}" Count
    : FOR    ${INDEX}    IN RANGE    0    ${e_PRODUCT_QUANTITY}
    \    ${randomInteger} =    Evaluate    random.randint(1, ${t_productCount} - 1)    modules=random
    \    Focus    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Mouse Over    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Run And Wait Until Keyword Succeeds
    ...    Click Element    ${FEATURED_PRODUCTS}:eq(${randomInteger}) .ajax_add_to_cart_button
    \    Focus And Click Element "${CONTINUE_SHOPPING_BUTTON}"
