//
//  User+CoreDataProperties.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id_;
@property (nullable, nonatomic, retain) NSString *avatar;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *middleName;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *posts;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addPostsObject:(NSManagedObject *)value;
- (void)removePostsObject:(NSManagedObject *)value;
- (void)addPosts:(NSSet<NSManagedObject *> *)values;
- (void)removePosts:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
