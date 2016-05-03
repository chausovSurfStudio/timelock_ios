//
//  ProfileSettingsTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProfileSettingsTableViewCellDelegate <NSObject>

- (void)changeProfileButtonPressed;
- (void)exitButtonPressed;

@end

@interface ProfileSettingsTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ProfileSettingsTableViewCellDelegate> delegate;

@end
