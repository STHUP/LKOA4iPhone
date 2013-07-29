//
//  Transfer+ParseXML.m
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "Transfer+ParseXML.h"
#import "TBXML.h"
#import "FileModel.h"
#import "InfomationModel.h"
#import "NotificationModel.h"

@interface Transfer (private)

// 登录
- (NSDictionary *) login:(TBXMLElement *) bodyElement;
// 获取待办公文列表及请示报告列表
- (NSDictionary *) getPendingFilesList:(TBXMLElement *) bodyElement;
// 获取信息中心最新信息列表，同时也用于取得数量
- (NSArray *) getLatestInfo:(TBXMLElement *) bodyElement;
// 获取信息中心最新通知列表，同时也用于取得数量
- (NSArray *) getLastestNofify:(TBXMLElement *) bodyElement;
// 获取信息详情
- (InfomationModel *) getInfomationDetail:(TBXMLElement *) bodyElement;
// 获取通知详情
- (NotificationModel *) getNotificationDetail:(TBXMLElement *) bodyElement;
// 取附件内容
- (NSDictionary *) getAttachmentInfo:(TBXMLElement *) bodyElement;


@end

@implementation Transfer (ParseXML)

- (id) ParseXMLWithReqName:(NSString *) reqName
                           xmlString:(NSString *) xml
{
    NSError *error = nil;
    TBXML *tbXML = [[TBXML alloc] initWithXMLString:xml error:&error];
    if (error) {
        NSLog(@"%@->ParseXML[%@]:%@", [self class] , reqName, [error localizedDescription]);
        return nil;
    }
    
    TBXMLElement *rootElement = [tbXML rootXMLElement];
    if (rootElement) {
        TBXMLElement *bodyElement = [TBXML childElementNamed:@"soap:Body" parentElement:rootElement];
        while (bodyElement) {
            if ([reqName isEqualToString:@"getLoginInfoService"]) {
                return [NSDictionary dictionaryWithDictionary:[self login:bodyElement]];
            } else if ([reqName isEqualToString:@"getMyDealFilesList"]) {
                return [self getPendingFilesList:bodyElement];
            } else if ([reqName isEqualToString:@"gettzListService"]) {
                return [self getLastestNofify:bodyElement];
            } else if ([reqName isEqualToString:@"getxxzzListService"]) {
                return [self getLatestInfo:bodyElement];
            } else if ([reqName isEqualToString:@"GetInformService"]) {
                return [self getInfomationDetail:bodyElement];
            } else if ([reqName isEqualToString:@"GetNotifyInformService"]) {
                return [self getNotificationDetail:bodyElement];
            } else if ([reqName isEqualToString:@"getFormAttInfo"]) {
                return [self getAttachmentInfo:bodyElement];
            }
        }
        
    }
    
    return nil;
}

// 登陆
/******
 Request DIC Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"LoginService.asmx" forKey:kWebServiceName];
 [dic setObject:@"getLoginInfoService" forKey:kMethodName];
 
 NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
 [tempDic setObject:@"LogIn" forKey:@"Function"];
 [tempDic setObject:@"qiaolei" forKey:@"UserName"];
 [tempDic setObject:@"111" forKey:@"PassWord"];
 [tempDic setObject:@"WAP" forKey:@"LoginType"];
 NSDictionary *qryDic = [NSDictionary dictionaryWithObjectsAndKeys:tempDic, @"Qry", nil];
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:qryDic forKey:@"sLoginXML"];
 
 [dic setObject:paramDic forKey:kParamName];
 
 *******/

