//
//  SPCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPCell.h"

@implementation UITableViewCell (ParentTableView)
- (UITableView *)parentTableView {
    
    UITableView *tableView = nil;
    UIView *view = self;
    while(view != nil) {
        if([view isKindOfClass:[UITableView class]]) {
            tableView = (UITableView *)view;
            break;
        }
        view = [view superview];
    }
    return tableView;
}

@end

@implementation SPCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGFloat)cellHeight
{
    return 44;
}

+ (UINib *)nib{
    return  [UINib nibWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerNibToTableView:(UITableView *)tb
{
    [tb registerNib:[self nib] forCellReuseIdentifier:[self reuseIdentifier]];
}

+ (void)registerClassToTableView:(UITableView *)tb
{
    [tb registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
