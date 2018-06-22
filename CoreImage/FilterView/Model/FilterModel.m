//
//  FilterModel.m
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import "FilterModel.h"

@implementation FilterModel
+ (id)filterModelWithDict:(NSDictionary *)dict {
    FilterModel * filterModel = [[FilterModel alloc] init];
    filterModel.filterName = dict[@"filterName"];
    filterModel.filterCode = dict[@"filterCode"];
    filterModel.canVerb = YES;
    
    return filterModel;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@===%@===%d===",_filterName,_filterCode,_canVerb];
}

@end
