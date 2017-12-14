//
//  Help.h
//  SmartPlug
//
//  Created by patpat on 2017/11/5.
//  Copyright © 2017年 test. All rights reserved.
//

#ifndef Help_h
#define Help_h

//Margin的枚举
typedef enum {
    VMargin1 = 1,
    VMargin2 = 2,
    VMargin3 = 3,
    VMargin4 = 4,
    VMargin5 = 5,
    VMargin6 = 6,
    VMargin7 = 7,
    VMargin8 = 8,
    VMargin9 = 9,
    VMargin10 = 10,
    VMargin11 = 11,
    VMargin12 = 12,
    VMargin13 = 13,
    VMargin14 = 14,
    VMargin15 = 15,
    VMargin16 = 16,
    VMargin17 = 17,
    VMargin18 = 18,
    VMargin19 = 19,
    VMargin20 = 20,
    VMargin21 = 21,
    VMargin22 = 22,
    VMargin24 = 24,
    VMargin25 = 25,
    VMargin26 = 26,
    VMargin28 = 28,
    VMargin30 = 30,
    VMargin32 = 32,
    VMargin35 = 35,
    VMargin36 = 36,
    VMargin40 = 40,
    VMargin42 = 42,
    VMargin45 = 45,
    VMargin50 = 50,
    VMargin55 = 55,
    VMargin60 = 60,
    VMargin65 = 65,
    VMargin70 = 70,
    VMargin75 = 75,
    VMargin80 = 80,
    VMargin90 = 90,
    VMargin100 = 100
}VMargin;

#define kUpdateAccessoryUrl @"http://api.patpat.dev/V1.3/versionInfo"

#define kAccessoryUUID @"00000025-0000-1000-8000-0026BB765291"
#define kAccessoryUseUUID @"00000026-0000-1000-8000-0026BB765291"
#define kAccessoryRunning_Time @"4AAAF93F-0DEC-11E5-B939-0800200C9A66"
#define kAccessoryRealTime_Energy @"4AAAF931-0DEC-11E5-B939-0800200C9A66"
#define kAccessoryCurrentHourData @"4AAAF932-0DEC-11E5-B939-0800200C9A66"
#define kAccessoryUpdateUUID @"151909D7-3802-11E4-916C-0800200C9A66"
#define kAccessoryUpdateWriteUUID @"151909D4-3802-11E4-916C-0800200C9A66"

//奔溃BuglyAppId
#define   kBuglyAppId @"e42e881f78"

