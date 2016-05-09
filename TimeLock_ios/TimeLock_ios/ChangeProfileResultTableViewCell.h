//
//  ChangeProfileResultTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 08.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeProfileResultTableViewCellDelegate <NSObject>

- (void)saveResultButtonPressed;
- (void)cancelButtonPressed;

@end

@interface ChangeProfileResultTableViewCell : UITableViewCell

@property (nonatomic, weak) id<ChangeProfileResultTableViewCellDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) IBOutlet UIButton *cancelButton;

@end
