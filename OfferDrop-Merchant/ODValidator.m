//
//  ODValidator.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/4/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//


#import "ODValidator.h"

@implementation ODValidator
+(BOOL) isEmailAddressValid:(NSString *)emailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isEmailMatchesRegex = [emailTest evaluateWithObject:emailAddress];
    return isEmailMatchesRegex;
}

+(BOOL) isPhoneNumberValid:(NSString *) phoneNumber
{
    NSString *phoneRegex = @"^(?:\\+?1[-. ]?)?\\(?([2-9][0-8][0-9])\\)?[-. ]?([2-9][0-9]{2})[-. ]?([0-9]{4})$";
    NSPredicate *phoneTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isPhoneMatchesRegex = [phoneTest evaluateWithObject:phoneNumber];
    return isPhoneMatchesRegex;

}

+(UIImage *) ResizeImage:(UIImage *)img toSize:(NSInteger)newSize
{
    UIImage * resizedImage = img;
    if (resizedImage.size.width > newSize || resizedImage.size.width > newSize)
    {
        if(resizedImage.size.height > resizedImage.size.width)
        {
            CGSize itemSize = CGSizeMake(newSize* (img.size.width/img.size.height),  newSize);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [resizedImage drawInRect:imageRect];
            resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        else
        {
            CGSize itemSize = CGSizeMake( newSize,newSize* (img.size.height/img.size.width));
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [resizedImage drawInRect:imageRect];
            resizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }
    
    return resizedImage;
}

+(BOOL) CheckInternetReachability
{
    return YES;
}

@end
