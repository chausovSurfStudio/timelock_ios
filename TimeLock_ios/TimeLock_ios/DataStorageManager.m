//
//  DataStorageManager.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager.h"

static DataStorageManager *dataStorage;

@implementation DataStorageManager

+ (instancetype)sharedDataStorage{
    static dispatch_once_t onceToken;
    if (!dataStorage){
        dispatch_once(&onceToken, ^{
            dataStorage = [[DataStorageManager alloc] init];
        });
    }
    return dataStorage;
}

@end
