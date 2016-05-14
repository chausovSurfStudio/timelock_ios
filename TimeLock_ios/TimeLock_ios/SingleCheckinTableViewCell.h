//
//  SingleCheckinTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Checkin;

@interface SingleCheckinTableViewCell : UITableViewCell

- (void)configWithCheckin:(Checkin *)checkin isSolo:(BOOL)isSolo;

@end
