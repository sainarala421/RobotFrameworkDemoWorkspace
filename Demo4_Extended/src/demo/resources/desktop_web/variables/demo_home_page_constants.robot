*** Variables ***
${BANNER}                                 css=#header .banner
${BANNER_IMAGE}                           ${BANNER} img.img-responsive
${NAVIGATION}                             css=.nav .row
${NAVIGATION_SHOP_PHONE}                  ${NAVIGATION} .shop-phone
${NAVIGATION_CONTACT_LINK}                id=contact-link
${NAVIGATION_USER_INFO}                   ${NAVIGATION} .header_user_info
@{HOME_PAGE_HEADER_CORE_ELEMENTS_LIST}    ${BANNER_IMAGE}    ${NAVIGATION_SHOP_PHONE}    ${NAVIGATION_CONTACT_LINK}
...                                       ${NAVIGATION_USER_INFO}

${LOGO}                                   css=.logo
${SEARCH_BAR}                             css=.search_query
${SEARCH_BUTTON}                          css=.button-search
@{SEARCH_CORE_ELEMENTS_LIST}              ${SEARCH_BAR}    ${SEARCH_BUTTON}

${SHOPPING_CART}                          css=.shopping_cart
${SHOPPING_CART_QUANTITY}                 ${SHOPPING_CART} .ajax_cart_quantity
${SHOPPING_CART_EMPTY}                    ${SHOPPING_CART} .ajax_cart_no_product
@{SHOPPING_CART_CORE_ELEMENTS_LIST}       ${SHOPPING_CART}    ${SHOPPING_CART_EMPTY}

${WOMEN_SUBMENU}                           css=a[title="Women"]
${DRESSES_SUBMENU}                         css=a[title="Dresses"]
${TSHIRTS_SUBMENU}                         css=a[title="T-shirts"]
${HOME_PAGE_SUBMENU_CORE_ELEMENTS_LIST}    ${WOMEN_SUBMENU}    ${DRESSES_SUBMENU}    ${TSHIRTS_SUBMENU}

${HOME_PAGE_SLIDER}                       id=homepage-slider
${HOME_PAGE_CONTENT}                      id=htmlcontent_top
@{HOME_PAGE_SLIDER_CORE_ELEMENTS_LIST}    ${HOME_PAGE_SLIDER}    ${HOME_PAGE_CONTENT}

${HOME_PAGE_TABS}                         css=#home-page-tabs
${HOME_PAGE_POPULAR_MENU}                 ${HOME_PAGE_TABS} .homefeatured
${HOME_PAGE_BEST_SELLERS_MENU}            ${HOME_PAGE_TABS} .blockbestsellers
@{HOME_PAGE_SLIDER_CORE_ELEMENTS_LIST}    ${HOME_PAGE_POPULAR_MENU}    ${HOME_PAGE_BEST_SELLERS_MENU}

${FEATURED_PRODUCTS_LIST}                 id=homefeatured
${PRETASHOPS_LINKS}                       id=htmlcontent_home
${FACEBOOK_LINK}                          id=facebook_block
@{HOME_PAGE_LINKS}                        ${FEATURED_PRODUCTS_LIST}    ${PRETASHOPS_LINKS}    ${FACEBOOK_LINK}

${CMS_INFO_BLOCK}                         css=#cmsinfo_block
${COME_VISIT_US_BLOCK_FIRST_COLUMN}       ${CMS_INFO_BLOCK} .col-xs-6:nth-child(1)
${COME_VISIT_US_BLOCK_SECOND_COLUMN}      ${CMS_INFO_BLOCK} .col-xs-6:nth-child(2)
${COME_VISIT_US_BLOCK}                    ${CMS_INFO_BLOCK} .col-xs-6:nth-child(1) li:nth-child(1)
${CALL_US_BLOCK}                          ${CMS_INFO_BLOCK} .col-xs-6:nth-child(1) li:nth-child(2)
${HOW_TO_PAY_DUES_BLOCK}                  ${CMS_INFO_BLOCK} .col-xs-6:nth-child(1) li:nth-child(3)
${SELENIUM_FRAMEWORK_BUTTON}              ${CALL_US_BLOCK} a.btn
@{CMSINFO_CORE_ELEMENTS_LIST}             ${COME_VISIT_US_BLOCK}    ${COME_VISIT_US_BLOCK}    ${CALL_US_BLOCK}
...                                       ${HOW_TO_PAY_DUES_BLOCK}    ${SELENIUM_FRAMEWORK_BUTTON}
...                                       ${COME_VISIT_US_BLOCK_SECOND_COLUMN}

${EDITORIAL_BLOCK}                        id=editorial_block_center

