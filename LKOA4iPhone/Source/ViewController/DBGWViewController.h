//
//  DBGWViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DBGWViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIButton *leftButton;
@property(nonatomic, strong)UIButton *rightButton;
@property(assign)BOOL isLeft;
@property(nonatomic, strong)NSArray *myArray;
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIImageView *formIV;

@property(nonatomic, strong)UILabel *fileTitleLabel;
@property(nonatomic, strong)UILabel *fileContentLabel;
@property(nonatomic, strong)UILabel *fujianLabel;

-(void)navButtonAdd;

@end
