//
//  Transfer.h
//  LKOA4iPhone
//
//  Created by  STH on 7/27/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Transfer : NSObject

+ (void) Transfer:(NSDictionary *) reqDic
          success:(void (*) (NSDictionary * respDic)) success
          failure:(NSError *) failure;

@end
