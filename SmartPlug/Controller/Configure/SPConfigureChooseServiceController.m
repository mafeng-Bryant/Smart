//
//  SPConfigureChooseServiceController.m
//  SmartPlug
//
//  Created by patpat on 2017/11/9.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPConfigureChooseServiceController.h"
#import "SPTitleView.h"
#import "SPRoomCell.h"
#import "Help.h"

@interface SPConfigureChooseServiceController ()
@property (nonatomic,strong) SPConfigureZoneModel* model;
@property (nonatomic,strong) NSMutableArray* datasArray;
@property (nonatomic,strong) UIView* headerView;


@end

@implementation SPConfigureChooseServiceController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
                         model:(SPConfigureZoneModel*)model
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTirtleViewText];
    [self setLeftItem];
    self.datasArray = [NSMutableArray array];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [self headerView];
    [SPRoomCell registerNibToTableView:self.tableView];
    [self getDatas];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPAccessoryInfo* info = self.datasArray[indexPath.row];
    SPRoomCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPRoomCell reuseIdentifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.roomLbl.text = info.service.name;
    cell.info = info;
    cell.chooseImageView.hidden = info.isSelected?NO:YES;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    SPAccessoryInfo* info = self.datasArray[indexPath.row];
//    HMService* service = info.service;
//    [self.model.serviceGroup addService:service completionHandler:^(NSError * _Nullable error) {
//        if (!error) {
//            NSLog(@"jksj");
//        }
//    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,0.1f)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
}


- (void)setLeftItem
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(closeAction:)
  forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)closeAction:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setTirtleViewText
{
    SPTitleView* view = [[SPTitleView alloc]initWithFrame:CGRectZero title:self.model.serviceGroup.name];
    self.navigationItem.titleView = view;
}

- (void)getDatas
{
    [self.datasArray removeAllObjects];
    for (HMService* service in self.model.serviceGroup.services) {
        SPAccessoryInfo* info = [[SPAccessoryInfo alloc]init];
        info.service = service;
        info.type = kTypeService;
        info.isSelected = NO;
        [self.datasArray addObject:info];
    }
    [self.tableView reloadData];
}

- (UIView*)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 80)];
        _headerView.backgroundColor = [UIColor clearColor];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"服务名称" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(25, 10, _headerView.frame.size.width - 50, 60);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0,-btn.frame.size.width+100, 0,0);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.backgroundColor = [UIColor blackColor];
        ViewRadius(btn, VMargin10);
        [_headerView addSubview:btn];
    }
    return _headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
