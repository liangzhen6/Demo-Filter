//
//  FilterCollectionViewCell.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FilterModel;

typedef void(^FilterBlock)(FilterModel * model);
@interface FilterCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)FilterModel * filterModel;
@property(nonatomic,copy)FilterBlock filterBlock;
@end
