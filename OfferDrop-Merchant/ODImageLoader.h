//
//  ODImageLoader.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/11/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODConnection.h"

@class ODImageLoader;

@protocol ImageLoaderDelegate

-(void) imageLoadedSuccessfully:(ODImageLoader *)loader withImage:(UIImage *)image andIndexPath:(NSIndexPath *)indexPath;
-(void) imageLoadingFailed:(ODImageLoader *)loader atIndexPath:(NSIndexPath *)indexPath;

@end

@interface ODImageLoader : NSObject <ODConnectionDelegate>

@property (nonatomic, strong) id<ImageLoaderDelegate> delegate;
@property (nonatomic, strong) ODConnection * imageConnection;
@property (nonatomic, strong) NSIndexPath * indexPath;
@property (nonatomic) NSInteger imageWidth;

-(id) initWithDelegate:(id<ImageLoaderDelegate>)deleg;
-(void) loadImageWithURL:(NSString *)imgURL andIndexPath:(NSIndexPath *)indexPth andImageWidth:(NSInteger)width;

@end
