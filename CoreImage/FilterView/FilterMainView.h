//
//  FilterMainView.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/21.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterModel;
@interface FilterMainView : UIView
+ (id)filterMainView;
- (void)initOriginImage:(UIImage *)image;
- (void)selectFilterModel:(FilterModel *)filterModel;
@end