/*******
 
 Response XML Sample:
 
 <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wsa="http://schemas.xmlsoap.org/ws/2004/03/addressing" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" xmlns:wsu="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd"><soap:Header><wsa:Action>http://tempuri.org/getLoginInfoServiceResponse</wsa:Action><wsa:MessageID>uuid:2d1c8e83-da8f-4e96-8c24-91482089d266</wsa:MessageID><wsa:RelatesTo>uuid:d50a2722-b140-4503-bffa-0ee7565d7120</wsa:RelatesTo><wsa:To>http://schemas.xmlsoap.org/ws/2004/03/addressing/role/anonymous</wsa:To><wsse:Security><wsu:Timestamp wsu:Id="Timestamp-d3823aae-ea24-45c0-bf07-254239c12446"><wsu:Created>2013-07-28T04:38:40Z</wsu:Created><wsu:Expires>2013-07-28T04:43:40Z</wsu:Expires></wsu:Timestamp></wsse:Security></soap:Header><soap:Body><getLoginInfoServiceResponse xmlns="http://tempuri.org/"><getLoginInfoServiceResult><Qry><UserID_LK><![CDATA[887]]></UserID_LK><UserName_LK><![CDATA[谯蕾]]></UserName_LK><DeptID_LK><![CDATA[1642]]></DeptID_LK><DeptPID_LK><![CDATA[1642]]></DeptPID_LK><DeptName_LK><![CDATA[信息化管理部]]></DeptName_LK><PosID_LK><![CDATA[562]]></PosID_LK><ClassID_LK><![CDATA[4]]></ClassID_LK><LoginName><![CDATA[qiaolei]]></LoginName><UserPassWord_LK><![CDATA[698d51a19d8a121ce581499d7b701668]]></UserPassWord_LK><UserPassWordDecode_LK><![CDATA[111]]></UserPassWordDecode_LK><EnableIdentity_LK><![CDATA[0]]></EnableIdentity_LK></Qry></getLoginInfoServiceResult></getLoginInfoServiceResponse></soap:Body></soap:Envelope>
 
 *******/

- (NSDictionary *) login:(TBXMLElement *) bodyElement
{
    TBXMLElement *respElement = [TBXML childElementNamed:@"getLoginInfoServiceResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"getLoginInfoServiceResult" parentElement:respElement];
    TBXMLElement *qryElement = [TBXML childElementNamed:@"Qry" parentElement:resultElement];
    
    NSString *userID = [TBXML textForElement:[TBXML childElementNamed:@"UserID_LK" parentElement:qryElement]];
    NSString *userName = [TBXML textForElement:[TBXML childElementNamed:@"UserName_LK" parentElement:qryElement]];
    NSString *deptId = [TBXML textForElement:[TBXML childElementNamed:@"DeptID_LK" parentElement:qryElement]];
    NSString *deptName = [TBXML textForElement:[TBXML childElementNamed:@"DeptName_LK" parentElement:qryElement]];
    NSString *posId = [TBXML textForElement:[TBXML childElementNamed:@"PosID_LK" parentElement:qryElement]];
    NSString *classId = [TBXML textForElement:[TBXML childElementNamed:@"ClassID_LK" parentElement:qryElement]];
    NSString *LoginName = [TBXML textForElement:[TBXML childElementNamed:@"LoginName" parentElement:qryElement]];
    NSString *userPassword = [TBXML textForElement:[TBXML childElementNamed:@"UserPassWord_LK" parentElement:qryElement]];
    NSString *userPasswordDecode = [TBXML textForElement:[TBXML childElementNamed:@"UserPassWordDecode_LK" parentElement:qryElement]];
    NSString *enableIdentity = [TBXML textForElement:[TBXML childElementNamed:@"EnableIdentity_LK" parentElement:qryElement]];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:userID forKey:@"UserID_LK"];  // 用户序号
    [dic setObject:userName forKey:@"UserName_LK"]; // 用户名称
    [dic setObject:deptId forKey:@"DeptID_LK"]; // 部门序号
    [dic setObject:deptName forKey:@"DeptName_LK"]; // 部门名称
    [dic setObject:posId forKey:@"PosID_LK"]; // 职位序号
    [dic setObject:classId forKey:@"ClassID_LK"]; // 级别序号
    [dic setObject:LoginName forKey:@"LoginName"]; // 登录名称
    [dic setObject:userPassword forKey:@"UserPassWord_LK"]; // 用户密码
    [dic setObject:userPasswordDecode forKey:@"UserPassWordDecode_LK"]; // 明文密码
    [dic setObject:enableIdentity forKey:@"EnableIdentity_LK"]; // 身份校验标志
    
    // 保存信息
    [UserDefaults setObject:userID forKey:kUSERID];
    
    return dic;
}

// 获取待办公文列表及请示报告列表
/*****
 
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"WorkFlowService.asmx" forKey:kWebServiceName];
 [dic setObject:@"getMyDealFilesList" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:[UserDefaults stringForKey:kUSERID]  forKey:@"sUserId"];
 [paramDic setObject:@"N" forKey:@"sFileType"]; // 请示报告是00， 待办公文是N
 [paramDic setObject:@"1" forKey:@"sPageNo"];
 [paramDic setObject:@"20" forKey:@"sPageSize"];
 [paramDic setObject:@"1=1" forKey:@"sWhere"];
 
 [dic setObject:paramDic forKey:kParamName];
 
 *****/

