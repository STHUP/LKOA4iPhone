//
//  NotificationModel.h
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject

/***
 
 <PKID>通知序号</PKID>
 <Title>通知标题</Title>
 <TmpType>通知类型名称</TmpType>
 <ReleaseDept>发布部门</ReleaseDept>
 <ReceptFlag>回执标志</ReceptFlag>
 <IsValid>有效标志</IsValid>
 <ReleaseDate>发布时间</ReleaseDate>
 <ReadNumber>**** </ReadNumber>
 <ReplyNumber>****</ReplyNumber>
 <FirstReadTime>首次阅读时间</FirstReadTime>
 <LastReadTime>最后阅读时间</LastReadTime>
 
 
 通知详情字段
 
 ---<Context>内容</Context>
 ---<Type><![CDATA[3]]></Type>
 ---<ReleaseDeptId>65</ReleaseDeptId>
 ---<TZFW>全部人员</TZFW>
 --<PUB_80_COL_90>通知范围标志 9全部人员 <![CDATA[9]]></PUB_80_COL_90>
 --<PUB_80_COL_100>通知范围 <![CDATA[-1]]></PUB_80_COL_100>
 --<PUB_80_COL_9994>创建时间<![CDATA[2012-06-15 16:56    ]]></PUB_80_COL_9994>
 --<firstdate>首次阅读时间</firstdate>
 ---<lastdate>最后阅读时间</lastdate>
 
 ***/

@property(nonatomic, strong) NSString       *PKID;
@property(nonatomic, strong) NSString       *Title;
@property(nonatomic, strong) NSString       *TmpType;
@property(nonatomic, strong) NSString       *ReleaseDept;
@property(nonatomic, strong) NSString       *ReceptFlag;
@property(nonatomic, strong) NSString       *IsValid;
@property(nonatomic, strong) NSString       *ReleaseDate;
@property(nonatomic, strong) NSString       *ReadNumber;
@property(nonatomic, strong) NSString       *ReplyNumber;
@property(nonatomic, strong) NSString       *FirstReadTime;
@property(nonatomic, strong) NSString       *LastReadTime;

@property(nonatomic, strong) NSString       *Context;
@property(nonatomic, strong) NSString       *Type;
@property(nonatomic, strong) NSString       *ReleaseDeptId;
@property(nonatomic, strong) NSString       *TZFW;
@property(nonatomic, strong) NSString       *PUB_80_COL_90;
@property(nonatomic, strong) NSString       *PUB_80_COL_100;
@property(nonatomic, strong) NSString       *PUB_80_COL_9994;
@property(nonatomic, strong) NSString       *firstdate;
@property(nonatomic, strong) NSString       *lastdate;

@end
