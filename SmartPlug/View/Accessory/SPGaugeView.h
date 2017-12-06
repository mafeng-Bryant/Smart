//
//  SPGaugeView.h
//  SmartPlug
//
//  Created by patpat on 2017/12/1.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    SPGaugeViewSubdivisionsAlignmentTop,
    SPGaugeViewSubdivisionsAlignmentCenter,
    SPGaugeViewSubdivisionsAlignmentBottom
}
SPGaugeViewSubdivisionsAlignment;

typedef enum
{
    SPGaugeViewNeedleStyle3D,
    SPGaugeViewNeedleStyleFlatThin
}
SPGaugeViewNeedleStyle;

typedef enum
{
    SPGaugeViewNeedleScrewStyleGradient,
    SPGaugeViewNeedleScrewStylePlain
}
SPGaugeViewNeedleScrewStyle;

typedef enum
{
    SPGaugeViewInnerBackgroundStyleGradient,
    SPGaugeViewInnerBackgroundStyleFlat
}
SPGaugeViewInnerBackgroundStyle;

@interface SPGaugeView : UIView

@property (nonatomic) bool showInnerBackground;
@property (nonatomic) bool showInnerRim;
@property (nonatomic) CGFloat innerRimWidth;
@property (nonatomic) CGFloat innerRimBorderWidth;
@property (nonatomic) SPGaugeViewInnerBackgroundStyle innerBackgroundStyle;
@property (nonatomic) CGFloat needleWidth;
@property (nonatomic) CGFloat needleHeight;
@property (nonatomic) CGFloat needleScrewRadius;
@property (nonatomic) SPGaugeViewNeedleStyle needleStyle;
@property (nonatomic) SPGaugeViewNeedleScrewStyle needleScrewStyle;
@property (nonatomic) CGFloat scalePosition;
@property (nonatomic) CGFloat scaleStartAngle;
@property (nonatomic) CGFloat scaleEndAngle;
@property (nonatomic) CGFloat scaleDivisions;
@property (nonatomic) CGFloat scaleSubdivisions;
@property (nonatomic) bool showScaleShadow;
@property (nonatomic) SPGaugeViewSubdivisionsAlignment scalesubdivisionsaligment;
@property (nonatomic) CGFloat scaleDivisionsLength;
@property (nonatomic) CGFloat scaleDivisionsWidth;
@property (nonatomic) CGFloat scaleSubdivisionsLength;
@property (nonatomic) CGFloat scaleSubdivisionsWidth;
@property (nonatomic, strong) UIColor *scaleDivisionColor;
@property (nonatomic, strong) UIColor *scaleSubDivisionColor;
@property (nonatomic, strong) UIFont *scaleFont;
@property (nonatomic) CGFloat rangeLabelsWidth;
@property (nonatomic) float value;
@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;
@property (nonatomic) bool showRangeLabels;
@property (nonatomic) CGFloat rangeLabelsFontKerning;
@property (nonatomic, strong) NSArray *rangeValues;
@property (nonatomic, strong) NSArray *rangeColors;
@property (nonatomic, strong) NSArray *rangeLabels;
@property (nonatomic, strong) NSString *unitOfMeasurement;
@property (nonatomic, strong) NSString* showEnergy;//显示实时功率
@property (nonatomic) bool showUnitOfMeasurement;

- (void)setValue:(float)value animated:(BOOL)animated;


@end
