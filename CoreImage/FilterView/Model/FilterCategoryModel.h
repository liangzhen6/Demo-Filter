//
//  FilterCategoryModel.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FilterModel;
@interface FilterCategoryModel : NSObject
@property(nonatomic,copy)NSString * title; ///< 滤镜类别名称
@property(nonatomic,copy)NSString * imageStr; ///< 封面图
@property(nonatomic,copy)NSArray <FilterModel *>* filterArray; ///< 大分类下滤镜数组
@property(nonatomic,assign)BOOL isOpen; ///< 是否是开启模式
+ (id)filterCategoryModelWithDict:(NSDictionary *)dict;

@end
