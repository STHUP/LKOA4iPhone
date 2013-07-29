//
//  NotificationModel.m
//  LKOA4iPhone
//
//  Created by  STH on 7/28/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

@synthesize PKID = _PKID;
@synthesize Title = _Title;
@synthesize TmpType = _TmpType;
@synthesize ReleaseDept = _ReleaseDept;
@synthesize ReceptFlag = _ReceptFlag;
@synthesize IsValid = _IsValid;
@synthesize ReleaseDate = _ReleaseDate;
@synthesize ReadNumber = _ReadNumber;
@synthesize ReplyNumber = _ReplyNumber;
@synthesize FirstReadTime = _FirstReadTime;
@synthesize LastReadTime = _LastReadTime;

@synthesize Context = _Context;
@synthesize Type = _Type;
@synthesize ReleaseDeptId = _ReleaseDeptId;
@synthesize TZFW = _TZFW;
@synthesize PUB_80_COL_90 = _PUB_80_COL_90;
@synthesize PUB_80_COL_100 = _PUB_80_COL_100;
@synthesize PUB_80_COL_9994 = _PUB_80_COL_9994;
@synthesize firstdate = _firstdate;
@synthesize lastdate = _lastdate;

- (NSString *)description
{
    return self.Title;
}

@end
