//
//  ODCalculations.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODCalculations : NSObject

+(float) GetOfferDetailsHeightForMessage:(NSString *)message forFontSize:(float)fontSize ToMaxSize:(CGSize)maxSize;

@end
