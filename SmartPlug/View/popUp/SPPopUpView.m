//
//  SPPopUpView.m
//  SmartPlug
//
//  Created by patpat on 2017/12/6.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPopUpView.h"
#import "Help.h"
#import "UIView+Extensions.h"
#import "SPSetting.h"

#define kAlertStyleViewWidth 300.0f
#define kAlertStyleViewHeight 250.0f

@interface SPPopUpView()<UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_boxView;
    UIPickerView* _pickView;
    NSArray* _sampleDatas;
    NSArray* _datasOne;
    NSArray* _datasTwo;
    NSArray* _datasThree;
    NSString* _chooseSample;
    NSString* _numberOne;
    NSString* _numberTwo;
}

@end

@implementation SPPopUpView

- (id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        _numberOne = @"0";
        _numberTwo = @"00";
        _chooseSample = @"￥";
        _sampleDatas = @[@"￥",@"$"];
        _datasOne = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        _datasTwo = @[@"."];
        _datasThree = @[@"00",@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",
                        @"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",
                        @"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",
                        @"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",
                        @"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",
                        @"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"52",
                        @"54",@"55",@"56",@"57",@"58",@"59",@"60",@"61",@"62",
                        @"63",@"64",@"65",@"66",@"67",@"68",@"69",@"70",@"71",
                        @"72",@"73",@"74",@"75",@"76",@"77",@"78",@"79",@"80",
                        @"81",@"82",@"83",@"84",@"85",@"86",@"87",@"88",@"89",
                        @"91",@"92",@"93",@"94",@"95",@"96",@"97",@"98",@"99"];
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
        _boxView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kAlertStyleViewWidth, kAlertStyleViewHeight)];
        ViewRadius(_boxView, 10);
        _boxView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_boxView];
        
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLbl.textColor = PPC3;
        _titleLbl.font = [UIFont systemFontOfSize:16];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        [_boxView addSubview:_titleLbl];
        
        _messageLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        _messageLbl.textColor = PPC3;
        _messageLbl.font = [UIFont systemFontOfSize:16];
        _messageLbl.textAlignment = NSTextAlignmentCenter;
        _messageLbl.numberOfLines = 0;
        [_boxView addSubview:_messageLbl];
        
        // 初始化pickerView
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, _titleLbl.bottom,kAlertStyleViewWidth, 200)];
        //指定数据源和委托
        _pickView.delegate = self;
        _pickView.dataSource = self;
        //设置默认选中的行
        NSInteger row1 = [_sampleDatas indexOfObject:[SPSetting sharedSPSetting].currencySymbol];
        NSInteger row2 = [_datasOne indexOfObject:[SPSetting sharedSPSetting].numberOne];
        NSInteger row3 = [_datasThree indexOfObject:[SPSetting sharedSPSetting].numberTwo];
        [_pickView selectRow:row1 inComponent:0 animated:YES];
        [_pickView selectRow:row2 inComponent:1 animated:YES];
        [_pickView selectRow:row3 inComponent:3 animated:YES];
        [_boxView addSubview:_pickView];
        _numberOne = [SPSetting sharedSPSetting].numberOne;
        _numberTwo = [SPSetting sharedSPSetting].numberTwo;
        
        _lineLbl = [[UILabel alloc]initWithFrame:CGRectZero];
        _lineLbl.backgroundColor = PPC6;
        [_boxView addSubview:_lineLbl];
        
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame = CGRectMake(0, VMargin10, kAlertStyleViewWidth, 45.0f);
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_okBtn setTitleColor:RGB(21, 126, 251, 1.0) forState:UIControlStateNormal];
        [_boxView addSubview:_okBtn];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        _okBtn.backgroundColor = [UIColor clearColor];
        
        _btnLineLel = [[UILabel alloc] initWithFrame:CGRectZero];
        _btnLineLel.backgroundColor = PPC6;
        [_boxView addSubview:_btnLineLel];
        _btnLineLel.backgroundColor = PPC6;
        
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, VMargin10, kAlertStyleViewWidth, 45.0f);
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(21, 126, 251, 1.0) forState:UIControlStateNormal];
        [_boxView addSubview:_cancelBtn];
        [_cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(gestureRecognizerDidTap:)];
        tapGesture.cancelsTouchesInView = YES;
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}

