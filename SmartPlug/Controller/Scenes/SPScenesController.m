//
//  SPScenesController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPScenesController.h"
#import "Help.h"
#import <HomeKit/HomeKit.h>
#import "SPTitleView.h"
#import "SPScenesActionCell.h"
#import "SPActionSetModel.h"
#import "UIView+Extensions.h"
#import "SPSceneSetActionController.h"
#import "SPBaseNavigationController.h"

@interface SPScenesController ()<HMHomeManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)HMHomeManager * homeManager;
@property (nonatomic,strong) HMHome* currentHome;
@property (nonatomic,strong) NSMutableArray* datasArray;

@end

@implementation SPScenesController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setRightItem];
    [self setTitleViewText];
    self.datasArray = [NSMutableArray array];
    [SPScenesActionCell registerNibToCollectionView:self.collectionView];
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.datasArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)_collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPActionSetModel* model = self.datasArray[indexPath.row];
    SPScenesActionCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[SPScenesActionCell reuseIdentifier] forIndexPath:indexPath];
    cell.model = model;
    [cell.deleteBtn addTarget:self action:@selector(deleteActionSet:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteBtn.model = model;
    cell.managerBtn.model = model;
    [cell configureData:model];
    [cell.managerBtn addTarget:self action:@selector(managerAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [SPScenesActionCell cellSize:collectionView];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    CGFloat marigin = VMargin10;
    return UIEdgeInsetsMake(marigin, marigin,marigin,marigin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return VMargin10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return VMargin10;
}

-(void)collectionView:(UICollectionView *)_collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SPActionSetModel* model = self.datasArray[indexPath.row];
    HMActionSet* actionSet = model.actionSet;
    if (actionSet.actions.count>0) {
       [self.currentHome executeActionSet:actionSet completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                [self showTips];
             }
        }];
    }else {
        UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"错误" message:@"操作集中无操作." preferredStyle:1];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:^(UIAlertAction * _Nonnull action) {
        }];
        [inputNameAlter addAction:action1];
        [self presentViewController:inputNameAlter animated:YES completion:^{}];
    }
}

- (void)showTips
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"执行成功";
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)managerAction:(SPSceneButton*)btn
{
    SPActionSetModel* model = btn.model;
    SPSceneSetActionController* chooseVC = [[SPSceneSetActionController alloc]initWithNibName:@"SPSceneSetActionController" bundle:nil
                              currentHome:_currentHome model:model];
    SPBaseNavigationController* na = [[SPBaseNavigationController alloc]initWithRootViewController:chooseVC];
    [self presentViewController:na animated:YES completion:nil];
}

- (void)deleteActionSet:(SPSceneButton*)btn
{
    SPActionSetModel* model = btn.model;
    __weak typeof (self) weakSelf = self;
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要删除这个场景吗?" preferredStyle:1];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"删除" style:0 handler:^(UIAlertAction * _Nonnull action){
        [weakSelf.currentHome removeActionSet:model.actionSet completionHandler:^(NSError * _Nullable error) {
            if (!error) {
                [weakSelf setTitleViewText];
            }
        }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

#pragma mark HMHomeManagerDelegate

- (void)homeManagerDidUpdateHomes:(HMHomeManager *)manager
{
    [self setTitleViewText];
}

- (void)homeManagerDidUpdatePrimaryHome:(HMHomeManager *)manager
{
    [self setTitleViewText];
}

- (void)setRightItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 21, 21);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(addAccessory:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor clearColor];
    ViewRadius(btn, 10);
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addAccessory:(UIButton*)btn
{
    __weak typeof (self) weakSelf = self;
    UIAlertController *inputNameAlter = [UIAlertController alertControllerWithTitle:@"添加场景" message:@"请输入场景名称" preferredStyle:1];
    [inputNameAlter addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"场景";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"添加" style:0 handler:^(UIAlertAction * _Nonnull action) {
        NSString *newName =inputNameAlter.textFields.firstObject.text;
        BOOL isExist = NO;
        for (SPActionSetModel* model in self.datasArray) {
            if ([model.actionSet.name isEqualToString:newName]) {
                isExist = YES;
                break;
            }
        }
        if (isExist) {
            UIAlertController* inputNameAlert = [UIAlertController alertControllerWithTitle:@"错误" message:@"已有相似场景名称" preferredStyle:1];
            UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"好的" style:0 handler:nil];
            [inputNameAlert addAction:action1];
            [self presentViewController:inputNameAlert animated:YES completion:nil];
            return ;
        }
        [weakSelf.currentHome addActionSetWithName:newName completionHandler:^(HMActionSet * _Nullable actionSet, NSError * _Nullable error) {
            if (!error) {
                [weakSelf setTitleViewText];
            }
        }];
    }];
    [inputNameAlter addAction:action1];
    [inputNameAlter addAction:action2];
    [self presentViewController:inputNameAlter animated:YES completion:^{}];
}

#pragma mark set and get method

- (HMHomeManager *)homeManager
{
    if (_homeManager == nil) {
        _homeManager =  [HMHomeManager new];
        _homeManager.delegate = self;
    }
    return _homeManager;
}

- (void)setTitleViewText
{
    NSString* title = @"家";
    for (HMHome* home in self.homeManager.homes) {
        if (home.isPrimary) {
            _currentHome = home;
            title = home.name;
        }
    }
    [self.datasArray removeAllObjects];
    //get action set data
    if (_currentHome) {
        for (HMActionSet* set in _currentHome.actionSets) {
            SPActionSetModel* model = [[SPActionSetModel alloc]init];
            if ([set.actionSetType isEqual:HMActionSetTypeUserDefined]) {
                model.type = SPActionSetTypeCustom;
            }else if ([set.actionSetType isEqual:HMActionSetTypeWakeUp]){
                model.type = SPActionSetTypeGoodMorning;
            }else if ([set.actionSetType isEqual:HMActionSetTypeHomeDeparture]){
                model.type = SPActionSetTypeGoOut;
            }else if ([set.actionSetType isEqual:HMActionSetTypeHomeArrival]){
                model.type = SPActionSetTypeComeBack;
            }else if ([set.actionSetType isEqual:HMActionSetTypeSleep]){
                model.type = SPActionSetTypeGoodNight;
            }
            model.actionSet = set;
            [self.datasArray addObject:model];
        }
        [self sortDatas];
    }
   self.navigationItem.titleView = [[SPTitleView alloc]initWithFrame:CGRectZero title:title];
}

- (void)sortDatas
{
    NSMutableArray* newDatas = [NSMutableArray array];
    for (SPActionSetModel* model in self.datasArray) {
        if (model.type != SPActionSetTypeCustom) {
            [newDatas addObject:model];
        }
    }
    for (SPActionSetModel* model in self.datasArray) {
        if (model.type == SPActionSetTypeCustom) {
            [newDatas addObject:model];
        }
    }
    self.datasArray = [NSMutableArray arrayWithArray:newDatas];
    [self.collectionView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
