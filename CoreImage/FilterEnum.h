//
//  FilterEnum.h
//  CoreImage
//
//  Created by shenzhenshihua on 2018/7/11.
//  Copyright © 2018年 shenzhenshihua. All rights reserved.
//

#ifndef FilterEnum_h
#define FilterEnum_h

typedef NS_ENUM(NSInteger, PhotoToolType){
    PhotoToolTypeBack = 0, ///< 返回上一页
    PhotoToolTypeSelectFilter ///< 选中了某一个滤镜
};

typedef NS_ENUM(NSInteger, FilterCellType){
    FilterCellTypeRefresh = 0, ///< 滤镜加载完成刷新当前cell
    FilterCellTypeShowToolBar  ///< 显示出toolbar让用户调节参数
};

#endif /* FilterEnum_h */
