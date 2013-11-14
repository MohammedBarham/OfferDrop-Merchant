//
//  ODCalculations.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODCalculations.h"
#import "ODFonts.h"

@implementation ODCalculations

+(float) GetOfferDetailsHeightForMessage:(NSString *)message forFontSize:(float)fontSize ToMaxSize:(CGSize)maxSize
{
    
    CGRect labelRect = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:OD_MAIN_FONT_NAME size:fontSize]} context:nil];
    
    NSLog(@"size %@", NSStringFromCGSize(labelRect.size));
    return labelRect.size.height;
}
@end
