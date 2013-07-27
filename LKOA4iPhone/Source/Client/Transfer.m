//
//  Transfer.m
//  LKOA4iPhone
//
//  Created by  STH on 7/27/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "Transfer.h"

@interface Transfer()

@property (strong) NSMutableDictionary *respDic;

@end

@implementation Transfer

static Transfer  *instance;

+ (Transfer *) sharedInstance
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
          failure:(NSError *) failure
{
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
                         "</soap:Envelope>",[reqDic objectForKey:kMethodName], ^(void){
                             
                             NSMutableString *mutString = [NSMutableString string];
                             NSDictionary *tempDic = [reqDic objectForKey:kParamName];
                             for (NSString *key in [tempDic allKeys]) {
                                 [mutString appendFormat:@"<%@><![CDATA[%@]]></%@>", key, [tempDic objectForKey:key], key];
                             }
                         return mutString;
                         }, [reqDic objectForKey:kMethodName]];
    
    [client setDefaultHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [client setDefaultHeader:@"SOAPAction" value:[NSString stringWithFormat:@"http://tempuri.org/%@", [reqDic objectForKey:kMethodName]]];
    [client setDefaultHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",[httpBodyString length]]];
    
    NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:[reqDic objectForKey:kWebServiceName] parameters:nil];
    request.HTTPBody = [httpBodyString dataUsingEncoding:NSUTF8StringEncoding];
    
    AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                            self.successBlock = success;
                                                            self.respDic = [NSMutableDictionary dictionary];
                                                            
                                                            XMLParser.delegate = self;
                                                            [XMLParser setShouldProcessNamespaces:YES];
                                                            [XMLParser parse];
                                                            
                                                        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                            NSLog(@"%@", [NSString stringWithFormat:@"%@",error]);
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                            [av show];
                                                        }];
    
    
    [operation start];
}

#pragma mark - AFXMLRequestOperationDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict  {
    NSLog(@"---%@:", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"---%@:", string);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
     NSLog(@"---%@:", elementName);
}



-(void) parserDidEndDocument:(NSXMLParser *)parser {
    self.successBlock(self.respDic);
}


@end
