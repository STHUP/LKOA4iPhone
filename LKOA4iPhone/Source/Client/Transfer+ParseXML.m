//
//  Transfer+ParseXML.m
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "Transfer+ParseXML.h"
#import "TBXML.h"

@interface Transfer (private)

// 登录
- (NSDictionary *) login:(TBXMLElement *) bodyElement;

// 获取信息中心最新信息列表
- (NSDictionary *) getLatestInfo:(TBXMLElement *) bodyElement;

// 获取通知信息最新列表


@end

@implementation Transfer (ParseXML)

- (NSDictionary *) ParseXMLWithReqName:(NSString *) reqName
                           xmlString:(NSString *) xml
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
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
                dictionary = [NSDictionary dictionaryWithDictionary:[self login:bodyElement]];
            } else if ([reqName isEqualToString:@"getxxzzListService"]) {
                dictionary = [NSDictionary dictionaryWithDictionary:[self getLatestInfo:bodyElement]];
            }
        }
        
    }
    
    return dictionary;
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
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
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

// 获取信息中心最新信息列表
/********
 
 
 ********/


/*******
 Response XML Sample:
 
 <sop:Body>
 <getxxzzListServiceResponse xmlns="http://tempuri.org/">
 <getxxzzListServiceResult>
 <InfoList>
 
 <Info><PKID>985</PKID><XXBT>广珠中线二期工程项目被业主评为中山市2010年度优秀施工单位</XXBT><RDBZ>0</RDBZ><TPBZ>0</TPBZ><FBRQ>2011-01-25 15:30    </FBRQ><FBR>2501</FBR><FBRNAME>谯蕾</FBRNAME><SHBZ>2</SHBZ><FBZT>1</FBZT><SSLM>企业新闻</SSLM><FBLX>1</FBLX><LMZT>0</LMZT><FBBM>66</FBBM></Info>
 
 <Info><PKID>986</PKID><XXBT>宜巴高速项目在业主2010年第四阶段劳动竞赛中受到好评</XXBT><RDBZ>0</RDBZ><TPBZ>0</TPBZ><FBRQ>2011-01-25 15:30    </FBRQ><FBR>2501</FBR><FBRNAME>谯蕾</FBRNAME><SHBZ>2</SHBZ><FBZT>1</FBZT><SSLM>企业新闻</SSLM><FBLX>1</FBLX><LMZT>0</LMZT><FBBM>66</FBBM></Info>
 
 <Info><PKID>981</PKID><XXBT>关于推荐石岐区2009-2010年度“创先争优”评选先进材料的通知</XXBT><RDBZ>0</RDBZ><TPBZ>0</TPBZ><FBRQ>2011-01-25 11:15    </FBRQ><FBR>3584</FBR><FBRNAME>谯蕾</FBRNAME><SHBZ>2</SHBZ><FBZT>1</FBZT><SSLM>华南公司通知</SSLM><FBLX>1</FBLX><LMZT>0</LMZT><FBBM>66</FBBM></Info>
 
 </InfoList>
 
 </getxxzzListServiceResult></getxxzzListServiceResponse></sop:Body>
 
 ******/

- (NSDictionary *) getLatestInfo:(TBXMLElement *) bodyElement
{
    return nil;
}




@end
