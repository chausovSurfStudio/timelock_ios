//
//  Post+CoreDataProperties.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 04.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Post+CoreDataProperties.h"

@implementation Post (CoreDataProperties)

@dynamic body;
@dynamic postID;
@dynamic timestamp;
@dynamic user;

@end
