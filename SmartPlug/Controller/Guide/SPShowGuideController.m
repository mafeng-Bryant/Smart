//
//  SPShowGuideController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/22.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPShowGuideController.h"
#import "NSObject+SPURLRoute.h"

@interface SPShowGuideController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *contentScrollView;

@end

@implementation SPShowGuideController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view addSubview:self.contentScrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSlides];
}

- (void)loadSlides
{
    NSArray* datas = [self guideImages];
    for (NSInteger index = 0; index<datas.count; index++) {
        CGRect frame = CGRectMake(_contentScrollView.frame.size.width*index,0,_contentScrollView.frame.size.width,_contentScrollView.frame.size.height);
        UIImageView* imageView  = [[UIImageView alloc]initWithFrame:frame];
        NSString* imageName = [datas objectAtIndex:index];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:imageName];
        [_contentScrollView addSubview:imageView];
        if (index == datas.count-1){
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getStart:)];
            [imageView addGestureRecognizer:tap];
        }
    }
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width*datas.count, _contentScrollView.frame.size.height);
}

#pragma mark Getter and Setter

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.delegate = self;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    scrollView.contentOffset = point;
    NSInteger totalCount = [[self guideImages] count];
    CGFloat maxX = (totalCount-1)*[UIScreen mainScreen].bounds.size.width;
    if (maxX+20<point.x) {//超过20就进入主页面
        [self getStarted];
    }
}

- (void)getStarted{
    [[self rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)getStart:(UITapGestureRecognizer*)tap
{
    [self getStarted];
}

- (NSArray*)guideImages
{
    return @[@"first.png",@"second.png",@"third.png",@"four.png",@"five.png",@"six.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
