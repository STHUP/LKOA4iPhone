//
//  XTSZViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface XTSZViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *textArray;

@end
