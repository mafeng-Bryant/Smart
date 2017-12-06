//
//  SPPowerInfoCell.m
//  SmartPlug
//
//  Created by patpat on 2017/12/5.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPPowerInfoCell.h"
#import "SPSetting.h"

#define kSingleHeight (300-59)/4


@interface SPPowerInfoCell()
{
    UIView* _xxView;
    UIView* _yyView;
}

@end

@implementation SPPowerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _yyView = [[UIView alloc]init];
    _yyView.backgroundColor = [UIColor clearColor];
    _yyView.frame = CGRectMake(VMargin5, 39, VMargin40, 241);
    [self addSubview:_yyView];
    
    _xxView = [[UIView alloc]init];
    _xxView.backgroundColor = [UIColor clearColor];
    _xxView.frame = CGRectMake(_yyView.right, 39, self.width - VMargin45, self.height-39);
    [self addSubview:_xxView];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:_xxView.bounds];
    _scrollView.backgroundColor = [UIColor clearColor];
    [_xxView addSubview:_scrollView];
}

- (void)configureData:(SPPowerTableViewInfo*)info type:(SPPowerDataSourceSegmentType)type costType:(SPXValueModelType)costType
{
    [_yyView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //set yy datas
    if (isValidArray(info.yyModel.datas)) {
        CGFloat spaceY = 0.0;
        for (NSString* value in info.yyModel.datas) {
            UILabel* yLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            yLabel.textColor = PPC3;
            yLabel.font = [UIFont systemFontOfSize:12];
            yLabel.text = value;
            [yLabel sizeToFit];
            [_yyView addSubview:yLabel];
            yLabel.frame = CGRectMake((_yyView.width - yLabel.width)/2.0,spaceY, yLabel.width, yLabel.height);
            spaceY +=yLabel.height+(_yyView.height - 5*yLabel.height)/4.0;
        }
   }
    
   //set xx data
    if ( isValidArray(info.valueDatas)) {
        CGFloat xSpace = 15.0f;
        for (SPXValueModel* model in info.valueDatas) {
            NSInteger index = [info.valueDatas indexOfObject:model];
            SPXValueModel* model = info.valueDatas[index];
            UILabel* xLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            xLabel.textColor = PPC3;
            xLabel.font = [UIFont systemFontOfSize:12];
            xLabel.text = [NSString stringWithFormat:@"%ld",model.hour];
            [xLabel sizeToFit];
            xLabel.frame = CGRectMake(xSpace, 258 - xLabel.height, xLabel.width, xLabel.height);
            [_scrollView addSubview:xLabel];
            if (index < info.valueDatas.count-1) {
                xSpace+=40+xLabel.width;
            }
            
            if ([model.value floatValue]>0) {
             //创建柱状图+valuelbl
                //计算高度
                UIView* view = [[UIView alloc]initWithFrame:CGRectZero];
                view.backgroundColor = PPC2;
                [_scrollView addSubview:view];
                CGPoint viewPoint = view.origin;
        
                UILabel* xValueLbl = [[UILabel alloc]initWithFrame:CGRectZero];
                xValueLbl.textColor = PPC3;
                xValueLbl.font = [UIFont systemFontOfSize:14];
                if (costType == SPXValueModelTypeCost) {
                    CGFloat chooseCharge = [[SPSetting sharedSPSetting].chooseCharge floatValue];
                    chooseCharge = chooseCharge*[model.value floatValue];
                    xValueLbl.text = [NSString stringWithFormat:@"%.3f",chooseCharge];
                    CGFloat viewHeight = chooseCharge*((300-59)/4)/0.5;
                    viewPoint.y = xLabel.origin.y - VMargin20 - viewHeight + xLabel.height;
                    view.origin = viewPoint;
                    view.size = CGSizeMake([self getTextWidth], viewHeight);
                    view.centerX = xLabel.centerX;
                }else {
                    CGFloat viewHeight = [model.value floatValue]*((300-59)/4)/0.5;
                    viewPoint.y = xLabel.origin.y - VMargin20 - viewHeight + xLabel.height;
                    view.origin = viewPoint;
                    view.size = CGSizeMake([self getTextWidth], viewHeight);
                    view.centerX = xLabel.centerX;
                    xValueLbl.text = model.value;
                }
                [xValueLbl sizeToFit];
                xValueLbl.centerX = xLabel.centerX;
                CGPoint point = xValueLbl.origin;
                point.y = view.origin.y - VMargin20;
                xValueLbl.origin = point;
                [_scrollView addSubview:xValueLbl];
                
            }else {
                
                UILabel* xValueLbl = [[UILabel alloc]initWithFrame:CGRectZero];
                xValueLbl.textColor = PPC3;
                xValueLbl.font = [UIFont systemFontOfSize:14];
                xValueLbl.text = model.value;
                [xValueLbl sizeToFit];
                xValueLbl.centerX = xLabel.centerX;
                CGPoint point = xValueLbl.origin;
                point.y = xLabel.origin.y - VMargin20;
                xValueLbl.origin = point;
                [_scrollView addSubview:xValueLbl];
                
            }
        }
        _scrollView.contentSize = CGSizeMake(xSpace+VMargin80, _scrollView.height);
    }
}



- (CGFloat)getTextWidth
{
    UILabel* cacluteLbl = [[UILabel alloc]initWithFrame:CGRectZero];
    cacluteLbl.font = [UIFont systemFontOfSize:14];
    cacluteLbl.text = @"0.000";
    [cacluteLbl sizeToFit];
    return cacluteLbl.width;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
