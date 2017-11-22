//
//  SPHelpTableViewInfo.h
//  SmartPlug
//
//  Created by patpat on 2017/11/12.
//  Copyright © 2017年 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    SPHelpSectionTypeOne
}SPHelpSectionType;

typedef enum {
    SPHelpRowTypeNormal,
    SPHelpRowTypeDefalut,
}SPHelpRowType;

@interface SPHelpTableViewRowObject : NSObject
@property(nonatomic,assign)SPHelpRowType type;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,strong)id object; //object
@property(nonatomic,strong)NSString *title;//title
@property(nonatomic,strong)NSString *value;//value

@end

@interface SPHelpTableViewSectionObject : NSObject
@property(nonatomic,assign)SPHelpSectionType type;
@property(nonatomic,strong)NSMutableArray *rows;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,assign)float headerHeight;
@property(nonatomic,assign)float footerHeight;
@property(nonatomic,strong)NSString* uuId;

@end


@interface SPHelpTableViewInfo : NSObject
@property(nonatomic,assign)BOOL isFold;
@property(nonatomic,strong) SPHelpTableViewSectionObject* currentChooseSectionObject;

- (void)configureData:(NSMutableArray *)data
   containerViewWidth:(float)width;

@end
