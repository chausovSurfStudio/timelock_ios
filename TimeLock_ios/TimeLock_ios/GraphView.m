//
//  GraphView.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "GraphView.h"
#import "Checkin.h"
#import <math.h>

static CGFloat const minutesInDay = 1440.0f;

@interface GraphView()

@property (nonatomic, assign) NSInteger graphWidth;

@end

@implementation GraphView

- (void)drawRect:(CGRect)rect {    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    [TEXT_COLOR_EXTRA setStroke];
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);

    self.graphWidth = SCREEN_WIDTH - 4 * LEFT_OFFSET;
    CGContextAddArc(context, LEFT_OFFSET, 8, 7, 90.0f * M_PI / 180, 270.0f * M_PI / 180, 0);
    CGContextAddLineToPoint(context, LEFT_OFFSET + self.graphWidth, 1);
    CGContextAddArc(context, LEFT_OFFSET + self.graphWidth, 8, 7, 270.0f * M_PI / 180, 90.0f * M_PI / 180, 0);
    CGContextAddLineToPoint(context, LEFT_OFFSET, 15);
    
    CGContextStrokePath(context);
    
    NSArray *checkins = [self.dataSource checkinsForGraphView];
    if (checkins.count >= 2) {
        for (int i = 0; i < checkins.count - 1; i += 2) {
            [self drawRectForCheckins:@[checkins[i], checkins[i + 1]] inContext:context];
        }
    }
    
    UIGraphicsPopContext();
}

- (void)drawRectForCheckins:(NSArray *)checkins inContext:(CGContextRef)context {
    Checkin *firstCheckin = checkins[0];
    Checkin *secondCheckin = checkins[1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [calendar setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU_POSIX"]];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:firstCheckin.time];
    NSInteger firstMinutes = components.minute + components.hour * 60;
    components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:secondCheckin.time];
    NSInteger secondMinutes = components.minute + components.hour * 60;
    
    CGFloat firstCoordinate = firstMinutes * self.graphWidth / minutesInDay;
    CGFloat secondCoordinate = secondMinutes * self.graphWidth / minutesInDay;
    CGFloat rectWidth = secondCoordinate - firstCoordinate;
    
    CGRect rectangle = CGRectMake(LEFT_OFFSET + firstCoordinate, 1, rectWidth, 14);
    [GREEN_COLOR setStroke];
    [GREEN_COLOR setFill];
    CGContextFillRect(context, rectangle);
}

@end
