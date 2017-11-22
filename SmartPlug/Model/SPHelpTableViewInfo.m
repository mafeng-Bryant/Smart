//
//  SPHelpTableViewInfo.m
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SPHelpTableViewInfo.h"
#import "Help.h"

@implementation SPHelpTableViewRowObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.height = 0.0f;
        self.title = @"";
        self.value = @"";
        self.type = SPHelpRowTypeNormal;
    }
    return self;
}

@end

@implementation SPHelpTableViewSectionObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerHeight = 10.0f;
    }
    return self;
}
@end


@implementation SPHelpTableViewInfo

- (void)configureData:(NSMutableArray *)data
   containerViewWidth:(float)width
{
    [data removeAllObjects];
    
    for (int i = 0; i < 6; i++) {
    
        /*=== section one ===*/ //
        SPHelpTableViewSectionObject *sectionObject = [[SPHelpTableViewSectionObject alloc]init];
        sectionObject.type = SPHelpSectionTypeOne;
        sectionObject.uuId = [NSString stringWithFormat:@"section%d",i];
        sectionObject.rows = [[NSMutableArray alloc]init];
        sectionObject.title = [self getSectionTitle:i];
        [data addObject:sectionObject];
        
        //默认行
        SPHelpTableViewRowObject *rowObject = [[SPHelpTableViewRowObject alloc]init];
        rowObject.height = 0.1f;
        rowObject.type = SPHelpRowTypeDefalut;
        [sectionObject.rows addObject:rowObject];
        
        if ([self.currentChooseSectionObject.uuId isEqualToString:sectionObject.uuId]) {
            if (self.isFold) {
                SPHelpTableViewRowObject *rowObject = [[SPHelpTableViewRowObject alloc]init];
                rowObject.height = UITableViewAutomaticDimension;
                rowObject.value = [self getRowDetails:i];
                rowObject.type = SPHelpRowTypeNormal;
                [sectionObject.rows addObject:rowObject];
            }
        }
    }
}

- (NSString*)getSectionTitle:(NSInteger)index
{
    if (index == 0) {
        return @"如何使用我们的App控制HomeKit产品?";
    }else if (index == 1){
        return @"首次使用,如何通过苹果终端对智能设备进行配置?";
    }else if (index == 2){
        return @"如何使用App配置设备";
    }else if (index ==3){
        return @"如何管理用户?";
    }else if (index ==4){
        return @"如何让其他家庭成员也可以控制设备?";
    }else if (index ==5){
        return @"如何使用Siri控制智能设备?";
    }
    return @"";
}

- (NSString*)getRowDetails:(NSInteger)index
{
    if (index == 0) {
        return @"请使用您的苹果终端进入App Store, 并下载'欧智家居'App; 在完成必要设置后, 即可使用该应用软件控制您的HomeKit智能产品";
    }else if (index == 1){
        return @"(1)确保Wi-Fi网络良好, 然后将智能设备接通电源并长按开关键5秒直到蓝灯闪烁;\n(2)点击进入您的苹果终端的'设置'选项，然后进入'无线局域网'选项\n(3)在Wi-Fi列表中找到智能设备并将其加入Wi-Fi网络中;\n(4)智能设备会开启自动配置，直至红色闪烁指示灯灭";
    }else if (index == 2){
        return @"(1)苹果终端完成对智能设备的配置后, 点击进入'欧智家居'App;\n(2)根据您的需要定义好'家'和'房间'后,点击'设备'页面右上角的'+'并找到智能设备;\n(3)点击添加该设备, 过程中会需要图像扫描智能设备上的设置代码以完成配对.";
    }else if (index ==3){
        return @"在'配置'页面的'用户'选项下， 点击'+', 可以实现添加或移除用户";
    }else if (index ==4){
        return @"要让其他家庭成员可以控制家的设备, 你需要通过Apple ID添加家庭成员, 具体请参考'如何管理用户'?";
    }else if (index ==5){
        return @"您可以直接对Siri提出打开或关闭智能设备的指令，也可以直接对Siri说出启动已完成预设置的'场景'模式指令; 一般情况下，Siri可以识别您对智能设备的命名,也可以识别您在App中对'家'和'房间'的定义；如果出现Siri无法识别的情况，您可以尝试更改命名以便于Siri可以准确的识别";
    }
    return @"";
}






@end
