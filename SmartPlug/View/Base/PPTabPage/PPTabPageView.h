//
//  PPTabPageView.h
//  PatPat
//
//  Created by Bruce He on 15/5/20.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPTabPageView : UIView
@property (nonatomic, strong) id pageInfo;
@property (nonatomic, assign) NSInteger pageIndex;
- (id)initWithFrame:(CGRect)frame;
- (void)initViews;
- (void)setDataSourceClass:(NSString *)classString;
@end
