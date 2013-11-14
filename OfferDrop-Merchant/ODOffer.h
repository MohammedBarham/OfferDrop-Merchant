//
//  ODOffer.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODOffer : NSObject

@property (nonatomic, strong) NSString * offerDetails;
@property (nonatomic, strong) NSString * offerImageURL;
@property (nonatomic) BOOL offerStatus;
@end
