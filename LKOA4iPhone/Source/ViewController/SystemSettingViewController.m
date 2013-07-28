//
//  SystemSettingViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "SystemSettingViewController.h"

#define X 34
#define Y 35
#define W 34
#define H 40
@interface SystemSettingViewController ()

@end

@implementation SystemSettingViewController

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
    self.navigationItem.title = @"系统设置";
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"catalog_bg"]];
    
    NSArray *array = [NSArray arrayWithObjects:@"帮助", @"新手引导", @"意见反馈", @"检查更新", @"访问官网", @"关于我们", @"注销登录", nil];
    for (int j = 0; j<3; j++) {
        for (int i = 0; i<3; i++) {
            NSString *nomal = [NSString stringWithFormat:@"sys_set_n_%d", (i+1)+3*j];
            NSString *select = [NSString stringWithFormat:@"sys_set_s_%d", (i+1)+3*j];
            
            if((i+1)+3*j< 8){
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                [button setImage:[UIImage imageNamed:nomal] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:select] forState:UIControlStateSelected];
                [button setImage:[UIImage imageNamed:select] forState:UIControlStateHighlighted];
                [button setTag:1000+(i+1)+3*j];
                [button addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
                [button setFrame:CGRectMake(X+i*(61+W), Y+j*(61+H), 61, 61)];
                NSLog(@"i:%d, j:%d, x: %d, y: %d, n: %d", i, j, X+i*(61+W), Y+j*(61+H), (i+1)+3*j);
                [self.view addSubview:button];
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X+i*(61+W), Y+61+j*(61+H), 61, 25)];
                [label setText:(NSString*)[array objectAtIndex:i+3*j]];
                [label setBackgroundColor:[UIColor clearColor]];
                [label setFont:[UIFont boldSystemFontOfSize:15]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [self.view addSubview:label];
            }
            
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

-(IBAction)settingButtonAction:(id)sender
{
    NSLog(@"tag: %d", ((UIButton*)sender).tag);
}
@end
