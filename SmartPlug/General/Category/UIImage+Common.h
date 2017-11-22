//
//  UIImage+Common.h
//  Suibianzou
//
//  Created by liuwenda on 15/3/25.
//  Copyright (c) 2015年 感知网络. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>


@interface UIImage (Common)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

//压缩到指定尺寸，图片不变形
- (UIImage *)resizedScaledToSize:(CGSize)size;
//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
//压缩图片，尺寸比例不变，图片不变形
- (UIImage *)equalRatioCompressForWidth:(CGFloat)defineWidth;
//压缩图片宽高，不超过maxResolution
- (UIImage *)scaleCompressForMaxResolution:(CGFloat)maxResolution;

+ (UIImage *)getImageFromPHAsset:(PHAsset *)asset;

@end
