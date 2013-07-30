//
//  ScrollViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "ScrollViewController.h"
#import "JSBadgeView.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

@synthesize tabBarScroller = _tabBarScroller;
@synthesize dbTab = _dbTab;
@synthesize qsTab = _qsTab;
@synthesize zjTab = _zjTab;
@synthesize xxTab = _xxTab;
@synthesize xmTab = _xmTab;
@synthesize xtTab = _xtTab;
@synthesize tagVC = _tagVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
	// Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(void)setup {
    _tabBarScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 397, 320, 63)];
    [_tabBarScroller setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"scroll_icon_bg"]]];
    
    [_tabBarScroller setContentSize:CGSizeMake(380, 60)];
    [_tabBarScroller setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_tabBarScroller];
    [self addButtons];
    
    if(IS_IPHONE_5) {
        rect = CGRectMake(0, 0, 320, 499);
    }
    else {
        rect = CGRectMake(0, 0, 320, 397);
    }
    
    // Select which view to be loaded (actually viewed) as base controller or root controller. 0 - BaseController, 1 -
    // FirstTabController, 2 - SecondTabcontroller
    // By default first tab controller is set a rootcontroller
    
    [self tabCall:_tagVC];
    
}

-(void)addButtons {
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"公文管理", @"请示报告", @"项目管理", @"资金管理", @"信息中心", @"系统设置", nil];
    for(int i =1;i<7;i++) {
        NSString *nomal = [NSString stringWithFormat:@"scroll_icon_n_%d", i];
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(12+(i-1)*64, 7, 40, 40);
        [btn setImage:[UIImage imageNamed:nomal] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:11];
        btn.tag = i;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(7+64*(i-1), 45, 50, 20)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:((NSString*)[array objectAtIndex:i-1])];
        [label setFont:[UIFont systemFontOfSize:11]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [_tabBarScroller addSubview:label];
        
        switch (btn.tag) {
            case 1:{
                JSBadgeView *nBadgeView = [[JSBadgeView alloc] initWithParentView:btn alignment:JSBadgeViewAlignmentTopRight topRightX:0 topRightY:5];
                nBadgeView.badgeText = [NSString stringWithFormat:@"%d", i];
                break;
            }
            case 2:
                
                break;
            case 3:
                
                break;
            case 4:
               
                break;
            case 5:
                
                break;
            case 6:
                
                break;
                
            default:
                break;
        }
        
        [btn addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [_tabBarScroller addSubview:btn];
    }
}



-(void)tabCall:(NSInteger)tag {
    switch (tag) {
            
        case 1:
            self.navigationItem.title = @"eee";
//            [self.navigationController pushViewController:self.navFirstTab.navigationController animated:YES];
            [self.view addSubview:self.navFirstTab.view];
            break;
            
        case 2:
            [self.view addSubview:self.navSecondTab.view];
            break;
            
        case 3:
            [self.view addSubview:self.navThirdTab.view];
            break;
            
        case 4:
            [self.view addSubview:self.navFourthTab.view];
            break;
            
        case 5:
            [self.view addSubview:self.navFifthTab.view];
            break;
            
        case 6:
            [self.view addSubview:self.navSixthTab.view];
            break;
            
            
        default:
            break;
    }
}


-(void)buttonTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSLog(@"Tab bar %d is clicked",btn.tag);
    [self tabCall:btn.tag];
    
}



- (UINavigationController*) navFirstTab
{
    if (!_navFirstTab) {
        if (!_dbTab) {
            _dbTab= [[DBListViewController alloc] init];
            _dbTab.scrollVC = self;
        }
        _navFirstTab = [[UINavigationController alloc] initWithRootViewController:self.dbTab];
        _navFirstTab.navigationBar.tintColor = [UIColor blackColor];
        _navFirstTab.view.frame = rect;
        _navFirstTab.navigationBar.topItem.title = @"待办公文";
    }
    return _navFirstTab;
}


- (UINavigationController*) navSecondTab
{
    if (!_navSecondTab) {
        if (!_qsTab) {
            _qsTab = [[QSListViewController alloc] init];
            _qsTab.scrollVC = self;
        }
        _navSecondTab = [[UINavigationController alloc] initWithRootViewController:self.qsTab];
        _navSecondTab.navigationBar.tintColor = [UIColor blackColor];
        _navSecondTab.view.frame = rect;
        _navSecondTab.navigationBar.topItem.title = @"请示报告";
    }
    return _navSecondTab;
}

- (UINavigationController*) navThirdTab
{
    if (!_navThirdTab) {
        if (!_xmTab) {
            _xmTab = [[ListViewController alloc] init];
            _xmTab.scrollVC = self;
            _xmTab.catalogTag = 3;
        }
        _navThirdTab = [[UINavigationController alloc] initWithRootViewController:self.xmTab];
        _navThirdTab.navigationBar.tintColor = [UIColor blackColor];
        _navThirdTab.navigationBar.topItem.title = @"Third Controller";
        _navThirdTab.view.frame = rect;
    }
    return _navThirdTab;
}

- (UINavigationController*) navFourthTab
{
    if (!_navFourthTab) {
        if (!_zjTab) {
            _zjTab = [[ListViewController alloc] init];
            _zjTab.scrollVC = self;
            _zjTab.catalogTag = 4;
        }
        _navFourthTab = [[UINavigationController alloc] initWithRootViewController:self.zjTab];
        _navFourthTab.navigationBar.tintColor = [UIColor blackColor];
        _navFourthTab.view.frame = rect;
        _navFourthTab.navigationBar.topItem.title = @"Fourth Controller";
    }
    return _navFourthTab;
}

- (UINavigationController*) navFifthTab
{
    if (!_navFifthTab) {
        if (!_xxTab) {
            _xxTab = [[XXZXViewController alloc] init];
            _xxTab.scrollVC = self;
        }
        _navFifthTab = [[UINavigationController alloc] initWithRootViewController:self.xxTab];
        _navFifthTab.navigationBar.tintColor = [UIColor blackColor];
        _navFifthTab.view.frame = rect;
        _navFifthTab.navigationBar.topItem.title = @"信息中心";
    }
    return _navFifthTab;
}

- (UINavigationController*) navSixthTab
{
    if (!_navSixthTab) {
        if (!_xtTab) {
            _xtTab = [[XTSZViewController alloc] init];
            _xtTab.scrollVC = self;
        }
        _navFifthTab = [[UINavigationController alloc] initWithRootViewController:self.xtTab];
        _navFifthTab.navigationBar.tintColor = [UIColor blackColor];
        _navFifthTab.view.frame = rect;
        _navFifthTab.navigationBar.topItem.title = @"Fifth Controller";
    }
    return _navFifthTab;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end