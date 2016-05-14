//
//  GraphView.h
//  TimeLock_ios
//
//  Created by Александр Чаусов on 14.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphViewDataSource <NSObject>

- (NSArray *)checkinsForGraphView;

@end

@interface GraphView : UIView

@property (nonatomic, weak) id<GraphViewDataSource> dataSource;

@end
