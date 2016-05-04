//
//  Post+CoreDataProperties.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 04.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSNumber *postID;
@property (nullable, nonatomic, retain) NSDate *timestamp;
@property (nullable, nonatomic, retain) NSNumber *userID;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
