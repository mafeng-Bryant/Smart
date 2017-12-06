//
//  SPPowerController.m
//  SmartPlug
//
//  Created by patpat on 2017/12/4.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerController.h"
#import "SPTitleView.h"
#import "SPPowerDayController.h"
#import "SPPowerWeekController.h"
#import "SPPowerMonthController.h"
#import "SPPowerYearController.h"
#import "SPScrollSegmentControl.h"
#import "SPTabPageScrollView.h"
#import <Masonry/Masonry.h>
#import "SPPowerListPageView.h"
#import "SPPowerDataSource.h"
#import "SPPopUpView.h"


@interface SPPowerController ()<UIScrollViewDelegate,PPTabPageScrollViewDataSource,PPTabPageScrollViewDelegate,PPScrollSegmentControlDelegate>
@property (nonatomic,strong) SPScrollSegmentControl* segmentControlView;
@property(nonatomic,strong)  SPTabPageScrollView *pageScrollView;

@end

@implementation SPPowerController

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.segmentControlView];
    [self.view addSubview:self.pageScrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftItem];
    [self setTirtleViewText];
    [self setRightItem];
    [self addTabPageScrollViewConstraints];
    [_segmentControlView reloadItems:[self tabs]];
    [_pageScrollView reloadData:[self tabs]];
}

#pragma mark PPScrollSegmentControlDelegate
- (void)scrollSegment:(SPScrollSegmentControl *)control title:(NSString *)title index:(NSInteger)index
{
    [_pageScrollView scrollToPage:index animated:YES];
}

#pragma mark PPTabPageScrollViewDataSource

- (PPTabPageView *)pageScrollView:(SPTabPageScrollView *)scrollView
                           atPage:(NSInteger)page
{
    SPPowerListPageView *pageView = [[SPPowerListPageView alloc]initWithFrame:CGRectZero];
    return pageView;
}

#pragma mark PPTabPageScrollViewDelegate

- (void)pageScrollViewStoped:(SPTabPageScrollView *)scrollView
                scrollToPage:(NSInteger)page
{
    [_segmentControlView setSelectedItem:page];
}

- (void)pageScrollView:(SPTabPageScrollView *)scrollView
  shouldReloadPageView:(SPPowerListPageView *)pageView
                atPage:(NSInteger)page
{
    if (pageView && ISCLASS([SPPowerListPageView class], pageView)) {
        [pageView setDataSourceClass:NSStringFromClass([SPPowerDataSource class])];
        [pageView requestData];
    }
}

#pragma mark Set and Get Methods

- (NSArray *)tabs
{
    return @[@"日",@"周",@"月",@"年"];
}

-(SPScrollSegmentControl *)segmentControlView
{
    if (!_segmentControlView) {
        _segmentControlView = [[SPScrollSegmentControl alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, VMargin40)];
        _segmentControlView.controlDelegate = self;
    }
    return _segmentControlView;
}

- (SPTabPageScrollView *)pageScrollView
{
    if (!_pageScrollView) {
        _pageScrollView = [[SPTabPageScrollView alloc]init];
        _pageScrollView.pageDataSource = self;
        _pageScrollView.pageDelegate = self;
        [_pageScrollView setDefaultSelectedPage:0];
    }
    return _pageScrollView;
}

- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(closeAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setRightItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 24, 24);
    [btn addTarget:self action:@selector(setCharge:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"设置电价" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setCharge:(UIButton*)btn
{
    [SPPopUpView showAlertStyleWithOkButtonTitle:@"确定" cancelButtonTitle:@"取消" clickBlock:^(NSUInteger clickIndex) {
       
    
    }];
}

- (void)setTirtleViewText
{
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:self.accessory.name];
    self.navigationItem.titleView = view;
}

- (void)addTabPageScrollViewConstraints
{
    //给_tabPageScrollView添加约束
    [_pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(_segmentControlView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
