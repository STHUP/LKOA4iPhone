//
//  BaseViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-27.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "BaseViewController.h"
#define kSCNavBarImageTag       10

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize hasCheckButton = _hasCheckButton;
@synthesize hasHomeButton = _hasHomeButton;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //自定义UINavigationBar 和返回按钮
    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        //if iOS 5.0 and later
        [navBar setBackgroundImage:[UIImage imageNamed:@"navbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar.png"]];
            [imageView setTag:kSCNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
   
    if (!self.navigationItem.hidesBackButton){
        // 返回按纽
        UIImage *buttonNormalImage = [UIImage imageNamed:@"backbutton_normal.png"];
        UIImage *buttonSelectedImage = [UIImage imageNamed:@"backbutton_normal.png"];
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [aButton setTitle:@" 返回" forState:UIControlStateNormal];
        aButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [aButton setBackgroundImage:buttonNormalImage forState:UIControlStateNormal];
        [aButton setBackgroundImage:buttonSelectedImage forState:UIControlStateSelected];
        aButton.frame = CGRectMake(0.0,0.0,buttonNormalImage.size.width,buttonNormalImage.size.height);
        [aButton addTarget:self action:@selector(backBUttonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:aButton];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    if (_hasCheckButton) {
        UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton setFrame:CGRectMake(222, 7, 50, 30)];
        [checkButton setTitle:@"签核" forState:UIControlStateNormal];
        [checkButton.titleLabel setTextColor:[UIColor whiteColor]];
        [checkButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"check_s"] forState:UIControlStateHighlighted];
        [checkButton setBackgroundImage:[UIImage imageNamed:@"check_s"] forState:UIControlStateSelected];
        [checkButton setTag:1010];
        [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:checkButton];
    }else{
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            int tag = ((UIButton*)view).tag;
            if (tag == 1010) {
                [view removeFromSuperview];
            }
        }
    }
    
    if (_hasHomeButton) {
        UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [homeButton setFrame:CGRectMake(277, 7, 37, 31)];
        [homeButton setBackgroundImage:[UIImage imageNamed:@"home_n"] forState:UIControlStateNormal];
        [homeButton setBackgroundImage:[UIImage imageNamed:@"home_s"] forState:UIControlStateHighlighted];
        [homeButton setBackgroundImage:[UIImage imageNamed:@"home_s"] forState:UIControlStateSelected];
        [homeButton setTag:1011];
        [homeButton addTarget:self action:@selector(homeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:homeButton];
    }else{
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            int tag = ((UIButton*)view).tag;
            if (tag == 1011) {
                [view removeFromSuperview];
            }
        }
    }
    
    
}

#pragma mark -

#pragma mark 解决虚拟键盘挡住UITextField的方法

- (void)keyboardWillShow:(NSNotification *)noti

{
    
    //键盘输入的界面调整
    
    //键盘的高度
    
    float height = 216.0;
    
    CGRect frame = self.view.frame;
    
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    
    [UIView setAnimationDuration:0.30];
    
    [UIView setAnimationDelegate:self];
    
    [self.view setFrame:frame];
    
    [UIView commitAnimations];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    //CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    
    return YES;
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField

{
    
    CGRect frame = textField.frame;
    
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;       
        
    }       
    
    [UIView commitAnimations];               
    
}

#pragma mark -

-(IBAction)backBUttonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)homeAction:(id)sender
{

}
@end
