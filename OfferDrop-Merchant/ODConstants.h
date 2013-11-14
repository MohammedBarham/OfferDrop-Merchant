//
//  ODConstants.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/3/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

// Facebook app constatns
#define FACEBOOK_APP_ID @"253364144813323"
#define FACEBOOK_APP_SECRET @"5405691c2b3d3b6e176de09764f83527"
#define FACEBOOK_ID_IMAGE @"https://graph.facebook.com/_FACEBOOK_ID_/picture?type=square&width=200&height=200"
#define FACEBOOK_LOGIN_PERMISION [NSArray arrayWithObjects:@"email", nil]

// save user email and password for next login
#define LOGGED_IN_USER_EMAIL_KEY @"logged in user email key"
#define LOGGED_IN_USER_PASSWORD_KEY @"logged in user password key"
#define MERCHANT_WELCOME_MESSAGE_KEY @"merchant welcome notification key"
#define MERCHANT_LOGO_KEY @"merchant logo key"
#define MERCHANT_NAME_KEY @"merchant name key"

// notifications name constants
#define kNotificationNameLoadUserInfoKey @"LoadUserInfoKey"
#define kNotificationNameShowLoadingViewOnSignUpView @"ShowLoadingViewOnSignUpView"
#define kNotificationNameLoadMerchantAddressOnSignUp @"LoadMerchantAddressOnSignUp"
#define kNotificationNameLoadMerchantInfoInLeftMenu @"Load Merchant info in left menu view"

// HTTP Response codes
#define HTTP_RESPONSE_CODE_OK 200
#define HTTP_RESPONSE_CODE_ADDED 201
#define HTTP_RESPONSE_CODE_BAD_REQUEST 400
#define HTTP_RESPONSE_CODE_NEED_AUTHINTICATION 401
#define HTTP_RESPONSE_CODE_CONFLICT 403
#define HTTP_RESPONSE_CODE_NOT_FOUND 404
#define HTTP_RESPONSE_CODE_SERVER_INTERNAL_ERROR 500
#define HTTP_RESPONSE_CODE_SERVER_DOWN 503
#define HTTP_RESPPNSE_CODE_UNSUPPORTED_VERSION 505

typedef enum {
    kParentTypeActiveOffersView = 0,
    kParentTypeOffersStatsView
} ParentViewType;