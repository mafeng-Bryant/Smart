//
//  SPBaseCollectionCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPBaseCollectionCell : UICollectionViewCell
+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
+ (void)registerNibToCollectionView:(UICollectionView *)cv;
+ (void)registerClassToCollectionView:(UICollectionView *)cv;
@end
