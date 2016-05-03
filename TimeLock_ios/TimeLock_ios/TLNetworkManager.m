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
#import "TLUtils.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TLNetworkManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@property (nonatomic, copy) void (^completion)(BOOL success, id result);
@property (nonatomic, assign) RequestType type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSDictionary *parameters;

@end

@implementation TLNetworkManager

static TLNetworkManager *networkManager;

+ (instancetype)sharedNetworkManager{
    static dispatch_once_t onceToken;
    if (!networkManager){
        dispatch_once(&onceToken, ^{
            networkManager = [[TLNetworkManager alloc] init];
//            NSURLCache *urlCache = [[NSURLCache alloc]
//                                    initWithMemoryCapacity:(4 * 1024 * 1024)
//                                    diskCapacity:(20 * 1024 * 1024)
//                                    diskPath:nil];
//            [NSURLCache setSharedURLCache:urlCache];
        });
    }
    return networkManager;
}

- (id)init {
    self = [super init];
    if (self) {
        self.requestOperationManager = [AFHTTPRequestOperationManager manager];
        self.requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
        [self.requestOperationManager.requestSerializer setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    }
    return self;
}

- (void)requestType:(RequestType)type url:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(BOOL success, id result))completion {
    BOOL manualErrorShowing = _manualErrorShowing;
    _manualErrorShowing = NO;
    
    if ([TLUtils checkExistenceNotEmptyStringObjectForKey:@"token"]) {
        NSLog(@"token = %@", [TLUtils objectFromUserSettingsForKey:@"token"]);
        [self.requestOperationManager.requestSerializer setAuthorizationHeaderFieldWithUsername:[TLUtils objectFromUserSettingsForKey:@"token"] password:@""];
    } else if ([TLUtils checkExistenceNotEmptyStringObjectForKey:@"email"] && [TLUtils checkExistenceNotEmptyStringObjectForKey:@"password"]) {
        NSString *email = [TLUtils objectFromUserSettingsForKey:@"email"];
        NSString *password = [TLUtils objectFromUserSettingsForKey:@"password"];
        NSLog(@"email = %@, password = %@", email, password);
        [self.requestOperationManager.requestSerializer setAuthorizationHeaderFieldWithUsername:email password:password];
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
            [TLUtils setObjectToUserSettings:nil forKey:@"token"];
            //[TLUtils setObjectToUserSettings:nil forKey:@"password"];

            if (![TLUtils checkExistenceNotEmptyStringObjectForKey:needRelogin]) {
                self.parameters = parameters;
                self.url = url;
                self.type = type;
                self.completion = completion;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:needRelogin object:nil userInfo:nil];
                });
            } else {
                completion(NO, error);
            }
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

- (void) startMonitoring {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //available
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //not available
                break;
            default:
                break;
        }
        
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    //start monitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self configureRepeatRequestNotification];
}

- (void)configureRepeatRequestNotification {
    @weakify(self)
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:needRepeatRequest object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        @strongify(self)
        if (self.url && ![self.url isEqualToString:@""]) {
            [self requestType:self.type url:self.url parameters:self.parameters completion:self.completion];
        }
     }];
}



@end
