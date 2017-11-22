//
//  PPUIFont+Extensions.m
//  PatPat
//
//  Created by Bruce He on 15/5/27.
//  Copyright (c) 2015年 http://www.patpat.com. All rights reserved.
//

#import "PPUIFont.h"

@implementation UIFont(PP_FONT)

+ (NSString *)ppFontName
{
    return @"Avenir-Light";
}

+ (NSString *)ppFontRegularName
{
    return @"Avenir-Roman";
}

+ (NSString *)ppFontRegularItalicName
{
    return @"HelveticaNeue-Italic";
}

+ (NSString *)ppFontItalicName
{
    return @"HelveticaNeue-Italic";
}

+ (NSString *)ppFontBorderName
{
    return @"Avenir-Roman";
}

+ (NSString *)ppFontHeavyName
{
    return @"Avenir-Heavy";
}

+ (NSString *)ppFontObliqueName
{
    return @"Avenir-LightOblique";
}

+ (UIFont *)ppFont:(CGFloat)fontSize
{
    return FONT([UIFont ppFontName], fontSize);
}

+ (UIFont *)ppFontRegular:(CGFloat)fontSize
{
    return FONT([UIFont ppFontRegularName], fontSize);
}

+ (UIFont *)ppFontRegularItalic:(CGFloat)fontSize
{
    return FONT([UIFont ppFontRegularItalicName], fontSize);
}

+ (UIFont *)ppFontItalic:(CGFloat)fontSize
{
    return FONT([UIFont ppFontItalicName], fontSize);
    
}

+ (UIFont *)ppFontBorder:(CGFloat)fontSize
{
    return FONT([UIFont ppFontBorderName], fontSize);
}

+ (UIFont *)ppFontHeavy:(CGFloat)fontSize
{
    return FONT([UIFont ppFontHeavyName], fontSize);
}

+ (UIFont*)ppFontOblique:(CGFloat)fonsize
{
   return  FONT([UIFont ppFontObliqueName], fonsize);
    
}


@end