/****
 Response XML Sample:
 
 <soap:Body>
 <getMyDealFilesListResponse xmlns="http://tempuri.org/">
 <getMyDealFilesListResult>
 
 <FileList RecordCount="3">
 
 <File>
 
 <XH>1</XH>
 <ReactType></ReactType>
 <UnReadPress>0</UnReadPress>
 <TotalPress>0</TotalPress>
 <WFL_100_COL_10><![CDATA[114425]]></WFL_100_COL_10>
 <AttachFlag>0</AttachFlag>
 <AttachFlagName>无</AttachFlagName>
 <WFL_100_COL_20><![CDATA[8950]]></WFL_100_COL_20>
 <WFL_100_COL_30><![CDATA[4]]></WFL_100_COL_30>
 <WFL_100_COL_40><![CDATA[2012-11-02 11:58    ]]></WFL_100_COL_40>
 <WFL_100_COL_50><![CDATA[887]]></WFL_100_COL_50>
 <WFL_100_COL_55><![CDATA[0]]></WFL_100_COL_55>
 <WFL_100_COL_60><![CDATA[887]]></WFL_100_COL_60>
 <WFL_100_COL_70><![CDATA[                    ]]></WFL_100_COL_70>
 <WFL_100_COL_80><![CDATA[                    ]]></WFL_100_COL_80>
 <WFL_100_COL_90><![CDATA[                    ]]></WFL_100_COL_90>
 <RecStatusName>待接收</RecStatusName>
 <WFL_100_COL_110><![CDATA[00]]></WFL_100_COL_110>
 <RecTransResultName>未办完</RecTransResultName>
 <WFL_100_COL_111><![CDATA[00]]></WFL_100_COL_111>
 <RecSrcTypeName>正常</RecSrcTypeName>
 <WFL_100_COL_120><![CDATA[01]]></WFL_100_COL_120>
 <RecSrcPointName>秘书核稿</RecSrcPointName>
 <WFL_100_COL_130><![CDATA[3]]></WFL_100_COL_130>
 <WFL_100_COL_140><![CDATA[114424]]></WFL_100_COL_140>
 <WFL_100_COL_150><![CDATA[]]></WFL_100_COL_150>
 <FileTitle><![CDATA[test2]]></FileTitle>
 <WFL_50_COL_20><![CDATA[38]]></WFL_50_COL_20>
 <FileDeptName>信息化管理部</FileDeptName>
 <WFL_50_COL_40><![CDATA[1642]]></WFL_50_COL_40>
 <FileType><![CDATA[01]]></FileType>
 <FileStatusName>流转中</FileStatusName>
 <WFL_50_COL_100><![CDATA[1]]></WFL_50_COL_100>
 <TransDeadLine><![CDATA[1]]></TransDeadLine>
 <AllowView><![CDATA[0]]></AllowView>
 <WordFlag>0</WordFlag>
 <WordFlagName>无</WordFlagName>
 <FormName><![CDATA[发文著录单]]></FormName>
 <RecPointName><![CDATA[承办人处理]]></RecPointName>
 
 </File>
 
 </FileList>
 </getMyDealFilesListResult>
 </getMyDealFilesListResponse>
 </soap:Body>
 
 ***/
