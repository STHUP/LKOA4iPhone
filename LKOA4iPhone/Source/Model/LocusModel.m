//
//  LocusModel.m
//  LKOA4iPhone
//
//  Created by  STH on 7/29/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "LocusModel.h"

@implementation LocusModel

@synthesize RecId = _RecId;
@synthesize FromId = _FromId;
@synthesize FldId = _FldId;
@synthesize Content = _Content;
@synthesize CreateTime = _CreateTime;
@synthesize UserName = _UserName;
@synthesize DpetName = _DpetName;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@-%@", self.UserName, self.Content];
}

@end
