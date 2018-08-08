*** Settings ***
Documentation     Resource file for product cart.
Resource          ${DEMO4_VARIABLE_DIR}demo_product_cart_constants.robot

*** Keywords ***
User Adds "${e_PRODUCT_QUANTITY}" Random "${e_PRODUCT_TYPE}" Products To Cart
    User Clicks "${e_PRODUCT_TYPE} Menu"
    Comment    Count the number of products or options.
    ${t_productCount}=    Get Matching Locator "${FEATURED_PRODUCTS}" Count
    Comment    Add the specified number of random products to cart.
    : FOR    ${INDEX}    IN RANGE    0    ${e_PRODUCT_QUANTITY}
    \    ${randomInteger} =    Evaluate    random.randint(1, ${t_productCount} - 1)    modules=random
    \    Comment    Scroll, focus and mouser over to element
    \    Scroll Element Into View    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Focus    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Mouse Over    ${FEATURED_PRODUCTS}:eq(${randomInteger})
    \    Comment    Click the add to cart button then click Continue shopping
    \    Focus And Click Element "${FEATURED_PRODUCTS}:eq(${randomInteger}) .ajax_add_to_cart_button"
    \    Focus And Click Element "${CONTINUE_SHOPPING_BUTTON}"

User Adds A "${e_PRODUCT_PRICE}" "${e_PRODUCT_NAME}" In "${e_PRODUCT_TYPE}" Product
    Comment    Set the product type index number
    ${t_productType}=    Set Variable If    '${e_PRODUCT_TYPE.lower()}' == 'home page popular'
    ...    0    1
    Comment    Set the locator value.
    ${t_product}=    Set Variable
    ...    jquery=h5:has(a[title="${e_PRODUCT_NAME}"]) ~ div.content_price:has(span:contains("${e_PRODUCT_PRICE}")):eq(${t_productType})
    Comment    Add product to cart keywords.
    User Clicks "${e_PRODUCT_TYPE} Menu"
    Scroll Element Into View    ${t_product}
    Focus    ${t_product}
    Mouse Over    ${t_product}
    Focus And Click Element "${t_product} ~ ${ADD_TO_CART_BUTTON}"
