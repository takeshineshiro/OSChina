//
//  UIImage+BxExtension.h
//  OSChina
//
//  Created by baxiang on 14-2-12.
//  Copyright (c) 2014年 巴翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BxExtension)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 图片先压缩到size大小然后再做圆角大小为r，然后在view上圆角与图片可能被等比拉伸/缩放
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
// 先在原图做r大的圆角，然后在view上圆角与图片可能被等比拉伸/缩放
+ (id)createRoundedRectImage:(UIImage*)image radius:(NSInteger)r;

// 文字转为图片
+ (UIImage *)imageFromText:(NSString *)text;
+ (UIImage *)imageFromText:(NSString *)text font:(UIFont *)font size:(CGSize)size;

// 缩放尺寸最终大小是newSize
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

// 裁剪图片
- (UIImage *) imageCroppedToRect:(CGRect)rect;
// 裁减正方形区域
- (UIImage *) squareImage;

// 按size的宽高比例截取
- (UIImage *) ImageFitInSize:(CGSize)size;

// 画水印
// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect;
// 文字水印
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;


// 蒙板
- (UIImage *) imageWithColor:(UIColor*)color inRect:(CGRect)rect;
//- (void) drawInRect:(CGRect)rect withImageMask:(UIImage *)mask;
//- (void) drawMaskedColorInRect:(CGRect)rect withColor:(UIColor*)color;

// 保存图像文件
- (BOOL) writeImageToFileAtPath:(NSString*)aPath;
// 缩放尺寸最终大小是rect.size
-(UIImage *)resizeImage:(CGRect)rect;
// 缩放尺寸最终大小比例缩放
- (UIImage *) imageReSize:(CGSize)size;

// 图像旋转(角度)
- (UIImage *) imageRotatedByDegrees:(CGFloat)degrees;

// 黑白
- (UIImage *)convertToGrayScale;    // 有黑底
- (UIImage *)imageWithBlackWhite;

@end


@interface UIImage (Border)

- (UIImage *) imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow;
- (UIImage *) imageWithTransparentBorder:(NSUInteger)thickness;

@end

// https://github.com/mustangostang/UIImage-Resize
@interface UIImage (Resize)

- (UIImage *) resizedImageByMagick: (NSString *) spec;
- (UIImage *) resizedImageByWidth:  (NSUInteger) width;
- (UIImage *) resizedImageByHeight: (NSUInteger) height;
- (UIImage *) resizedImageWithMaximumSize: (CGSize) size;
- (UIImage *) resizedImageWithMinimumSize: (CGSize) size;

@end

@interface UIImage (MGProportionalFill)

typedef enum {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale


@end
