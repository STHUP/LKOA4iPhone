//
//  CheckViewController.m 
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//
//签核
#import "CheckViewController.h"

#define H 220
@interface CheckViewController ()

@end

@implementation CheckViewController

@synthesize adviceTV = _adviceTV;

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
    
    self.navigationItem.title = @"签核";
    self.hasCheckButton = NO;
    self.hasHomeButton = YES;

    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [scrollView setContentSize:CGSizeMake(320, 600)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    [scrollView setShowsVerticalScrollIndicator:NO];
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgButton setBackgroundColor:[UIColor clearColor]];
    [bgButton setFrame:CGRectMake(0, 0, scrollView.contentSize.height, scrollView.contentSize.width)];
    [bgButton addTarget:self action:@selector(bgAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:bgButton];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *inputBgIV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 301, 195)];
    [inputBgIV setImage:[UIImage imageNamed:@"check_input"]];
    [scrollView addSubview:inputBgIV];
    
    _adviceTV = [[UITextView alloc] initWithFrame:CGRectMake(15, 15, 290, 185)];
    [_adviceTV setFont:[UIFont systemFontOfSize:15]];
    _adviceTV.delegate = self;
    _adviceTV.text = @"请签核意见……";
    [_adviceTV setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:_adviceTV];
    
    
    UIButton *agreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [agreenButton setFrame:CGRectMake(10, H, 144, 34)];
    [agreenButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_n"] forState:UIControlStateNormal];
    [agreenButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_s"] forState:UIControlStateSelected];
    [agreenButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_s"] forState:UIControlStateHighlighted];
    [agreenButton setTitle:@"同  意" forState:UIControlStateNormal];
    [agreenButton.titleLabel setTextColor:[UIColor whiteColor]];
    [agreenButton addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:agreenButton];
    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [readButton setFrame:CGRectMake(166, H, 144, 34)];
    [readButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_n"] forState:UIControlStateNormal];
    [readButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_s"] forState:UIControlStateSelected];
    [readButton setBackgroundImage:[UIImage imageNamed:@"agree_bt_s"] forState:UIControlStateHighlighted];
    [readButton setTitle:@"阅" forState:UIControlStateNormal];
    [readButton.titleLabel setTextColor:[UIColor whiteColor]];
    [readButton addTarget:self action:@selector(readAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:readButton];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setFrame:CGRectMake(10, H + 50, 300, 35)];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"commit_bt_n"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"commit_bt_s"] forState:UIControlStateSelected];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"commit_bt_s"] forState:UIControlStateHighlighted];
    [commitButton setTitle:@"提  交" forState:UIControlStateNormal];
    [commitButton.titleLabel setTextColor:[UIColor whiteColor]];
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:commitButton];
    
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_adviceTV setText:@""];
    return YES;
}

-(IBAction)bgAction:(id)sender{
    [_adviceTV resignFirstResponder];
}

-(IBAction)agreeAction:(id)sender
{
    [_adviceTV setText:@"同意"];
}

-(IBAction)readAction:(id)sender
{
    [_adviceTV setText:@"阅"];
}

-(IBAction)commitAction:(id)sender
{
    
}
@end
