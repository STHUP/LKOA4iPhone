//
//  InfomationModel.h
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfomationModel : NSObject

/****
 
<PKID>序号</PKID>
<XXBT>信息标题</XXBT>
<RDBZ>热点标志</RDBZ>
<TPBZ>图片标志</TPBZ>
<FBRQ>发布日期</FBRQ>
<FBR>发布人</FBR>
<FBRNAME>发布人名称</FBRNAME>
<SHBZ>审核标志</SHBZ>
<FBZT>发布状态</FBZT>
<SSLM>栏目名称</SSLM>
<FBLX>发布类型</FBLX>
<LMZT>栏目状态标志</LMZT>
<FBBM>发布部门序号</FBBM>
 
 
 详情字段
<XSGS>显示格式  0：普通信息 1：连接文件</XSGS>
 
 ×××特别注意××××
 如果XSGS为0，则取XXNR的数据，如果XSGS为1，则取LINK的内容。
 
<LINK>连接信息内容</LINK>
<XXNR>信息内容</XXNR>
 
<XXLX>编辑器类型</XXLX>

****/


@property(nonatomic, strong) NSString       *PKID;
@property(nonatomic, strong) NSString       *XXBT;
@property(nonatomic, strong) NSString       *RDBZ;
@property(nonatomic, strong) NSString       *TPBZ;
@property(nonatomic, strong) NSString       *FBRQ;
@property(nonatomic, strong) NSString       *FBR;
@property(nonatomic, strong) NSString       *FBRNAME;
@property(nonatomic, strong) NSString       *SHBZ;
@property(nonatomic, strong) NSString       *FBZT;
@property(nonatomic, strong) NSString       *SSLM;
@property(nonatomic, strong) NSString       *FBLX;
@property(nonatomic, strong) NSString       *LMZT;
@property(nonatomic, strong) NSString       *FBBM;

@property(nonatomic, strong) NSString       *XSGS;
@property(nonatomic, strong) NSString       *LINK;
@property(nonatomic, strong) NSString       *XXNR;
@property(nonatomic, strong) NSString       *XXLX;
@end
