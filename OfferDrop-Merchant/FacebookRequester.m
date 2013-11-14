//
//  FacebookRequester.m
//  offerdrop
//
//  Created by Mohammed Barham on 10/2/12.
//
//

#import "FacebookRequester.h"

@implementation FacebookRequester

-(FacebookRequester *)initWithDelegate:(id<FacebookRequesterDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        
        _delegate = delegate;
    }
    
    return self;
}

#pragma mark - custom methods
-(void) RequestDataFromGraphWithURL:(NSString *)graphURL andParams:(NSMutableDictionary *)params andMethod:(NSString *)httpMethod
{
    _request = [FBRequestConnection startWithGraphPath:graphURL parameters:params HTTPMethod:httpMethod completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (error) {
            [_delegate RequestDidFailWithError:error andRequester:self];
        }
        else
        {
            NSDictionary * FBData = (NSDictionary *)result;
            [_delegate RequestDidLoadWithFBData:FBData andRequester:self];
        }
        
    }];
    
}

-(void) RequestDataFromFQLWithParams:(NSMutableDictionary *)params andFQLString:(NSString *)FQLString andMethod:(NSString *)httpMethod
{
    _request = [FBRequestConnection startWithGraphPath:@"/fql" parameters:params HTTPMethod:httpMethod completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error)
        {
            [_delegate RequestDidFailWithError:error andRequester:self];
        }
        else
        {
            NSDictionary * FBData = (NSDictionary *)result;
            [_delegate RequestDidLoadWithFBData:FBData andRequester:self];
        }
    }];
}

-(void) CancelRequest
{
    [_request cancel];
}

@end
