//
//  Transfer+ParseXML.m
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "Transfer+ParseXML.h"

@implementation Transfer (ParseXML)

+ (NSDictionary *) ParseXMLWithReqName:(NSString *) reqName
                           xmlString:(NSString *) xml
{
    NSLog(@"---%@", xml);
    
    return [NSDictionary dictionaryWithObjectsAndKeys:@"object", @"key", nil];
}

@end
