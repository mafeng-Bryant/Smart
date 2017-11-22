//
//  SPScenesActionCell.h
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPBaseCollectionCell.h"
#import "SPActionSetModel.h"
#import "SPSceneButton.h"
@interface SPScenesActionCell : SPBaseCollectionCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet SPSceneButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *sceneNameLbl;
@property (nonatomic,strong) SPActionSetModel* model;
@property (weak, nonatomic) IBOutlet SPSceneButton *managerBtn;


+ (CGSize)cellSize:(UICollectionView *)collectionView;

- (void)configureData:(SPActionSetModel*)model;

@end
