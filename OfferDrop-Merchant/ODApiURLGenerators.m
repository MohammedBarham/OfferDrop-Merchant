//
//  ODApiURLGenerators.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/13/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODApiURLGenerators.h"
#import "ODConfig.h"

@implementation ODApiURLGenerators

+(NSString *) uploadImageURL
{
    NSString * uploadURL = [NSString stringWithFormat:@"%@/", OD_SERVER_URL];
    return uploadURL;
}
@end
