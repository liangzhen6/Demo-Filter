//
//  PhotoFilter.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/19.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "PhotoFilter.h"
#import <CoreImage/CoreImage.h>
@interface PhotoFilter ()<NSCopying,NSMutableCopying>
//@property(nonatomic,copy)ResultBlock resultBlock;
@end
static PhotoFilter * _photoFilter;
@implementation PhotoFilter
+ (id)sharePhotoFilter {
    return [[self alloc] init];
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_photoFilter == nil) {
            _photoFilter = [super allocWithZone:zone];
        }
    });
    return _photoFilter;
}

- (id)copyWithZone:(NSZone *)zone {
    return _photoFilter;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _photoFilter;
}
//处理滤镜
- (void)setFilterWithNames:(NSArray <NSString *>*)names originImage:(UIImage *)originImage complete:(ResultFilterBlock)resultBlock {
    //异步操作
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *resultImage = [self outputImageWithFilterName:[names firstObject] originImage:originImage];
        //切换主队列
        dispatch_async(dispatch_get_main_queue(), ^{
            if (resultImage) {
                if (resultBlock) {
                    resultBlock(resultImage, YES);
                }
            } else {
                if (resultBlock) {
                    resultBlock(nil, NO);
                }
            }
        });
      
    });
   
}

- (UIImage *)outputImageWithFilterName:(NSString *)filterName originImage:(UIImage *)originImage {
    //1.将 image 转化为 CIimage
    CIImage *ciImage = [[CIImage alloc] initWithImage:originImage];
    
    //2.创建滤镜
    CIFilter * filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
    //设置先关参数
//    [filter setValue:@(20.f) forKey:@"inputRadius"];
//    CIFilter * filter = [CIFilter filterWithName:filterName];
//    [filter setValue:[UIColor whiteColor].CIColor forKey:@"inputColor0"];
//
//    [filter setValue:[UIColor blueColor].CIColor forKey:@"inputColor1"];
//    [filter setValue:[CIVector vectorWithX:1000 Y:500] forKey:@"inputCenter"];
    
//    inputTexture
    
//    [filter setValue:ciImage forKey:@"inputTexture"];
    
    //3.渲染输出CIImage
    CIImage * outputImage = [filter outputImage];
    
    //4.获取绘制上下文
    CIContext * context = [CIContext contextWithOptions:nil];
    
    //5.创建输出CGIamge
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    // 创建 UIimage 并且 给出原照片的旋转方向。
    UIImage * image = [UIImage imageWithCGImage:cgImage scale:1.0 orientation:originImage.imageOrientation];
    CGImageRelease(cgImage);
    return image;
}

@end
