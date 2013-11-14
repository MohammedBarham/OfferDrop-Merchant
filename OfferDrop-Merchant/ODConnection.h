//
//  ODConnection.h
//  OfferDrop-Merchant
//
//  Created by Mohammed Barham on 11/6/13.
//  Copyright (c) 2013 OfferDrop. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ODConnection;

@protocol ODConnectionDelegate <NSObject>
@required

-(void) Connection:(ODConnection *) connection didFinishWithData:(NSMutableData *)responseData andResponseCode:(NSInteger)responseCode;
-(void) Connection:(ODConnection *)connection didFailWitherror:(NSError *)error;

@end

@interface ODConnection : NSObject
{
    id <ODConnectionDelegate> _delegate;
    
    NSURLConnection * _connection;
    NSMutableData * _responseData;
    NSInteger _responseCode;;
}

-(id) initWithDelegate:(id <ODConnectionDelegate>)delegate;
-(void) startConnectionWithURL:(NSString *)url andBody:(NSString *)body andHttpMethod:(NSString *)httpMethod andTimeOut:(NSInteger) timeOut andContentType:(NSString *)contentType;

-(void) startConnectionWithRequest:(NSMutableURLRequest *)request;

-(void) cancelConnection;

@end