//沙盒路径
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_CACHE        [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//app的版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//app build版本号
#define kAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//app的显示名称
#define kAppDisplayName [[NSBundle mainBundle].localizedInfoDictionary objectForKey:@"CFBundleDisplayName"]

//app的identifier
#define kAppBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]

//自定义NSLog
#ifdef DEBUG
#define HYLog(s, ... )   NSLog(@"<%p %@ %s:(%d)>%@",self,[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__FUNCTION__,__LINE__,[NSString stringWithFormat:(s),##__VA_ARGS__])
#else
#define HYLog( s, ... )
#endif

// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
#define PCString(x)     NSLocalizedString(x, nil)
#define PDString(x)     NSLocalizedString(x, nil)
#define PKString(x)     NSLocalizedString(x, nil)
#define VString(x)      NSLocalizedString(x, nil) //IOS8里String已经作为字符串类
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

//obj是否是 Null 或 Nil
#define ISEMPTY(obj) ((NSNull *)obj == [NSNull null]|| obj == nil)?YES:NO

//obj是否是 Null
#define ISNULL(obj) ((NSNull *)obj == [NSNull null])?YES:NO

//obj是否是 nil
#define ISNIL(obj) (obj == nil)?YES:NO

//obj是否是Class类型
#define ISCLASS(Class,obj)[obj isKindOfClass:[Class class]]

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

//判断字符串是否合法
static inline BOOL isValidString(NSString *s)
{
    return (s && ISCLASS(NSString, s) && [s length]>0)?YES:NO;
}

//判断Number是否合法
static inline BOOL isValidNumber(id n)
{
    return (n && ISCLASS(NSNumber, n))?YES:NO;
}

//判断字典是否合法
static inline BOOL isValidDictionary(NSDictionary *d)
{
    return (d && ISCLASS(NSDictionary, d))?YES:NO;
}

//判断数组是否合法
static inline BOOL isValidArray(NSArray *a)
{
    return (a && ISCLASS(NSArray, a))?YES:NO;
}

//格式化Number
static inline NSNumber * FormatNumber(NSObject *obj,id replaceNumber)
{
    NSNumber *result = replaceNumber;
    if (obj && (isValidString((NSString *)obj) || isValidNumber(obj))){
        result =  @([(NSString *)obj integerValue]);
    }
    return result;
}

//Singleton GCD
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif

//string指定宽和字体的size
#define StringSizeCustomBreakMode(string,width, font,breakmode) \
[string sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:breakmode]

#define StringSize(string,width, font) \
[string sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping]

//当string未nil，或null时格式化为replaceString
#define FormatString(string,replaceString) (string == nil || (NSNull *)string == [NSNull null])?replaceString:string

#define FS(string) (string == nil || (NSNull *)string == [NSNull null])?@"":string

#pragma mark - Frame (宏 x, y, width, height)

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

#define isIOS7 !SYSTEM_VERSION_LESS_THAN(@"7.0")

// 系统控件默认高度
#define kStatusBarHeight        (20.f)

#define kTopBarHeight           (44.f)
#define kBottomBarHeight        (49.f)

#define kNavigationBarHeight   isiPhoneX?88.f:64.f

#define kIphoneXStatusBarHeight (44.f)
#define kIphoneXTopBarHeight    (44.f)
#define kIphoneXBottomBarHeight (83.f)



#define kCellDefaultHeight      (44.f)

#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

#define kScreenWidth    ([UIScreen mainScreen].applicationFrame.size.width)
#define kScreenHeight   ([UIScreen mainScreen].applicationFrame.size.height)

#define KFaceViewHeight         (216.f) //表情键盘高度

/* ****************************************************************************************************************** */
#pragma mark - Funtion Method (宏 方法)

//Image
#define PCImage(imageName) [UIImage imageNamed:imageName]
#define PDImage(imageName) [UIImage imageNamed:imageName]
#define PKImage(imageName) [UIImage imageNamed:imageName]
#define Image(imageName) [UIImage imageNamed:imageName]

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]
#define CGRGB(r,g,b) RGB(r,g,b).CGColor
#define iCGRGB(r,g,b) (id)CGRGB(r,g,b)
#define CGRGBA(r,g,b,a) RGBA(r,g,b,a).CGColor
#define iCGRGBA(r,g,b,a) (id)CGRGBA(r,g,b,a)

#define PPC0 [UIColor clearColor]
#define PPC1 RGB(241,67,90,1.0)
#define PPC2 RGB(70,186,151,1.0)
#define PPC3 RGB(68,68,68,1.0)
#define PPC4 RGB(155,165,167,1.0)
#define PPC5 RGB(205,210,211,1.0)
#define PPC6 RGB(241,243,242,1.0)
#define PPC7 RGB(255,255,255,1.0)
#define PPC8 RGB(248,124,135,1.0)
#define PPC9 RGB(249,251,252,1.0)
#define PPC10 RGB(252,252,252,1.0)
#define PPC11 RGB(67,147,241,1.0)

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前版本
#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])

//如果当前系统版本小于v返回YES，否则返回no
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// 是否Retina屏
#define isRetina                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 960), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)

#define isiPhoneX     (Main_Screen_Width == 375.f && Main_Screen_Height == 812.f)


//是否是iPhone
#define isiPhone UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

//是否是iPad
#define isiPad  UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

// UIView - viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG)\
\
[_OBJECT viewWithTag : _TAG]


// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif


#endif

//Singleton GCD
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif

#ifdef __IPHONE_6_0
# define ALIGN_CENTER NSTextAlignmentCenter
#else
# define ALIGN_CENTER UITextAlignmentCenter
#endif

//用performSelector出现performSelector may cause a leak because its selector is unknown警告解决的办法

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)




