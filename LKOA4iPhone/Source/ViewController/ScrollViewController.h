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
#import "SystemSettingViewController.h"
#import "XMGLViewController.h"

@interface ScrollViewController : UIViewController <UIScrollViewDelegate> {
    
    CGRect rect;
}

@property(nonatomic,strong) UIScrollView *tabBarScroller;
@property(nonatomic,strong) UIStoryboard *storyBoard;

@property(nonatomic,strong) DBGWViewController *dbTab;
@property(nonatomic,strong) QSBGViewController *qsTab;
@property(nonatomic,strong) ZJXTViewController *zjTab;
@property(nonatomic,strong) XXZXViewController *xxTab;
@property(nonatomic,strong) SystemSettingViewController *sysTab;
@property(nonatomic,strong) XMGLViewController *xmTab;

@property(nonatomic,strong) UINavigationController *navFirstTab;
@property(nonatomic,strong) UINavigationController *navSecondTab;
@property(nonatomic,strong) UINavigationController *navThirdTab;
@property(nonatomic,strong) UINavigationController *navFourthTab;
@property(nonatomic,strong) UINavigationController *navFifthTab;
@property(nonatomic,strong) UINavigationController *navSixthTab;

@end
