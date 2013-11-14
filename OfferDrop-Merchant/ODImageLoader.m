//
//  ODImageLoader.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODImageLoader.h"
#import "ODConfig.h"
#import "ODValidator.h"
#import "ODConstants.h"

@implementation ODImageLoader

@synthesize delegate, imageConnection, indexPath, imageWidth;

-(id) initWithDelegate:(id<ImageLoaderDelegate>)deleg
{
    self = [super init];
    if (self) {
        self.delegate = deleg;
    }
    return self;
}

-(void) loadImageWithURL:(NSString *)imgURL andIndexPath:(NSIndexPath *)indexPth andImageWidth:(NSInteger)width
{
    self.indexPath = indexPth;
    self.imageWidth = width;
    
    self.imageConnection = [[ODConnection alloc] initWithDelegate:self];
    [self.imageConnection startConnectionWithURL:imgURL andBody:nil andHttpMethod:@"GET" andTimeOut:OD_SERVER_TIME_OUT andContentType:nil];
}

#pragma mark - connection delegate

-(void)Connection:(ODConnection *)connection didFinishWithData:(NSMutableData *)responseData andResponseCode:(NSInteger)responseCode
{
    if (responseCode == HTTP_RESPONSE_CODE_OK)
    {
        DLog(@"image loaded");
        UIImage * img = [UIImage imageWithData:responseData];
        
        img = [ODValidator ResizeImage:img toSize:self.imageWidth];
        
        [self.delegate imageLoadedSuccessfully:self withImage:img andIndexPath:self.indexPath];
    }
    else
    {
        [self.delegate imageLoadingFailed:self atIndexPath:self.indexPath];
        DLog(@"image loading fail");
    }
}

-(void)Connection:(ODConnection *)connection didFailWitherror:(NSError *)error
{
    [self.delegate imageLoadingFailed:self atIndexPath:self.indexPath];
}

@end
