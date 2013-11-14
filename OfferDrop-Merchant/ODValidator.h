//
//  ODValidator.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODValidator : NSObject

+(BOOL) isEmailAddressValid:(NSString *) emailAddress;

+(BOOL) isPhoneNumberValid:(NSString *) phoneNumber;

+(UIImage *) ResizeImage:(UIImage *)img toSize:(NSInteger)newSize;

+(BOOL) CheckInternetReachability;

@end
