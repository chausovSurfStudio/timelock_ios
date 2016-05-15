//
//  CheckinTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 16.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Checkin;

@interface CheckinTableViewCell : UITableViewCell

- (void)configWithCheckin:(Checkin *)checkin;

@end
