//
//  PhotoToolBarView.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/21.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterModel;
typedef void(^PhotoToolBlock)(PhotoToolType photoToolType, FilterModel *_Nullable filterModel);
@interface PhotoToolBarView : UIView
@property(nonatomic,copy)PhotoToolBlock photoToolBlock;
+ (id)photoToolBarView;
- (void)initOriginImage:(UIImage *)image;

@end
