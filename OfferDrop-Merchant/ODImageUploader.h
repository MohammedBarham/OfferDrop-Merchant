//
//  ODImageUploader.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/13/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODConnection.h"

@class ODImageUploader;

@protocol ODImageUploaderDelegate

-(void) imageUploadedSuscessfully:(ODImageUploader *)imageLoader WithURL:(NSString *)imageURL;
-(void) imageuploadingFailed:(ODImageUploader *)imageUploader;
@end

@interface ODImageUploader : NSObject <ODConnectionDelegate>

@property (nonatomic, strong) ODConnection * uploaderConnection;
@property (nonatomic, strong) id<ODImageUploaderDelegate> delegate;
@property (nonatomic, strong) NSString * imageName;

-(id) initWithDelegate:(id<ODImageUploaderDelegate>)deleg;

-(void) uploadImage:(UIImage *)imageToUpload;

@end
