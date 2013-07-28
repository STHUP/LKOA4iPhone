//
//  DBGWViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "DBGWViewController.h"
#import "LKOAAppDelegate.h"
#import "CheckViewController.h"

@interface DBGWViewController ()

@end

@implementation DBGWViewController

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
    NSLog(@"title: %@", [LKOAAppDelegate getDelegate].rootNavigationController.navigationItem.title);
    [[LKOAAppDelegate getDelegate].rootNavigationController setNavigationBarHidden:YES animated:YES ];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.hasCheckButton = YES;
    self.hasHomeButton = YES;
//    [self navButtonAdd];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navButtonAdd{
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setFrame:CGRectMake(222, 7, 50, 30)];
    [checkButton setTitle:@"签核" forState:UIControlStateNormal];
    [checkButton.titleLabel setTextColor:[UIColor whiteColor]];
    [checkButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"check_s"] forState:UIControlStateHighlighted];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"check_s"] forState:UIControlStateSelected];
    [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:checkButton];
    
    // 返回按纽
    UIImage *buttonNormalImage = [UIImage imageNamed:@"backbutton_normal.png"];
    UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_normal.png"];
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setTitle:@" 返回" forState:UIControlStateNormal];
    aButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [aButton setBackgroundImage:buttonNormalImage forState:UIControlStateNormal];
    [aButton setBackgroundImage:buttonSelectedImage forState:UIControlStateSelected];
    aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
    [aButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    self.navigationItem.leftBarButtonItem = backButton;
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [homeButton setFrame:CGRectMake(277, 7, 37, 31)];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"home_n"] forState:UIControlStateNormal];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"home_s"] forState:UIControlStateHighlighted];
    [homeButton setBackgroundImage:[UIImage imageNamed:@"home_s"] forState:UIControlStateSelected];
    [homeButton addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:homeButton];
}

-(IBAction)checkAction:(id)sender
{
    CheckViewController *vc = [[CheckViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(IBAction)homeAction:(id)sender
{
    NSLog(@"homeaction");
}

-(IBAction)backButtonAction:(id)sender
{
    
}
@end
