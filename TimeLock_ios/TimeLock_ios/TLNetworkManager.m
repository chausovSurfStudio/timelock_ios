//
//  TLNetworkManager.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 29.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "TLNetworkManager.h"
#import "AFNetworking.h"
#import "AFURLConnectionOperation.h"
#import "Const.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TLNetworkManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@end

@implementation TLNetworkManager

static TLNetworkManager *networkManager;

+ (instancetype)sharedNetworkManager{
    static dispatch_once_t onceToken;
    if (!networkManager){
        dispatch_once(&onceToken, ^{
            networkManager = [[TLNetworkManager alloc] init];
            NSURLCache *urlCache = [[NSURLCache alloc]
                                    initWithMemoryCapacity:(4 * 1024 * 1024)
                                    diskCapacity:(20 * 1024 * 1024)
                                    diskPath:nil];
            [NSURLCache setSharedURLCache:urlCache];
        });
    }
    return networkManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.requestOperationManager = [AFHTTPRequestOperationManager manager];
        self.requestOperationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestOperationManager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    }
    return self;
}

- (void)requestType:(RequestType)type url:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(BOOL success, id result))completion {
    BOOL manualErrorShowing = _manualErrorShowing;
    _manualErrorShowing = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"token"]) {
        [self.requestOperationManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[defaults objectForKey:@"token"] password:@""];
    } else if ([defaults objectForKey:@"email"] && [defaults objectForKey:@"password"]) {
        [self.requestOperationManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[defaults objectForKey:@"email"] password:@"password"];
    }
    void (^successBlock)(AFHTTPRequestOperation * operation, id responseObject) = ^(AFHTTPRequestOperation * operation, id responseObject){
        if (!manualErrorShowing) {
            // TODO
        }
        NSLog(@"success: %@", responseObject);
        completion(YES, responseObject);
        return;
    };
    
    void (^failureBlock)(AFHTTPRequestOperation * operation, NSError * error) = ^(AFHTTPRequestOperation * operation, NSError * error){
        NSLog(@"error: %@",  error);
        
        NSInteger statusCode = [error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (!manualErrorShowing) {
            // TODO
        }
        if (!manualErrorShowing && statusCode != HTTPStatusNotAuthorized) {
            // TODO
        }
        if (statusCode == HTTPStatusNotAuthorized) {
            // TODO
        } else {
            completion(NO, error);
        }
        return;
    };
    
    switch(type){
        case GET: {
            [self.requestOperationManager GET:url parameters:parameters success:successBlock failure:failureBlock];
            break;
        }
        case POST:
            [self.requestOperationManager POST:url parameters:parameters success:successBlock failure:failureBlock];
            break;
        case PUT:
            [self.requestOperationManager PUT:url parameters:parameters success:successBlock failure:failureBlock];
            break;
        case DELETE:
            [self.requestOperationManager DELETE:url parameters:parameters success:successBlock failure:failureBlock];
            break;
        default:
            break;
    }
}

- (BOOL) getNetworkStatus {
    NSLog(@"%d", [AFNetworkReachabilityManager sharedManager].reachable);
    return [AFNetworkReachabilityManager sharedManager].reachable;
}



@end
