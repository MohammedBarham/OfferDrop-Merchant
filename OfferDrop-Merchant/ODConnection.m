//
//  ODConnection.m
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import "ODConnection.h"
#import "ODConstants.h"

@implementation ODConnection

-(id) initWithDelegate:(id <ODConnectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

-(void) startConnectionWithURL:(NSString *)url andBody:(NSString *)body andHttpMethod:(NSString *)httpMethod andTimeOut:(NSInteger) timeOut andContentType:(NSString *)contentType
{
    // nsurl
    NSURL * nsurl=[NSURL URLWithString:url];
	
    // autoreleased request
	NSMutableURLRequest * theRequest = [[NSMutableURLRequest alloc] init];
    [theRequest setURL:nsurl];
    [theRequest setHTTPMethod:httpMethod];
    [theRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [theRequest setTimeoutInterval:timeOut];
    
    if (body != nil) {
        [theRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // connection to get nearby postse
	_connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
}

-(void) startConnectionWithRequest:(NSMutableURLRequest *)request
{
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void) cancelConnection
{
    [_connection cancel];
}

#pragma Mark -
#pragma Mark ConnectionCallBack

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
	_responseCode = [httpResponse statusCode];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(_responseData == nil) {
        _responseData = [[NSMutableData alloc] initWithData:data];
    } else {
        [_responseData appendData:data];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate Connection:self didFailWitherror:error];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_responseCode == HTTP_RESPPNSE_CODE_UNSUPPORTED_VERSION) {
        #warning Handle unsupported version for whole app
        // unsupported version handler
        [_delegate Connection:self didFinishWithData:_responseData andResponseCode:HTTP_RESPPNSE_CODE_UNSUPPORTED_VERSION];
        
    } else {
        [_delegate Connection:self didFinishWithData:_responseData andResponseCode:_responseCode];
    }
}


@end
