//
//  UserViewController.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@property (nonatomic, strong) NSNumber *userID;

@end

@implementation UserViewController

- (instancetype)initWithUserID:(NSNumber *)userID {
    self = [super init];
    if (self) {
        self.userID = userID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
