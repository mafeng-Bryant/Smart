//
//  PPHomeTabPageView.h
//  PatPat
//
//  Created by patpat on 15/5/18.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPTabPageView.h"

typedef enum {
    ScrollviewDicrectionRight, //to right
    ScrollviewDicrectionLeft   //to left
}ScrollviewDicrection;

@protocol PPTabPageScrollViewDataSource,PPTabPageScrollViewDelegate;

@interface SPTabPageScrollView : UIScrollView<UIScrollViewDelegate>
{
    CGFloat _lastContentOffsetX;
    NSInteger _totalPage;
}
@property(nonatomic,readonly) NSInteger currentPage;
@property (nonatomic,assign)id<PPTabPageScrollViewDataSource>pageDataSource;
@property (nonatomic,assign)id<PPTabPageScrollViewDelegate>pageDelegate;

//重新加载数据
- (void)reloadData:(NSArray *)items;

//设置默认所在页面
- (void)setDefaultSelectedPage:(NSInteger)page;

//滚动到page页面
- (void)scrollToPage:(NSInteger)page;
- (void)scrollToPage:(NSInteger)page animated:(BOOL)animated;

//获取page页面的view
- (PPTabPageView *)currentTabPageView;
- (PPTabPageView *)tabPageViewWithPage:(NSInteger)page;


@end

@protocol PPTabPageScrollViewDataSource <NSObject>

@required

/**
 *  设置在page的pageview
 *
 *  @param scrollView PPTabPageScrollView对象
 *  @param page       页码
 *
 *  @return 传入的pageview
 */
- (PPTabPageView *)pageScrollView:(SPTabPageScrollView *)scrollView
                    atPage:(NSInteger )page;

@optional

@end


@protocol PPTabPageScrollViewDelegate <NSObject>

@optional

/**
 *  tabpage滚动的时候会回调此方法
 *
 *  @param scrollView PPTabPageScrollView对象
 *  @param direction  方向
 *  @param page       滚动到了page页码
 */
- (void)pageScrollViewScrolling:(SPTabPageScrollView *)scrollView
                      direction:(ScrollviewDicrection)direction;


/**
 *  tabpage停止滚动的时候调用此回调
 *
 *  @param scrollView PPTabPageScrollView对象
 *  @param page       滚动到了page页码
 */
- (void)pageScrollViewStoped:(SPTabPageScrollView *)scrollView
                scrollToPage:(NSInteger )page;


/**
 *  tabpage滚动到page页面，可以通知pageview做刷新数据等操作
 *
 *  @param scrollView PPTabPageScrollView对象
 *  @param pageView   滚动到的pageview
 *  @param page       页码
 */
- (void)pageScrollView:(SPTabPageScrollView *)scrollView
  shouldReloadPageView:(PPTabPageView *)pageView
                atPage:(NSInteger)page;

/**
 *  scrollview滚动到左边的边界
 *
 *  @param scrollView PPTabPageScrollView对象
 */
- (void)scrollToLeadingEdge:(SPTabPageScrollView *)scrollView;

@end





