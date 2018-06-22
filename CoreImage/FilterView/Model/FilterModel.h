//
//  FilterModel.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/6/22.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject
@property(nonatomic,copy)NSString *filterName;
@property(nonatomic,copy)NSString *filterCode;
@property(nonatomic,assign)BOOL canVerb;

@property(nonatomic,strong)UIImage * originImage;
@property(nonatomic,strong)UIImage * filterImage;

+ (id)filterModelWithDict:(NSDictionary *)dict;
@end
