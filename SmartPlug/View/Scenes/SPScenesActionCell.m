//
//  SPScenesActionCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPScenesActionCell.h"
#import "Help.h"

@implementation SPScenesActionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _sceneNameLbl.textColor = [UIColor whiteColor];
}

- (void)configureData:(SPActionSetModel*)model
{
    if (model.type == SPActionSetTypeGoodMorning) {
        _bgView.backgroundColor = [UIColor greenColor];
        _sceneNameLbl.text = @"早上好";
        _deleteBtn.hidden = YES;
    }else if (model.type == SPActionSetTypeGoOut){
        _bgView.backgroundColor = [UIColor yellowColor];
        _sceneNameLbl.text = @"出门";
        _deleteBtn.hidden = YES;
    }else if (model.type == SPActionSetTypeComeBack){
        _bgView.backgroundColor = [UIColor orangeColor];
        _sceneNameLbl.text = @"到家";
        _deleteBtn.hidden = YES;
    }else if (model.type == SPActionSetTypeGoodNight){
        _bgView.backgroundColor = [UIColor cyanColor];
        _sceneNameLbl.text = @"晚安";
        _deleteBtn.hidden = YES;
    }else if (model.type == SPActionSetTypeCustom) {
        _bgView.backgroundColor = [UIColor blueColor];
        _sceneNameLbl.text = model.actionSet.name;
        _deleteBtn.hidden = NO;
    }
}

+ (CGSize)cellSize:(UICollectionView *)collectionView
{
    CGFloat width = (collectionView.frame.size.width-VMargin30)/2;
    CGFloat height = 40;
    CGSize size = CGSizeMake(width, width + height);
    return size;
}

@end
