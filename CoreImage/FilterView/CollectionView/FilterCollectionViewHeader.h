//
//  FilterCollectionViewHeader.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterCategoryModel;

typedef void(^HeaderBlock)(FilterCategoryModel *categoryModel);
@interface FilterCollectionViewHeader : UICollectionReusableView
@property(nonatomic,strong)FilterCategoryModel * categoryModel;
@property(nonatomic,copy)HeaderBlock block;

@end
