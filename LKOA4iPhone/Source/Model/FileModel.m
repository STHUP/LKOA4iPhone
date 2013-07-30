//
//  FileModel.m
//  LKOA4iPhone
//
//  Created by  STH on 7/29/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

@synthesize XH = _XH; // 序号
@synthesize FileStatusName = _FileStatusName; // 文件状态
@synthesize FileTitle = _FileTitle; // 文件标题
@synthesize FormName = _FormName; // 表单类型名称
@synthesize RecSrcTypeName = _RecSrcTypeName; // 来源环节名称
@synthesize WFL_100_COL_40 = _WFL_100_COL_40; // 交来时间
@synthesize WFL_100_COL_110 = _WFL_100_COL_110; // 状态代码

-(NSString *)description
{
    return self.FileTitle;
}


@end
