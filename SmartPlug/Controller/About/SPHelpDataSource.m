//
//  SPHelpDataSource.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPHelpDataSource.h"
#import "SPHelpDetailsCell.h"
#import "SPConfigureUserCell.h"
#import "SPHelpHeaderView.h"
#import "Help.h"

@interface SPHelpDataSource()
@property (nonatomic,strong) SPHelpTableViewInfo* tableViewInfo;

@end

@implementation SPHelpDataSource

- (id)initWithTableView:(UITableView *)tableView
          tableViewInfo:(SPHelpTableViewInfo *)tableViewInfo
{
    self = [super initWithTableView:tableView];
    if (self) {
        //register cell
        [SPHelpDetailsCell registerNibToTableView:tableView];
        [SPConfigureUserCell registerNibToTableView:tableView];
        tableView.separatorColor = [UIColor clearColor];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.estimatedRowHeight = 44;
        tableView.scrollEnabled = YES;
        self.tableViewInfo = tableViewInfo;
        [self refreshUI];
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self sectionObject:section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHelpTableViewRowObject *rowObject = [self rowObject:indexPath];
    if (rowObject.type == SPHelpRowTypeNormal) {
        
        SPHelpDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPHelpDetailsCell reuseIdentifier] forIndexPath:indexPath];
        cell.detailLbl.text = rowObject.value;
        return cell;
        
    }else if (rowObject.type == SPHelpRowTypeDefalut){
    
        SPConfigureUserCell *cell = [tableView dequeueReusableCellWithIdentifier:[SPConfigureUserCell reuseIdentifier] forIndexPath:indexPath];
        return cell;
    
    }
    return nil;
}

#pragma mark  UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self rowObject:indexPath].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self headView:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.01f)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Private

- (UIView*)headView:(NSInteger)section
{
    SPHelpTableViewSectionObject *sectionObject = [self sectionObject:section];
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50)];
    view.backgroundColor = [UIColor clearColor];
    SPHelpHeaderView* headView = [SPHelpHeaderView instanceHeadView];
    headView.titleLbl.text = sectionObject.title;
    headView.section = section;
    if (self.tableViewInfo.currentChooseSectionObject && [self.tableViewInfo.currentChooseSectionObject.uuId isEqualToString:sectionObject.uuId]) {
        headView.titleLbl.textColor = [UIColor blackColor];
        headView.titleLbl.font = [UIFont fontWithName:@"Avenir-Roman" size:12];
    }else {
        headView.titleLbl.textColor = RGB(155,165,167,1.0);
        headView.titleLbl.font = [UIFont systemFontOfSize:12];
    }
    headView.frame = CGRectMake(20, 0, self.tableView.frame.size.width-40, 50);
    [view addSubview:headView];
    ViewRadius(headView, 5);
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(foldAction:)];
    [headView addGestureRecognizer:tap];
    return view;
}

- (SPHelpTableViewSectionObject *)sectionObject:(NSInteger)section
{
    return  self.dataSource[section];
}

- (SPHelpTableViewRowObject *)rowObject:(NSIndexPath *)indexPath
{
    SPHelpTableViewSectionObject *sectionObject = self.dataSource[indexPath.section];
    return sectionObject.rows[indexPath.row];
}

- (void)refreshUI
{
    [self.tableViewInfo configureData:self.dataSource containerViewWidth:self.tableView.frame.size.width];
    [self.tableView reloadData];
}

- (void)foldAction:(UITapGestureRecognizer*)tap
{
    SPHelpHeaderView* headView = (SPHelpHeaderView*)tap.view;
    SPHelpTableViewSectionObject *sectionObject = self.dataSource[headView.section];
    if (!self.tableViewInfo.currentChooseSectionObject) {
        self.tableViewInfo.currentChooseSectionObject = sectionObject;
        self.tableViewInfo.isFold = YES;
        [self refreshUI];
    }else {
      //判断是不是点击同一个row
        if ([self.tableViewInfo.currentChooseSectionObject.uuId isEqualToString:sectionObject.uuId]) {
            if (self.tableViewInfo.isFold) {
                self.tableViewInfo.currentChooseSectionObject = nil;
                self.tableViewInfo.isFold = NO;
                [self refreshUI];
            }else {
                self.tableViewInfo.currentChooseSectionObject = sectionObject;
                self.tableViewInfo.isFold = YES;
                [self refreshUI];
            }
        }else {
            self.tableViewInfo.currentChooseSectionObject = sectionObject;
            self.tableViewInfo.isFold = YES;
            [self refreshUI];
        }
   }
}

@end
