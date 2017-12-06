//
//  PPScrollSegmentControl.h
//  PatPat
//
//  Created by Bruce He on 15/9/22.
//  Copyright © 2015年 http://www.patpat.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Help.h"

@protocol PPScrollSegmentControlDelegate;
@interface SPScrollSegmentControl : UIScrollView
@property(nonatomic,weak)id<PPScrollSegmentControlDelegate> controlDelegate;
@property(nonatomic,strong) NSMutableArray *buttonItems;
- (instancetype)initWithDefaultSelectedIndex:(NSInteger)index;
- (void)setDefaultSelectedIndex:(NSInteger)index;
- (void)reloadItems:(NSArray *)items;
- (void)setSelectedItem:(NSInteger)index;
@end
@protocol PPScrollSegmentControlDelegate <NSObject>
- (void)scrollSegment:(SPScrollSegmentControl *)control title:(NSString *)title index:(NSInteger)index;
@end
