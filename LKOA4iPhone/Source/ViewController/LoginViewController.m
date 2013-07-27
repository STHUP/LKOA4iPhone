//
//  LoginViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-26.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "LoginViewController.h"
#define TF_X1 20
#define TF_X2 90
#define TF_Y 30
#define TF_Y2 178
#define TF_W1 70
#define TF_W2 197
#define TF_H1 25
#define TF_H2 31
#define INTERVAL_H_1 50
#define INTERVAL_H_2 3
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userTF = _userTF;
@synthesize pwdTF = _pwdTF;
@synthesize selectButton = _selectButton;
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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    UIImageView *middleIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"middle_bg"]];
    [middleIV setFrame:CGRectMake(7, 150, 306, 234)];
    [middleIV setUserInteractionEnabled:YES];
    [self.view addSubview:middleIV];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X1, TF_Y, TF_W1, TF_H1)];
    [userLabel setBackgroundColor:[UIColor clearColor]];
    [userLabel setText:@"用户名："];
    [middleIV addSubview:userLabel];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X1, TF_Y+INTERVAL_H_1, TF_W1, TF_H1)];
    [pwdLabel setBackgroundColor:[UIColor clearColor]];
    [pwdLabel setText:@"密    码："];
    [middleIV addSubview:pwdLabel];
    
    _userTF  = [[UITextField alloc] initWithFrame:CGRectMake(TF_X2, TF_Y2, TF_W2, TF_H2)];
    [_userTF setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_bg"]]];
    _userTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userTF.delegate = self;
    [_userTF setPlaceholder:@"请输入用户名"];
    [self.view addSubview:_userTF];
    
    _pwdTF  = [[UITextField alloc] initWithFrame:CGRectMake(TF_X2, TF_Y2+INTERVAL_H_1, TF_W2, TF_H2)];
    [_pwdTF setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_bg"]]];
    _pwdTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTF.delegate = self;
    [_pwdTF setPlaceholder:@"请输入密码"];
    _pwdTF.secureTextEntry = YES;
    [self.view addSubview:_pwdTF];
    
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setFrame:CGRectMake(TF_X2, TF_Y2+INTERVAL_H_1+50, 17, 17)];
    [_selectButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateNormal];
    [_selectButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateSelected];
    [_selectButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:_selectButton];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

@end
