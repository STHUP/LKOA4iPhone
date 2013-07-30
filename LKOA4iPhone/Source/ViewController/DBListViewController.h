//
//  DBListViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-29.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DBListViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UIView *refreshFooterView;
    UILabel *refreshLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
}

@property(nonatomic, strong)NSMutableArray *myArray;
@property(nonatomic, strong)UITableView *leftTableView;
@property(nonatomic, strong)UITableView  *rightTableView;

@property (nonatomic, strong) UIView *refreshFooterView;
@property (nonatomic, strong) UILabel *refreshLabel;
@property (nonatomic, strong) UIImageView *refreshArrow;
@property (nonatomic, strong) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, strong) NSString *textPull;
@property (nonatomic, strong) NSString *textRelease;
@property (nonatomic, strong) NSString *textLoading;
@property (nonatomic, strong) NSString *textNoMore;
@property (nonatomic) BOOL hasMore;

- (void)setupStrings;
- (void)addPullToRefreshFooter;
- (void)startLoading;
- (void)stopLoading;
- (void)refresh;

@end
