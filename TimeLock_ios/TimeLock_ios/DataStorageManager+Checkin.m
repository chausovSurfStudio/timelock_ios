//
//  DataStorageManager+Checkin.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 13.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "DataStorageManager+Checkin.h"
#import "Checkin.h"
#import "Note.h"
#import "NSDictionary+SafeGetters.h"

#import <MagicalRecord/MagicalRecord.h>

@implementation DataStorageManager (Checkin)

- (void)saveCheckinsPage:(NSDictionary *)dict completion:(void (^)(BOOL success, id object))completion {
    [Checkin MR_truncateAll];
    
    NSArray *checkinsDict = [dict safeGetArrayByKey:@"checkins"];
    [Checkin MR_importFromArray:checkinsDict];
    NSArray *notesDict = [dict safeGetArrayByKey:@"notes"];
    [Note MR_importFromArray:notesDict];
    
    NSDate *monday = [dict safeGetDateFromStringByKey:@"monday" andDateFormat:serverDateFormat];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    dayComponent.day = 1;
    NSDate *tuesday = [theCalendar dateByAddingComponents:dayComponent toDate:monday options:0];
    NSDate *wednesday = [theCalendar dateByAddingComponents:dayComponent toDate:tuesday options:0];
    NSDate *thursday = [theCalendar dateByAddingComponents:dayComponent toDate:wednesday options:0];
    NSDate *friday = [theCalendar dateByAddingComponents:dayComponent toDate:thursday options:0];
    NSDate *saturday = [theCalendar dateByAddingComponents:dayComponent toDate:friday options:0];
    NSDate *sunday = [theCalendar dateByAddingComponents:dayComponent toDate:saturday options:0];
    
    NSMutableDictionary *resultDict = [[NSMutableDictionary alloc] init];
    NSArray *times = [dict safeGetArrayByKey:@"times"];
    [resultDict setValue:@[[self checkinsForDate:monday],       [self notesForDate:monday],     monday,     [self safeGetTimeFromArray:times forIndex:0]] forKey:mondayString];
    [resultDict setValue:@[[self checkinsForDate:tuesday],      [self notesForDate:tuesday],    tuesday,    [self safeGetTimeFromArray:times forIndex:1]] forKey:tuesdayString];
    [resultDict setValue:@[[self checkinsForDate:wednesday],    [self notesForDate:wednesday],  wednesday,  [self safeGetTimeFromArray:times forIndex:2]] forKey:wednesdayString];
    [resultDict setValue:@[[self checkinsForDate:thursday],     [self notesForDate:thursday],   thursday,   [self safeGetTimeFromArray:times forIndex:3]] forKey:thursdayString];
    [resultDict setValue:@[[self checkinsForDate:friday],       [self notesForDate:friday],     friday,     [self safeGetTimeFromArray:times forIndex:4]] forKey:fridayString];
    [resultDict setValue:@[[self checkinsForDate:saturday],     [self notesForDate:saturday],   saturday,   [self safeGetTimeFromArray:times forIndex:5]] forKey:saturdayString];
    [resultDict setValue:@[[self checkinsForDate:sunday],       [self notesForDate:sunday],     sunday,     [self safeGetTimeFromArray:times forIndex:6]] forKey:sundayString];
    [resultDict setValue:[self safeGetTimeFromArray:times forIndex:7] forKey:resultTimeString];
    
    NSLog(@"NOTE COUNT = %@", [Note MR_numberOfEntities]);
    NSLog(@"CHECKIN COUNT = %@", [Checkin MR_numberOfEntities]);
    completion(YES, [resultDict copy]);
}

- (NSArray *)checkinsForDate:(NSDate *)date {
    NSArray *result = [Checkin MR_findAllSortedBy:@"time" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"date == %@", date]];
    return result ? result : [NSArray array];
}

- (NSArray *)notesForDate:(NSDate *)date {
    NSArray *result = [Note MR_findAllSortedBy:@"noteID" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"date == %@", date]];
    return result ? result : [NSArray array];
}

- (NSNumber *)safeGetTimeFromArray:(NSArray *)times forIndex:(NSInteger)index {
    if (index < times.count) {
        return times[index] ? times[index] : @(0);
    }
    return @(0);
}

@end
