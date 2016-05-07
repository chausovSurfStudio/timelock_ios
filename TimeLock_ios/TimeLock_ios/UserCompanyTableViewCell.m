//
//  UserCompanyTableViewCell.m
//  TimeLock_ios
//
//  Created by Александр Чаусов on 07.05.16.
//  Copyright © 2016 Александр Чаусов. All rights reserved.
//

#import "UserCompanyTableViewCell.h"
#import "User.h"

@interface UserCompanyTableViewCell()

@property (nonatomic, strong) IBOutlet UILabel *companyLabel;

@end

@implementation UserCompanyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configCellWithUser:(User *)user {
    NSString *companyString = [NSLocalizedString(@"companyName", nil) stringByAppendingString:user.companyName];
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName: TEXT_COLOR,
                                 NSFontAttributeName: COMPANY_NAME_FONT
                                 };
    NSMutableAttributedString *labelText = [[NSMutableAttributedString alloc] initWithString:companyString attributes:attributes];
    [labelText addAttribute:NSFontAttributeName value:COMPANY_NAME_FONT_BOLD range:NSMakeRange(labelText.length - user.companyName.length, user.companyName.length)];
    self.companyLabel.attributedText = labelText;
}

@end
