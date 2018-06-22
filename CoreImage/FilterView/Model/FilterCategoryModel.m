//
//  FilterCategoryModel.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterCategoryModel.h"
#import "FilterModel.h"
@implementation FilterCategoryModel
+ (id)filterCategoryModelWithDict:(NSDictionary *)dict {
    FilterCategoryModel * categoryModel = [[FilterCategoryModel alloc] init];
    categoryModel.title = dict[@"title"];
    categoryModel.imageStr = dict[@"imageStr"];
    categoryModel.isOpen = NO;
    
    NSMutableArray * subArrM = [[NSMutableArray alloc] init];
    for (NSDictionary * subDict in dict[@"filterArray"]) {
        [subArrM addObject:[FilterModel filterModelWithDict:subDict]];
    }
    categoryModel.filterArray = subArrM;
    
    return categoryModel;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@===%@===%d===%@",_title,_imageStr,_isOpen,_filterArray];
}

@end
