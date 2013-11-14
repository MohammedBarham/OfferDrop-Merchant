//
//  FacebookRequester.h
//  offerdrop
//
//  Created by Mohammed Barham on 10/2/12.
//
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
@class FacebookRequester;

@protocol FacebookRequesterDelegate

-(void) RequestDidLoadWithFBData:(NSDictionary *)FBData andRequester:(FacebookRequester *)requester;
-(void) RequestDidFailWithError:(NSError *)error andRequester:(FacebookRequester *)requester;
-(void) RequestReceivedResponseCode:(NSInteger)responseCode andRequester:(FacebookRequester *)requester;

@end

@interface FacebookRequester : NSObject 
{
    id<FacebookRequesterDelegate> _delegate;
    FBRequestConnection * _request;
}

-(FacebookRequester *)initWithDelegate:(id<FacebookRequesterDelegate>)delegate;

-(void) RequestDataFromGraphWithURL:(NSString *)graphURL andParams:(NSMutableDictionary *)params andMethod:(NSString *)httpMethod;
-(void) RequestDataFromFQLWithParams:(NSMutableDictionary *)params andFQLString:(NSString *)FQLString andMethod:(NSString *)httpMethod;
-(void) CancelRequest;
@end
