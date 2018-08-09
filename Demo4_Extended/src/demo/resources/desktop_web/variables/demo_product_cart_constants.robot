*** Variables ***
${CART_CHECKOUT_MODAL}            css=#layer_cart
${PROCEED_TO_CHECKOUT_BUTTON}     ${CART_CHECKOUT_MODAL} span[title="Proceed to checkout"]
${CONTINUE_SHOPPING_BUTTON}       ${CART_CHECKOUT_MODAL} span[title="Continue shopping"]

${HOME_FEATURED_PRODUCT_PRICE}    jquery=.product-price
${HOME_FEATURED_PRODUCT_NAME}     jquery=#homefeatured .product-name
${MODAL_CART_PRODUCT_TITLE}       jquery=#layer_cart_product_title
${USER_CART_PRODUCT_TITLE}        jquery=.product-name a.cart_block_product_name

${ADD_TO_CART_BUTTON}             a[title="Add to cart"]