${NEWS_LETTER_TEXT_FIELD}                 id=newsletter-input
${NEWS_LETTER_SUBMIT_BUTTON}              css=button[name="submitNewsletter"]
@{NEWS_LETTER_CORE_ELEMENTS_LIST}         ${NEWS_LETTER_TEXT_FIELD}    ${NEWS_LETTER_SUBMIT_BUTTON}

${SOCIAL_BLOCK}                           css=#social_block
${FACEBOOK_FOLLOW_BUTTON}                 ${SOCIAL_BLOCK} .facebook
${TWITTER_FOLLOW_BUTTON}                  ${SOCIAL_BLOCK} .twitter
${YOUTUBE_FOLLOW_BUTTON}                  ${SOCIAL_BLOCK} .youtube
${GOOGLEPLUS_FOLLOW_BUTTON}               ${SOCIAL_BLOCK} .google-plus
@{SOCIAL_BLOCK_CORE_ELEMENTS_LIST}        ${FACEBOOK_FOLLOW_BUTTON}    ${TWITTER_FOLLOW_BUTTON}
...                                       ${YOUTUBE_FOLLOW_BUTTON}    ${GOOGLEPLUS_FOLLOW_BUTTON}

${FOOTER_BLOCK_FIRST_COLUMN}              jquery=section.footer-block:eq(0)
${FOOTER_BLOCK_SECOND_COLUMN}             jquery=section.footer-block:eq(1)
${FOOTER_BLOCK_THIRD_COLUMN}              jquery=section.footer-block:eq(2)
${FOOTER_BLOCK_FOURTH_COLUMN}             jquery=section.footer-block:eq(3)
${CATEGORY_LINK}                          ${FOOTER_BLOCK_FIRST_COLUMN} a:contains("Women")
${SPECIALS_LINK}                          ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Specials")
${NEW_PRODUCTS_LINK}                      ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("New products")
${SPECIALS_LINK}                          ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Best sellers")
${BEST_SELLERS_LINK}                      ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Our stores")
${CONTACT_US_LINK}                        ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Contact us")
${TAC_LINK}                               ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Terms and conditions of use")
${ABOUT_US_LINK}                          ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("About us")
${SITEMAP_LINK}                           ${FOOTER_BLOCK_SECOND_COLUMN} a:contains("Sitemap")
${MY_ORDERS_LINK}                         ${FOOTER_BLOCK_THIRD_COLUMN} a:contains("My orders")
${MY_CREDIT_SLIPS_LINK}                   ${FOOTER_BLOCK_THIRD_COLUMN} a:contains("My credit slips")
${MY_ADDRESSES_LINK}                      ${FOOTER_BLOCK_THIRD_COLUMN} a:contains("My addresses")
${MY_PERSONAL_INFO_LINK}                  ${FOOTER_BLOCK_THIRD_COLUMN} a:contains("My personal info")
${SELENIUM_SUPPORT_EMAIL}                 ${FOOTER_BLOCK_FOURTH_COLUMN} a:contains("support@seleniumframework.com")
@{FOOTER_LINKS_CORE_ELEMENTS_LIST}        ${CATEGORY_LINK}    ${SPECIALS_LINK}    ${NEW_PRODUCTS_LINK}
...                                       ${SPECIALS_LINK}    ${ABOUT_US_LINK}    ${CONTACT_US_LINK}
...                                       ${TAC_LINK}    ${CATEGORY_LINK}    ${SITEMAP_LINK}
...                                       ${MY_ORDERS_LINK}    ${MY_CREDIT_SLIPS_LINK}    ${MY_ADDRESSES_LINK}
...                                       ${MY_PERSONAL_INFO_LINK}
${FOOTER_BOTTOM}                          css=.bottom-footer
@{FOOTER_CORE_ELEMENTS_LIST}              @{FOOTER_LINKS_CORE_ELEMENTS_LIST}    ${FOOTER_BOTTOM}

@{HOME_PAGE_CORE_ELEMENTS_LIST}           @{HOME_PAGE_HEADER_CORE_ELEMENTS_LIST}    @{SEARCH_CORE_ELEMENTS_LIST}
...                                       @{SHOPPING_CART_CORE_ELEMENTS_LIST}    @{HOME_PAGE_SLIDER_CORE_ELEMENTS_LIST}
...                                       @{HOME_PAGE_LINKS}    @{CMSINFO_CORE_ELEMENTS_LIST}    ${EDITORIAL_BLOCK}
...                                       @{NEWS_LETTER_CORE_ELEMENTS_LIST}    @{SOCIAL_BLOCK_CORE_ELEMENTS_LIST}
...                                       @{FOOTER_CORE_ELEMENTS_LIST}