+ (void)showAlertStyleWithOkButtonTitle:(NSString *)okButtonTitle
                      cancelButtonTitle:(NSString *)cancelButtonTitle
                             clickBlock:(SPPopUpViewStyleBlock)block
{
    UIView *view =  [UIApplication sharedApplication].keyWindow.rootViewController.view;
    SPPopUpView* alertView = [[SPPopUpView alloc]initWithFrame:view.bounds];
    [alertView setOkButtonTitle:okButtonTitle cancelButtonTitle:cancelButtonTitle clickBlock:block];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

- (void)setOkButtonTitle:(NSString*)okButtonTitle
       cancelButtonTitle:(NSString *)cancelButtonTitle
              clickBlock:(SPPopUpViewStyleBlock)block
{
    _clickBlock = block;
    _titleLbl.text = @"电价(kw.h)";
    [_titleLbl sizeToFit];
    _titleLbl.origin = CGPointMake((_boxView.width - _titleLbl.width)/2.0, VMargin20);
    _messageLbl.hidden = YES;
    
    _lineLbl.origin = CGPointMake(0, 190);
    _lineLbl.width = _boxView.width;
    _lineLbl.height = 0.5;
    _okBtn.y = _lineLbl.bottom+VMargin2;
    _boxView.height = _okBtn.y+_okBtn.height+VMargin2;
    
    if (isValidString(cancelButtonTitle)) {
        _okBtn.x = _boxView.width/2;
        _cancelBtn.y = _lineLbl.bottom+VMargin2;
        _cancelBtn.width = _boxView.width/2;
        _okBtn.width = _cancelBtn.width;
        _btnLineLel.hidden = NO;
        _cancelBtn.hidden = NO;
        _btnLineLel.origin = CGPointMake(_boxView.centerX, _okBtn.y);
        _btnLineLel.height = _okBtn.height;
        _btnLineLel.width = VMargin1;
        [_cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    if (isValidString(okButtonTitle)) {
        [_okBtn setTitle:okButtonTitle forState:UIControlStateNormal];
    }
    _boxView.center = self.center;
}

- (void)setTitle:(NSString*)title
         message:(NSString*)message
         okButtonTitle:(NSString *)okButtonTitle
          cancelButtonTitle:(NSString *)cancelButtonTitle
        clickBlock:(SPPopUpViewStyleBlock)block
{
    _clickBlock = block;
    _titleLbl.text = title;
    [_titleLbl sizeToFit];
    _titleLbl.origin = CGPointMake((_boxView.width - _titleLbl.width)/2.0, VMargin20);
    
    _messageLbl.width = _boxView.width-2*VMargin20;
    _messageLbl.text = message;
    [_messageLbl sizeToFit];
    CGFloat msgHeight = MAX(VMargin10, _messageLbl.height);
    _messageLbl.height = MIN(msgHeight, kAlertStyleViewWidth);
    _messageLbl.origin = CGPointMake(VMargin20, _titleLbl.bottom+VMargin10);
    _messageLbl.centerX = _boxView.centerX;
    _pickView.hidden = YES;
    
    _lineLbl.origin = CGPointMake(0, _messageLbl.bottom+VMargin20);
    _lineLbl.width = _boxView.width;
    _lineLbl.height = 0.5;
    _okBtn.y = _lineLbl.bottom+VMargin2;
    _boxView.height = _okBtn.y+_okBtn.height+VMargin2;
    
    if (isValidString(cancelButtonTitle)) {
        _okBtn.x = _boxView.width/2;
        _cancelBtn.y = _lineLbl.bottom+VMargin2;
        _cancelBtn.width = _boxView.width/2;
        _okBtn.width = _cancelBtn.width;
        _btnLineLel.hidden = NO;
        _cancelBtn.hidden = NO;
        _btnLineLel.origin = CGPointMake(_boxView.centerX, _okBtn.y);
        _btnLineLel.height = _okBtn.height;
        _btnLineLel.width = VMargin1;
        [_cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
    }
    if (isValidString(okButtonTitle)) {
        [_okBtn setTitle:okButtonTitle forState:UIControlStateNormal];
    }
    _boxView.frame = CGRectMake(0, 0, 300, 200);
    _boxView.center = self.center;
}

+ (void)showAlertStyleWithTitle:(NSString*)title
                        message:(NSString*)message
                  okButtonTitle:(NSString *)okButtonTitle
              cancelButtonTitle:(NSString *)cancelButtonTitle
                     clickBlock:(SPPopUpViewStyleBlock)block
{
    UIView *view =  [UIApplication sharedApplication].keyWindow.rootViewController.view;
    SPPopUpView* alertView = [[SPPopUpView alloc]initWithFrame:view.bounds];
    [alertView setTitle:title message:message okButtonTitle:okButtonTitle cancelButtonTitle:cancelButtonTitle clickBlock:block];
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
}

- (void)gestureRecognizerDidTap:(UITapGestureRecognizer *)tapGesture
{
    [self remove];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    if([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
        CGPoint touchPoint = [touch locationInView:self];
        return  !CGRectContainsPoint(_boxView.frame, touchPoint); //拦截对_boxView的点击
    }else{
        return YES;
    }
}

-(void)remove
{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)okAction {
    if (_clickBlock) {
        _clickBlock(1);
    }
    [self remove];
    [SPSetting sharedSPSetting].currencySymbol = _chooseSample;
    [SPSetting sharedSPSetting].numberOne = _numberOne;
    [SPSetting sharedSPSetting].numberTwo = _numberTwo;
}

- (void)cancelAction
{
    if (_clickBlock) {
        _clickBlock(0);
    }
    [self remove];
}

#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = _sampleDatas.count;
            break;
        case 1:
            result = _datasOne.count;
            break;
        case 2:
            result = _datasTwo.count;
            break;
          case 3:
            result = _datasThree.count;
            break;
        default:
            break;
    }
    
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = _sampleDatas[row];
            break;
        case 1:
            title = _datasOne[row];
            break;
        case 2:
            title = _datasTwo[row];
            break;
        case 3:
            title = _datasThree[row];
            break;
        default:
            break;
    }
    
    return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            _chooseSample = _sampleDatas[row];
            break;
        case 1:
            _numberOne = _datasOne[row];
            break;
        case 2:
            break;
        case 3:
            _numberTwo = _datasThree[row];
            break;
        default:
            break;
    }
}


@end
