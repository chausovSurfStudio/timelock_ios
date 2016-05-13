//
//  Checkin+CoreDataProperties.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 13.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Checkin.h"

NS_ASSUME_NONNULL_BEGIN

@interface Checkin (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *checkinID;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSDate *time;
@property (nullable, nonatomic, retain) NSNumber *trustLevel;

@end

NS_ASSUME_NONNULL_END
