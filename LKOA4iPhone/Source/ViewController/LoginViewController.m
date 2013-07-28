//
//  LoginViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-26.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "LoginViewController.h"
#import "CatalogViewController.h"

#define TF_X1 20
#define TF_X2 90
#define TF_Y 30
#define TF_Y2 168
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
@synthesize remeberPwdButton = _remeberPwdButton;
@synthesize autoLoginButton = _autoLoginButton;
@synthesize isRemeber = _isRemeber;
@synthesize isAutoLogin = _isAutoLogin;

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
    
    _isRemeber = false;
    _isAutoLogin = false;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    
    UIButton *setIPButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [setIPButton setFrame:CGRectMake(280, 10, 21, 21)];
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"ip_button_n"] forState:UIControlStateNormal];
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"ip_button_s"] forState:UIControlStateSelected];
    [setIPButton setBackgroundImage:[UIImage imageNamed:@"ip_button_s"] forState:UIControlStateHighlighted];
    [setIPButton addTarget:self action:@selector(setIPAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:setIPButton];
    
    UIImageView *logoIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [logoIV setFrame:CGRectMake(44, 30, 233, 65)];
    [logoIV setUserInteractionEnabled:YES];
    [self.view addSubview:logoIV];
    
    UIImageView *middleIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"middle_bg"]];
    [middleIV setFrame:CGRectMake(7, 140, 306, 234)];
    [middleIV setUserInteractionEnabled:YES];
    [self.view addSubview:middleIV];
    
    UILabel *userLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X1, TF_Y, TF_W1, TF_H1)];
    [userLabel setBackgroundColor:[UIColor clearColor]];
    [userLabel setText:@"用户名："];
    [userLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [middleIV addSubview:userLabel];
    
    UILabel *pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X1, TF_Y+INTERVAL_H_1, TF_W1, TF_H1)];
    [pwdLabel setBackgroundColor:[UIColor clearColor]];
    [pwdLabel setText:@"密    码："];
    [pwdLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [middleIV addSubview:pwdLabel];
    
    _userTF  = [[UITextField alloc] initWithFrame:CGRectMake(TF_X2, TF_Y2, TF_W2, TF_H2)];
    [_userTF setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_bg"]]];
    _userTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _userTF.delegate = self;
    [_userTF setPlaceholder:@"请输入用户名"];
    [_userTF setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:_userTF];
    
    _pwdTF  = [[UITextField alloc] initWithFrame:CGRectMake(TF_X2, TF_Y2+INTERVAL_H_1, TF_W2, TF_H2)];
    [_pwdTF setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"input_bg"]]];
    _pwdTF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _pwdTF.delegate = self;
    [_pwdTF setPlaceholder:@"请输入密码"];
    [_pwdTF setFont:[UIFont boldSystemFontOfSize:15]];
    _pwdTF.secureTextEntry = YES;
    [self.view addSubview:_pwdTF];
    
    _remeberPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_remeberPwdButton setFrame:CGRectMake(TF_X2, TF_Y2+INTERVAL_H_1+50, 17, 17)];
    [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateNormal];
    [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateSelected];
    [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateHighlighted];
    [_remeberPwdButton addTarget:self action:@selector(remeberAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_remeberPwdButton];
    
    UILabel *remeberLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X2 +25, TF_Y2+INTERVAL_H_1+45, 80, TF_H1)];
    [remeberLabel setBackgroundColor:[UIColor clearColor]];
    [remeberLabel setText:@"忘记密码"];
    [remeberLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:remeberLabel];
    
    _autoLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_autoLoginButton setFrame:CGRectMake(TF_X2+72, TF_Y2+INTERVAL_H_1+45, 80, TF_H1)];
    [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateNormal];
    [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateSelected];
    [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateHighlighted];
    [_autoLoginButton addTarget:self action:@selector(autoLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_autoLoginButton];
    
    UILabel *autoLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(TF_X2 + 127, TF_Y2+INTERVAL_H_1+45, 80, TF_H1)];
    [autoLoginLabel setBackgroundColor:[UIColor clearColor]];
    [autoLoginLabel setText:@"自动登录"];
    [autoLoginLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [self.view addSubview:autoLoginLabel];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setFrame:CGRectMake(42, TF_Y2+INTERVAL_H_1+90, 243, 34)];
    [loginButton setTitle:@"登   录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button_n"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button_n"] forState:UIControlStateSelected];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button_n"] forState:UIControlStateHighlighted];
    [loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
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

-(IBAction)remeberAction:(id)sender{
    _isRemeber = !_isRemeber;
    if (_isRemeber) {
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateNormal];
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateSelected];
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateHighlighted];
    }else{
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateNormal];
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateSelected];
        [_remeberPwdButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateHighlighted];
    }
}

-(IBAction)autoLoginAction:(id)sender{
    _isAutoLogin = !_isAutoLogin;
    if (_isAutoLogin) {
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateNormal];
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateSelected];
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_s"] forState:UIControlStateHighlighted];
    }else{
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateNormal];
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateSelected];
        [_autoLoginButton setImage:[UIImage imageNamed:@"select_button_n"] forState:UIControlStateHighlighted];
    }
}

-(IBAction)setIPAction:(id)sender
{
    
}

-(IBAction)loginAction:(id)sender
{
    CatalogViewController *vc = [[CatalogViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
