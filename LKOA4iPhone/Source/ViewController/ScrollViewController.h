//
//  ScrollViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBGWViewController.h"
#import "QSBGViewController.h"
#import "ZJXTViewController.h"
#import "XXZXViewController.h"
#import "XMGLViewController.h"
#import "XTSZViewController.h"
#import "DBListViewController.h"
#import "QSListViewController.h"
#import "QSBGViewController.h"
#import "ListViewController.h"

@interface ScrollViewController : UIViewController <UIScrollViewDelegate> {
    
    CGRect rect;
}

@property(nonatomic,strong) UIScrollView *tabBarScroller;
@property(nonatomic,strong) UIStoryboard *storyBoard;

@property(nonatomic,strong) DBListViewController *dbTab;
@property(nonatomic,strong) QSListViewController *qsTab;
@property(nonatomic,strong) ListViewController *xmTab;
@property(nonatomic,strong) ListViewController *zjTab;
@property(nonatomic,strong) XXZXViewController *xxTab;
@property(nonatomic,strong) XTSZViewController *xtTab;

@property(nonatomic,strong) UINavigationController *navFirstTab;
@property(nonatomic,strong) UINavigationController *navSecondTab;
@property(nonatomic,strong) UINavigationController *navThirdTab;
@property(nonatomic,strong) UINavigationController *navFourthTab;
@property(nonatomic,strong) UINavigationController *navFifthTab;
@property(nonatomic,strong) UINavigationController *navSixthTab;

@property(nonatomic, assign)int tagVC;

@end
