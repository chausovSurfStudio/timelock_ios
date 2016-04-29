//
//  TLNetworkManager.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 29.04.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNetworkManager : NSObject

typedef enum{
    GET,
    POST,
    PUT,
    DELETE
} RequestType;

typedef NS_ENUM(NSInteger, HTTPStatusCode){
    HTTPStatusOK = 200,
    HTTPStatusNotAuthorized = 401,
    HTTPStatusBadRequest = 400,
    HTTPStatusForbidden = 403,
    HTTPStatusNotFound = 404,
    HTTPStatusServerError = 500,
    HTTPStatusNoInternetConnection = -1009
};

@property (nonatomic, strong) NSString *token;
@property (nonatomic,readwrite) BOOL manualErrorShowing;
//@property (nonatomic,readwrite) BOOL detailedError400;
//@property (nonatomic,readwrite) BOOL  isItCachedData;
//@property (nonatomic,readwrite) BOOL  notCachedRequest;
//@property (nonatomic,readwrite) int   timeoutInterval;

+ (instancetype) sharedNetworkManager;
- (void)requestType:(RequestType)type url:(NSString *)url parameters:(NSDictionary *)parameters completion:(void (^)(BOOL success, id result))completion;
- (BOOL)getNetworkStatus;

@end
