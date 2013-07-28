//
//  CatalogViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-27.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "CatalogViewController.h"
#import "JSBadgeView.h"
#import "SystemSettingViewController.h"
#import "ScrollViewController.h"

#define X 34
#define Y 120
#define W 34
#define H 40
@interface CatalogViewController ()

@end

@implementation CatalogViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"主界面";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"catalog_bg"]];
    UIImageView *logoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [logoIV setFrame:CGRectMake(44, 30, 233, 65)];
    [logoIV setUserInteractionEnabled:YES];
    [self.view addSubview:logoIV];
    
    NSArray *array = [NSArray arrayWithObjects:@"待办公文", @"请示报告", @"项目管理", @"资金系统", @"信息中心", @"系统设置", nil];
    for (int j = 0; j<2; j++) {
        for (int i = 0; i<3; i++) {
            NSString *nomal = [NSString stringWithFormat:@"catalog_n_%d", (i+1)+3*j];
            NSString *select = [NSString stringWithFormat:@"catalog_s_%d", (i+1)+3*j];            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if((i+1)+3*j != 6){
                JSBadgeView *nBadgeView = [[JSBadgeView alloc] initWithParentView:button alignment:JSBadgeViewAlignmentTopRight topRightX:-15 topRightY:23];
                nBadgeView.badgeText = [NSString stringWithFormat:@"%d", (i+1)+3*j];
            }
            
            [button setImage:[UIImage imageNamed:nomal] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:select] forState:UIControlStateHighlighted];
            [button setTag:1000+(i+1)+3*j];
            [button addTarget:self action:@selector(catalogButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setFrame:CGRectMake(X+i*(61+W), Y+j*(61+H), 61, 61)];
            NSLog(@"i:%d, j:%d, x: %d, y: %d, n: %d", i, j, X+i*(61+W), Y+j*(61+H), (i+1)+3*j);
            [self.view addSubview:button];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X+i*(61+W), Y+61+j*(61+H), 80, 25)];
            [label setText:(NSString*)[array objectAtIndex:i+3*j]];
            [label setBackgroundColor:[UIColor clearColor]];
            [label setFont:[UIFont boldSystemFontOfSize:15]];
            [self.view addSubview:label];
        }
    }
    

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)catalogButtonAction:(id)sender
{
    NSLog(@"tag: %d", ((UIButton*)sender).tag);
    switch (((UIButton*)sender).tag) {
        case 1006:
        {
            SystemSettingViewController *vc = [[SystemSettingViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1005:
        {
            ScrollViewController *vc = [[ScrollViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}
@end