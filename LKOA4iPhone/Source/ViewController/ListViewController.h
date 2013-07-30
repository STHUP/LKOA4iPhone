//
//  ListViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-29.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray *myArray;
@property(nonatomic, strong)UITableView *myTableView;
@property(assign)int catalogTag;

@end
