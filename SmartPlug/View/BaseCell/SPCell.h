//
//  SPCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (ParentTableView)
- (UITableView *)parentTableView;
@end


@interface SPCell : UITableViewCell
+ (CGFloat)cellHeight;
+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (void)registerNibToTableView:(UITableView *)tb;
+ (void)registerClassToTableView:(UITableView *)tb;
@end
