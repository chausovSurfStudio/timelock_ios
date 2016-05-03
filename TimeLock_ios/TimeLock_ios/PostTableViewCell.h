//
//  PostTableViewCell.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 03.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface PostTableViewCell : UITableViewCell

- (void)configCellWithPost:(Post *)post;

@end
