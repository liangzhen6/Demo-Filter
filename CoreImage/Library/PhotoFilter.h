//
//  PhotoFilter.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/19.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^ResultFilterBlock)(UIImage *image, BOOL success);

@interface PhotoFilter : NSObject
+ (id)sharePhotoFilter;

- (void)setFilterWithNames:(NSArray <NSString *>*)names originImage:(UIImage *)originImage complete:(ResultFilterBlock)resultBlock;

@end