- (NSDictionary *) getPendingFilesList:(TBXMLElement *) bodyElement
{
    // dic count-总数   content-列表（array）
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    TBXMLElement *respElement = [TBXML childElementNamed:@"getMyDealFilesListResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"getMyDealFilesListResult" parentElement:respElement];
    TBXMLElement *fileListElement = [TBXML childElementNamed:@"FileList" parentElement:resultElement];
    
    [dic setObject:[TBXML valueOfAttributeNamed:@"RecordCount" forElement:fileListElement] forKey:@"count"];
    
    NSMutableArray *array = [NSMutableArray array];
    TBXMLElement *fileElement = [TBXML childElementNamed:@"File" parentElement:fileListElement];
    while (fileElement) {
        if (![TBXML childElementNamed:@"XH" parentElement:fileElement]) {
            [dic setObject:array forKey:@"content"];
            return dic;
        }
        
        FileModel *model = [[FileModel alloc] init];
        [model setXH:[TBXML textForElement:[TBXML childElementNamed:@"XH" parentElement:fileElement]]];
        [model setFileStatusName:[TBXML textForElement:[TBXML childElementNamed:@"FileStatusName" parentElement:fileElement]]];
        [model setFileTitle:[TBXML textForElement:[TBXML childElementNamed:@"FileTitle" parentElement:fileElement]]];
        [model setFormName:[TBXML textForElement:[TBXML childElementNamed:@"FormName" parentElement:fileElement]]];
        [model setRecSrcTypeName:[TBXML textForElement:[TBXML childElementNamed:@"RecSrcPointName" parentElement:fileElement]]];
        [model setWFL_100_COL_40:[TBXML textForElement:[TBXML childElementNamed:@"WFL_100_COL_40" parentElement:fileElement]]];
        [model setWFL_100_COL_110:[TBXML textForElement:[TBXML childElementNamed:@"WFL_100_COL_110" parentElement:fileElement]]];
        [array addObject:model];
        
        fileElement = [TBXML nextSiblingNamed:@"File" searchFromElement:fileElement];
    }
    
    [dic setObject:array forKey:@"content"];
    
    return dic;
}

// 获取信息中心最新信息列表
/********
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"ggxxService.asmx" forKey:kWebServiceName];
 [dic setObject:@"getxxzzListService" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:[UserDefaults stringForKey:kUSERID]  forKey:@"sUserId"];
 [paramDic setObject:@"20" forKey:@"PageSize"];
 
 [dic setObject:paramDic forKey:kParamName];
 
 ********/


/*******
 Response XML Sample:
 
 <sop:Body>
 <getxxzzListServiceResponse xmlns="http://tempuri.org/">
 <getxxzzListServiceResult>
 <InfoList>
 
 <Info><PKID>985</PKID><XXBT>广珠中线二期工程项目被业主评为中山市2010年度优秀施工单位</XXBT><RDBZ>0</RDBZ><TPBZ>0</TPBZ><FBRQ>2011-01-25 15:30    </FBRQ><FBR>2501</FBR><FBRNAME>谯蕾</FBRNAME><SHBZ>2</SHBZ><FBZT>1</FBZT><SSLM>企业新闻</SSLM><FBLX>1</FBLX><LMZT>0</LMZT><FBBM>66</FBBM></Info>
 
 </InfoList>
 
 </getxxzzListServiceResult></getxxzzListServiceResponse></sop:Body>
 
 ******/

- (NSArray *) getLatestInfo:(TBXMLElement *) bodyElement
{
    TBXMLElement *respElement = [TBXML childElementNamed:@"getxxzzListServiceResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"getxxzzListServiceResult" parentElement:respElement];
    TBXMLElement *infoListElement = [TBXML childElementNamed:@"InfoList" parentElement:resultElement];
    TBXMLElement *infoElement = [TBXML childElementNamed:@"Info" parentElement:infoListElement];
    
    NSMutableArray *array = [NSMutableArray array];
    while (infoElement) {
        if (![TBXML childElementNamed:@"PKID" parentElement:infoElement]) {
            return array;
        }
        
        InfomationModel *model = [[InfomationModel alloc] init];
        [model setPKID:[TBXML textForElement:[TBXML childElementNamed:@"PKID" parentElement:infoElement]]];
        [model setXXBT:[TBXML textForElement:[TBXML childElementNamed:@"XXBT" parentElement:infoElement]]];
        [model setRDBZ:[TBXML textForElement:[TBXML childElementNamed:@"RDBZ" parentElement:infoElement]]];
        [model setTPBZ:[TBXML textForElement:[TBXML childElementNamed:@"TPBZ" parentElement:infoElement]]];
        [model setFBRQ:[TBXML textForElement:[TBXML childElementNamed:@"FBRQ" parentElement:infoElement]]];
        [model setFBR:[TBXML textForElement:[TBXML childElementNamed:@"FBR" parentElement:infoElement]]];
        [model setFBRNAME:[TBXML textForElement:[TBXML childElementNamed:@"FBRNAME" parentElement:infoElement]]];
        [model setSHBZ:[TBXML textForElement:[TBXML childElementNamed:@"SHBZ" parentElement:infoElement]]];
        [model setFBZT:[TBXML textForElement:[TBXML childElementNamed:@"FBZT" parentElement:infoElement]]];
        [model setSSLM:[TBXML textForElement:[TBXML childElementNamed:@"SSLM" parentElement:infoElement]]];
        [model setFBLX:[TBXML textForElement:[TBXML childElementNamed:@"FBLX" parentElement:infoElement]]];
        [model setLMZT:[TBXML textForElement:[TBXML childElementNamed:@"LMZT" parentElement:infoElement]]];
        [model setFBBM:[TBXML textForElement:[TBXML childElementNamed:@"FBBM" parentElement:infoElement]]];
        
        [array addObject:model];
        
        infoElement = [TBXML nextSiblingNamed:@"Info" searchFromElement:infoElement];
    }
    
    return array;
}

// 获取信息中心最新通知列表，同时也用于取得数量

/********
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"ggxxService.asmx" forKey:kWebServiceName];
 [dic setObject:@"gettzListService" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:[UserDefaults stringForKey:kUSERID]  forKey:@"sUser"];
 [paramDic setObject:@"20" forKey:@"PageSize"];
 
 [dic setObject:paramDic forKey:kParamName];
 
 ********/

/***
 <soap:Body>
 <gettzListServiceResponse xmlns="http://tempuri.org/">
 <gettzListServiceResult>
 <InfoList>
 
 <Info><PKID><![CDATA[509]]></PKID><Title><![CDATA[aaa]]></Title><TmpType><![CDATA[通用通知模版]]></TmpType><ReleaseDept>公司领导</ReleaseDept><ReceptFlag><![CDATA[0]]></ReceptFlag><IsValid><![CDATA[0]]></IsValid><ReleaseDate><![CDATA[2012-06-15 16:56    ]]></ReleaseDate><ReadNumber><![CDATA[0]]></ReadNumber><ReplyNumber><![CDATA[0]]></ReplyNumber><FirstReadTime><![CDATA[]]></FirstReadTime><LastReadTime><![CDATA[]]></LastReadTime>
 </Info>
 
 </InfoList>
 </gettzListServiceResult>
 </gettzListServiceResponse>
 </soap:Body>
 
 ***/
- (NSArray *) getLastestNofify:(TBXMLElement *) bodyElement
{
    TBXMLElement *respElement = [TBXML childElementNamed:@"gettzListServiceResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"gettzListServiceResult" parentElement:respElement];
    TBXMLElement *infoListElement = [TBXML childElementNamed:@"InfoList" parentElement:resultElement];
    TBXMLElement *infoElement = [TBXML childElementNamed:@"Info" parentElement:infoListElement];
    
    NSMutableArray *array = [NSMutableArray array];
    while (infoElement) {
        if (![TBXML childElementNamed:@"PKID" parentElement:infoElement]) {
            return array;
        }
        
        NotificationModel *model = [[NotificationModel alloc] init];
        [model setPKID:[TBXML textForElement:[TBXML childElementNamed:@"PKID" parentElement:infoElement]]];
        [model setTitle:[TBXML textForElement:[TBXML childElementNamed:@"Title" parentElement:infoElement]]];
        [model setTmpType:[TBXML textForElement:[TBXML childElementNamed:@"TmpType" parentElement:infoElement]]];
        [model setReleaseDept:[TBXML textForElement:[TBXML childElementNamed:@"ReleaseDept" parentElement:infoElement]]];
        [model setReceptFlag:[TBXML textForElement:[TBXML childElementNamed:@"ReceptFlag" parentElement:infoElement]]];
        [model setIsValid:[TBXML textForElement:[TBXML childElementNamed:@"IsValid" parentElement:infoElement]]];
        [model setReleaseDate:[TBXML textForElement:[TBXML childElementNamed:@"ReleaseDate" parentElement:infoElement]]];
        [model setReadNumber:[TBXML textForElement:[TBXML childElementNamed:@"ReadNumber" parentElement:infoElement]]];
        [model setReplyNumber:[TBXML textForElement:[TBXML childElementNamed:@"ReplyNumber" parentElement:infoElement]]];
        [model setFirstReadTime:[TBXML textForElement:[TBXML childElementNamed:@"FirstReadTime" parentElement:infoElement]]];
        [model setLastReadTime:[TBXML textForElement:[TBXML childElementNamed:@"LastReadTime" parentElement:infoElement]]];
        
        [array addObject:model];
        
        infoElement = [TBXML nextSiblingNamed:@"Info" searchFromElement:infoElement];
    }
    
    return array;
}

// 获取信息详情

/***
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"ggxxService.asmx" forKey:kWebServiceName];
 [dic setObject:@"GetInformService" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:@"985" forKey:@"pkid"];
 
 [dic setObject:paramDic forKey:kParamName];
 
 ***/

/****
 Response XML Sample:
 
 <soap:Body>
 <GetInformServiceResponse xmlns="http://tempuri.org/">
 <GetInformServiceResult>
 <InfoList>
 <Info>
 
 <PKID><![CDATA[985]]></PKID>
 <XXBT><![CDATA[广珠中线二期工程项目被业主评为中山市2010年度优秀施工单位]]></XXBT>
 <SSLM><![CDATA[企业新闻]]></SSLM>
 －－<XSGS><![CDATA[1]]></XSGS>
 －－<LINK><![CDATA[http://www2.rbsce.com/news/ReadNews.asp?NewsID=3343]]></LINK>
 －－<XXNR><![CDATA[]]></XXNR>
 <FBRQ><![CDATA[2011-01-25 15:30    ]]></FBRQ>
 <FBR><![CDATA[2501]]></FBR>
 <SHBZ><![CDATA[2]]></SHBZ>
 <FBZT><![CDATA[1]]></FBZT>
 －－<XXLX><![CDATA[0]]></XXLX>
 <FBRNAME>王丹丹</FBRNAME>
 
 </Info>
 </InfoList>
 </GetInformServiceResult>
 </GetInformServiceResponse>
 </soap:Body>
 
 ***/
- (InfomationModel *) getInfomationDetail:(TBXMLElement *) bodyElement
{
    TBXMLElement *respElement = [TBXML childElementNamed:@"GetInformServiceResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"GetInformServiceResult" parentElement:respElement];
    TBXMLElement *infoListElement = [TBXML childElementNamed:@"InfoList" parentElement:resultElement];
    TBXMLElement *infoElement = [TBXML childElementNamed:@"Info" parentElement:infoListElement];
    TBXMLElement *PKIDElement = [TBXML childElementNamed:@"PKID" parentElement:infoElement];
    
    if (PKIDElement) {
        InfomationModel *model = [[InfomationModel alloc] init];
        [model setPKID:[TBXML textForElement:[TBXML childElementNamed:@"PKID" parentElement:infoElement]]];
        [model setXXBT:[TBXML textForElement:[TBXML childElementNamed:@"XXBT" parentElement:infoElement]]];
        [model setSSLM:[TBXML textForElement:[TBXML childElementNamed:@"SSLM" parentElement:infoElement]]];
        [model setXSGS:[TBXML textForElement:[TBXML childElementNamed:@"XSGS" parentElement:infoElement]]];
        [model setLINK:[TBXML textForElement:[TBXML childElementNamed:@"LINK" parentElement:infoElement]]];
        [model setXXNR:[TBXML textForElement:[TBXML childElementNamed:@"XXNR" parentElement:infoElement]]];
        [model setFBRQ:[TBXML textForElement:[TBXML childElementNamed:@"FBRQ" parentElement:infoElement]]];
        [model setFBR:[TBXML textForElement:[TBXML childElementNamed:@"FBR" parentElement:infoElement]]];
        [model setXXLX:[TBXML textForElement:[TBXML childElementNamed:@"XXLX" parentElement:infoElement]]];
        [model setFBRNAME:[TBXML textForElement:[TBXML childElementNamed:@"FBRNAME" parentElement:infoElement]]];
        
        return model;
    }
    
    return nil;
}

// 获取通知详情
/***
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"ggxxService.asmx" forKey:kWebServiceName];
 [dic setObject:@"GetNotifyInformService" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:@"509" forKey:@"pkid"];
 
 [dic setObject:paramDic forKey:kParamName];
 ***/

/****
 Response XML Sample:
 
 <soap:Body>
 <GetNotifyInformServiceResponse xmlns="http://tempuri.org/">
 <GetNotifyInformServiceResult>
 <InfoList>
 <Info>
 
 <PKID><![CDATA[509]]></PKID>
 <Title><![CDATA[aaa]]></Title>
 ---<Context><![CDATA[<A href="http://www.baidu.com/s&amp;#161;wd=%B2%E2%CD%F8%CB%D9&amp;amp;opt-webpage=on&amp;amp;ie=gbk">http://www.baidu.com/s&amp;#161;wd=%B2%E2%CD%F8%CB%D9&amp;amp;opt-webpage=on&amp;amp;ie=gbk</A>]]></Context>
 ---<Type><![CDATA[3]]></Type>
 ---<ReleaseDeptId>65</ReleaseDeptId>
 <ReleaseDept>公司领导</ReleaseDept>
 <ReceptFlag><![CDATA[0]]></ReceptFlag>
 <IsValid><![CDATA[0]]></IsValid>
 ---<TZFW>全部人员</TZFW>
 --<PUB_80_COL_90><![CDATA[9]]></PUB_80_COL_90>
 --<PUB_80_COL_100><![CDATA[-1]]></PUB_80_COL_100>
 --<PUB_80_COL_9994><![CDATA[2012-06-15 16:56    ]]></PUB_80_COL_9994>
 --<firstdate></firstdate>
 ---<lastdate></lastdate>
 <ReplyNumber><![CDATA[0]]></ReplyNumber>
 
 </Info>
 </InfoList>
 </GetNotifyInformServiceResult>
 </GetNotifyInformServiceResponse>
 </soap:Body>
 
 ****/

- (NotificationModel *) getNotificationDetail:(TBXMLElement *) bodyElement
{
    TBXMLElement *respElement = [TBXML childElementNamed:@"GetNotifyInformServiceResponse" parentElement:bodyElement];
    TBXMLElement *resultElement = [TBXML childElementNamed:@"GetNotifyInformServiceResult" parentElement:respElement];
    TBXMLElement *infoListElement = [TBXML childElementNamed:@"InfoList" parentElement:resultElement];
    TBXMLElement *infoElement = [TBXML childElementNamed:@"Info" parentElement:infoListElement];
    TBXMLElement *PKIDElement = [TBXML childElementNamed:@"PKID" parentElement:infoElement];
    
    if (PKIDElement) {
        NotificationModel *model = [[NotificationModel alloc] init];
        [model setPKID:[TBXML textForElement:[TBXML childElementNamed:@"PKID" parentElement:infoElement]]];
        [model setTitle:[TBXML textForElement:[TBXML childElementNamed:@"Title" parentElement:infoElement]]];
        [model setContext:[TBXML textForElement:[TBXML childElementNamed:@"Context" parentElement:infoElement]]];
        [model setType:[TBXML textForElement:[TBXML childElementNamed:@"Type" parentElement:infoElement]]];
        [model setReleaseDeptId:[TBXML textForElement:[TBXML childElementNamed:@"ReleaseDeptId" parentElement:infoElement]]];
        [model setReleaseDept:[TBXML textForElement:[TBXML childElementNamed:@"ReleaseDept" parentElement:infoElement]]];
        [model setReceptFlag:[TBXML textForElement:[TBXML childElementNamed:@"ReceptFlag" parentElement:infoElement]]];
        [model setIsValid:[TBXML textForElement:[TBXML childElementNamed:@"IsValid" parentElement:infoElement]]];
        [model setTZFW:[TBXML textForElement:[TBXML childElementNamed:@"TZFW" parentElement:infoElement]]];
        [model setPUB_80_COL_90:[TBXML textForElement:[TBXML childElementNamed:@"PUB_80_COL_90" parentElement:infoElement]]];
        [model setPUB_80_COL_100:[TBXML textForElement:[TBXML childElementNamed:@"PUB_80_COL_100" parentElement:infoElement]]];
        [model setPUB_80_COL_9994:[TBXML textForElement:[TBXML childElementNamed:@"PUB_80_COL_9994" parentElement:infoElement]]];
        [model setFirstdate:[TBXML textForElement:[TBXML childElementNamed:@"firstdate" parentElement:infoElement]]];
        [model setLastdate:[TBXML textForElement:[TBXML childElementNamed:@"lastdate" parentElement:infoElement]]];

        return model;
    }
    
    return nil;
}

// 取附件内容
/***
 
 sType 0010 信息中心
 sType 0080 通知
 sType 0110 请示报告 公文
 
 Request XML Sample:
 
 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
 [dic setObject:@"ShareService.asmx" forKey:kWebServiceName];
 [dic setObject:@"getFormAttInfo" forKey:kMethodName];
 
 NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
 [paramDic setObject:@"985" forKey:@"sFileId"];
 [paramDic setObject:@"0010" forKey:@"sTypt"];
 
 [dic setObject:paramDic forKey:kParamName];

 ****/
- (NSDictionary *) getAttachmentInfo:(TBXMLElement *) bodyElement
{
    return nil;
}




@end
