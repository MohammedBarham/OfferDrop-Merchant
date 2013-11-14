//
//  ODImageUploader.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/13/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODImageUploader.h"
#import "ODConfig.h"
#import "ODApiURLGenerators.h"
#import "ODConstants.h"

@implementation ODImageUploader

@synthesize delegate, uploaderConnection, imageName;

-(id) initWithDelegate:(id<ODImageUploaderDelegate>)deleg
{
    self = [super init];
    if (self) {
        self.delegate = deleg;
    }
    return self;
}

-(void) uploadImage:(UIImage *)imageToUpload
{
    NSData * imageData = UIImageJPEGRepresentation(imageToUpload, 90);
    
    NSDate * nowDate = [NSDate date];
    NSInteger timeStampValue = [nowDate timeIntervalSince1970];
    
    self.imageName = [NSString stringWithFormat:@"{MERCHANT_ID}_%d.png", timeStampValue];
    
    NSString * imageUploadURL = [ODApiURLGenerators uploadImageURL];
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:imageUploadURL]];
    [request setHTTPMethod:@"POST"];
    
    //	 add some header info now
    //	 we always need a boundary when we post a file
    //	 also we need to set the content type

    //	 You might want to generate a random boundary.. this is just the same
    //	 as my output from wireshark on a valid html post
    //
    
    NSString *boundary = [NSString stringWithFormat:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //	 Create the body of the post
    
    NSMutableData *body = [NSMutableData data];

    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *tmpStr = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\"\r\n", self.imageName];
    [body appendData:[[NSString stringWithString:tmpStr] dataUsingEncoding:NSUTF8StringEncoding]];

    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    self.uploaderConnection = [[ODConnection alloc] initWithDelegate:self];
    [self.uploaderConnection startConnectionWithRequest:request];
    
}

#pragma mark - connection delegate
-(void)Connection:(ODConnection *)connection didFinishWithData:(NSMutableData *)responseData andResponseCode:(NSInteger)responseCode
{
    if (responseCode == HTTP_RESPONSE_CODE_OK || responseCode == HTTP_RESPONSE_CODE_ADDED) {
        [self.delegate imageUploadedSuscessfully:self WithURL:[NSString stringWithFormat:@"%@/%@", OD_IMAGEE_BASE_URL, self.imageName]];
    } else {
        [self.delegate imageuploadingFailed:self];
    }
}

-(void)Connection:(ODConnection *)connection didFailWitherror:(NSError *)error
{
    [self.delegate imageuploadingFailed:self];
}

@end
