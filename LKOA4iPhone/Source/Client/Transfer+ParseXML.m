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

+ (NSDictionary *) login:(TBXMLElement *) bodyElement;

@end

@implementation Transfer (ParseXML)

+ (NSDictionary *) ParseXMLWithReqName:(NSString *) reqName
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
            }
        }
        
    }
    
    return dictionary;
}

// 登陆
+ (NSDictionary *) login:(TBXMLElement *) bodyElement
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
    
    [dic setObject:userID forKey:@"UserID_LK"];
    [dic setObject:userName forKey:@"UserName_LK"];
    [dic setObject:deptId forKey:@"DeptID_LK"];
    [dic setObject:deptName forKey:@"DeptName_LK"];
    [dic setObject:posId forKey:@"PosID_LK"];
    [dic setObject:classId forKey:@"ClassID_LK"];
    [dic setObject:LoginName forKey:@"LoginName"];
    [dic setObject:userPassword forKey:@"UserPassWord_LK"];
    [dic setObject:userPasswordDecode forKey:@"UserPassWordDecode_LK"];
    [dic setObject:enableIdentity forKey:@"EnableIdentity_LK"];
    
    return dic;
}

@end
