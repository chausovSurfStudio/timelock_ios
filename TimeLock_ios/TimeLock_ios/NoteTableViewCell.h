//
//  NoteTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface NoteTableViewCell : UITableViewCell

- (void)configWithNote:(Note *)note;

@end
