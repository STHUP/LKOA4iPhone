//
//  Transfer.m
//  LKOA4iPhone
//
//  Created by  STH on 7/27/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "Transfer.h"
#import "Transfer+ParseXML.h"
#import "XMLWriter.h"

@implementation Transfer

static Transfer *instance = nil;

+ (Transfer *) sharedTransfer
{
    @synchronized(self)
    {
        if (nil == instance) {
            instance = [[Transfer alloc] init];
        }
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

- (void) Transfer:(NSDictionary *) reqDic
          success:(SuccessBlock) success
          failure:(FailureBlock) failure
{
    
    NSString* (^dic2XML) (void) = ^(void){
        NSMutableString *mutString = [NSMutableString string];
        NSDictionary *tempDic = [reqDic objectForKey:kParamName];
        for (NSString *key in [tempDic allKeys]) {
            id obj = [tempDic objectForKey:key];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [mutString appendFormat:@"<%@><![CDATA[%@]]></%@>", key, [XMLWriter XMLStringFromDictionary:obj], key];
            } else if ([obj isKindOfClass:[NSString class]]) {
                [mutString appendFormat:@"<%@><![CDATA[%@]]></%@>", key, obj, key];
            }
            
        }
        return mutString;
    };

    
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://%@/lkoa5/WapService/", [UserDefaults stringForKey:kHOSTNAME]]];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
        
    NSString *httpBodyString = [NSString stringWithFormat:
                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                         "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                         "<soap:Body>\n"
                         "<%@ xmlns=\"http://tempuri.org/\">"
                         "%@"
                         "</%@>"
                         "</soap:Body>\n"
                         "</soap:Envelope>",[reqDic objectForKey:kMethodName], dic2XML(), [reqDic objectForKey:kMethodName]];
    
    [client setDefaultHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [client setDefaultHeader:@"SOAPAction" value:[NSString stringWithFormat:@"http://tempuri.org/%@", [reqDic objectForKey:kMethodName]]];
    [client setDefaultHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",[httpBodyString length]]];
    
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:[reqDic objectForKey:kWebServiceName] parameters:nil];
    request.HTTPBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *respXML = [[[operation responseString] stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"] stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        NSLog(@"Response: %@", respXML);
        
        NSDictionary *dic = [self ParseXMLWithReqName:[reqDic objectForKey:kMethodName] xmlString:respXML];
        success(dic);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    [operation start];
    
}

@end
