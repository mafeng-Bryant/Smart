//
//  SPBaseCollectionCell.m
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseCollectionCell.h"

@implementation SPBaseCollectionCell

+ (UINib *)nib{
    return  [UINib nibWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)registerNibToCollectionView:(UICollectionView *)cv
{
    [cv registerNib:[self nib] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

+ (void)registerClassToCollectionView:(UICollectionView *)cv
{
    [cv registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

@end
