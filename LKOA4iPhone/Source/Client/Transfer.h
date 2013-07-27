//
//  Transfer.h
//  LKOA4iPhone
//
//  Created by  STH on 7/27/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Transfer : NSObject <NSXMLParserDelegate>

typedef void (^SuccessBlock) (NSDictionary *dic);

@property (nonatomic, strong) SuccessBlock successBlock;

+ (Transfer *) sharedInstance;
- (void) Transfer:(NSDictionary *) reqDic
          success:(SuccessBlock) success
          failure:(NSError *) failure;

@end
