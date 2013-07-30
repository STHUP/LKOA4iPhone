//
//  FileModel.h
//  LKOA4iPhone
//
//  Created by  STH on 7/29/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (nonatomic, strong) NSString *XH; // 序号
@property (nonatomic, strong) NSString *FileStatusName; // 文件状态
@property (nonatomic, strong) NSString *FileTitle; // 文件标题
@property (nonatomic, strong) NSString *FormName; // 表单类型名称
@property (nonatomic, strong) NSString *RecSrcTypeName; // 来源环节名称
@property (nonatomic, strong) NSString *WFL_100_COL_40; // 交来时间
@property (nonatomic, strong) NSString *WFL_100_COL_110; // 状态代码

@end
