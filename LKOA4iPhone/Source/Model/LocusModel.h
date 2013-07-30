//
//  LocusModel.h
//  LKOA4iPhone
//
//  Created by  STH on 7/29/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocusModel : NSObject

/***
 <RecId>办理记录ID</RecId>
 <FromId>表单ID</FromId>
 <FldId>字段ID</FldId>
 <Content>意见内容</Content>
 <CreateTime>创建时间</CreateTime>
 <UserName>用户名称</UserName>
 <DpetName>部门名称</DpetName>
 ***/

@property (nonatomic, strong) NSString *RecId;
@property (nonatomic, strong) NSString *FromId;
@property (nonatomic, strong) NSString *FldId;
@property (nonatomic, strong) NSString *Content;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *DpetName;


@end
