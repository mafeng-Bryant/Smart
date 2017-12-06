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
        _bgView.backgroundColor = RGB(99, 188, 222, 1.0);
        _sceneNameLbl.text = @"早上好";
        _deleteBtn.hidden = YES;
        _mainImageView.image = Image(@"goodmorning");
        _imageViewWidth.constant = _mainImageView.image.size.width;
        _imageViewHeight.constant = _mainImageView.image.size.height;
    }else if (model.type == SPActionSetTypeGoOut){
        _bgView.backgroundColor = RGB(42, 68, 94, 1.0);
        _sceneNameLbl.text = @"出门";
        _deleteBtn.hidden = YES;
        _mainImageView.image = Image(@"goout");
        _imageViewWidth.constant = _mainImageView.image.size.width;
        _imageViewHeight.constant = _mainImageView.image.size.height;
    }else if (model.type == SPActionSetTypeComeBack){
        _bgView.backgroundColor = RGB(91, 104, 119, 1.0);
        _sceneNameLbl.text = @"到家";
        _deleteBtn.hidden = YES;
        _mainImageView.image = Image(@"homescenes");
        _imageViewWidth.constant = _mainImageView.image.size.width;
        _imageViewHeight.constant = _mainImageView.image.size.height;
    }else if (model.type == SPActionSetTypeGoodNight){
        _bgView.backgroundColor = RGB(2, 19, 25, 1.0);
        _sceneNameLbl.text = @"晚安";
        _deleteBtn.hidden = YES;
        _mainImageView.image = Image(@"goodnight");
        _imageViewWidth.constant = _mainImageView.image.size.width;
        _imageViewHeight.constant = _mainImageView.image.size.height;
    }else if (model.type == SPActionSetTypeCustom) {
        _bgView.backgroundColor = RGB(67, 171, 164, 1.0);
        _sceneNameLbl.text = model.actionSet.name;
        _deleteBtn.hidden = NO;
        _mainImageView.image = [[UIImage alloc]init];
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
