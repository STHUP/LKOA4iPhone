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
#import <QuartzCore/QuartzCore.h>
#define HEIGHT 20
#define CELL_HEIGHT 50
#define NAME_H 22
#define NAME_X 170
#define TITLE_H 5
#define R_TITLE_X 90
#define WIDTH 180

@interface DBGWViewController ()

@end

@implementation DBGWViewController

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;
@synthesize  isLeft = _isLeft;
@synthesize myArray = _myArray;
@synthesize myTableView = _myTableView;
@synthesize formIV = _formIV;
@synthesize fileTitleLabel = _fileTitleLabel;
@synthesize fileContentLabel = _fileContentLabel;
@synthesize fujianLabel = _fujianLabel;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.hasCheckButton = YES;
    self.hasHomeButton = YES;
    
    [self initViews];
    
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

-(IBAction)leftAction:(id)sender
{
    _isLeft = YES;
    [_myTableView removeFromSuperview];
    [self.view addSubview:_formIV];
    
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateSelected];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateNormal];
    
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateSelected];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateNormal];
}

-(IBAction)rightAction:(id)sender
{
    _isLeft = NO;
    [_formIV removeFromSuperview];
    [self.view addSubview:_myTableView];
    [_myTableView reloadData];
    
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_s_left"] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_s_left"] forState:UIControlStateSelected];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_s_left"] forState:UIControlStateNormal];
    
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_n_right"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_n_right"] forState:UIControlStateSelected];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_n_right"] forState:UIControlStateNormal];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_myArray count];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return CELL_HEIGHT;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ( cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //避免重叠
    for (UIView *view in cell.contentView.subviews)
    {
        [view removeFromSuperview];
    }
    
    NSString *title = [_myArray objectAtIndex:indexPath.row];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, TITLE_H, 150, 40)];
    [titlelabel setText:title];
    titlelabel.lineBreakMode = UILineBreakModeWordWrap;
    titlelabel.numberOfLines = 0;
    [titlelabel setBackgroundColor:[UIColor clearColor]];
    [titlelabel setTextAlignment:UITextAlignmentLeft];
    [titlelabel setFont:[UIFont systemFontOfSize:15]];
    [cell.contentView addSubview:titlelabel];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_X, NAME_H, 80, 25)];
    [nameLabel setText:@"刘凤山"];
    [nameLabel setFont:[UIFont systemFontOfSize:13]];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_X + 55, NAME_H, 100, 25)];
    [timeLabel setText:@"2013-05-05"];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    [timeLabel setTextColor:[UIColor blueColor]];
    [cell.contentView addSubview:timeLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

-(void)initViews{
    self.isLeft = YES;
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftButton setFrame:CGRectMake(16, HEIGHT, 144, 34)];
    [_leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton setTitle:@"文件信息" forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateNormal];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateSelected];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"item_n_left"] forState:UIControlStateNormal];
    [self.view addSubview:_leftButton];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setFrame:CGRectMake(160, HEIGHT, 144, 34)];
    [_rightButton setTitle:@"办理轨迹" forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateSelected];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"item_s_right"] forState:UIControlStateNormal];
    [self.view addSubview:_rightButton];
    
    _formIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"form"]];
    [_formIV setFrame:CGRectMake(17, HEIGHT+54, 286, 249)];
    [self.view addSubview:_formIV];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, 70, 25)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"文件标题"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_formIV addSubview:titleLabel];
    
    _fileTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(R_TITLE_X, 13, WIDTH, 40)];
    [_fileTitleLabel setBackgroundColor:[UIColor clearColor]];
    [_fileTitleLabel setText:@"文件标题"];
    [_fileTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_fileTitleLabel setFont:[UIFont systemFontOfSize:14]];
    _fileTitleLabel.lineBreakMode = UILineBreakModeWordWrap;
    _fileTitleLabel.numberOfLines = 0;
    [_fileTitleLabel setTextAlignment:UITextAlignmentLeft];
    [_formIV addSubview:_fileTitleLabel];
    
    //
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 70, 25)];
    [contentLabel setBackgroundColor:[UIColor clearColor]];
    [contentLabel setText:@"文件正文"];
    [contentLabel setTextAlignment:NSTextAlignmentCenter];
    [contentLabel setFont:[UIFont systemFontOfSize:14]];
    [_formIV addSubview:contentLabel];
    
    _fileContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(R_TITLE_X, 75, WIDTH, 45)];
    [_fileContentLabel setBackgroundColor:[UIColor clearColor]];
    [_fileContentLabel setText:@"文件标题正文文件标题正文文件标题正.doc"];
    [_fileContentLabel setTextAlignment:NSTextAlignmentCenter];
    [_fileContentLabel setFont:[UIFont systemFontOfSize:14]];
    _fileContentLabel.lineBreakMode = UILineBreakModeWordWrap;
    _fileContentLabel.numberOfLines = 0;
    [_fileContentLabel setTextColor:[UIColor blueColor]];
    [_fileContentLabel setTextAlignment:UITextAlignmentLeft];
    [_formIV addSubview:_fileContentLabel];
    
    //
    UILabel *fujianLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 135, 70, 25)];
    [fujianLabel setBackgroundColor:[UIColor clearColor]];
    [fujianLabel setText:@"附件"];
    [fujianLabel setTextAlignment:NSTextAlignmentCenter];
    [fujianLabel setFont:[UIFont systemFontOfSize:14]];
    [_formIV addSubview:fujianLabel];
    
    _fujianLabel = [[UILabel alloc] initWithFrame:CGRectMake(R_TITLE_X, 135, WIDTH, 40)];
    [_fujianLabel setBackgroundColor:[UIColor clearColor]];
    [_fujianLabel setText:@"附件附件附件附件附件附件附件附件.doc"];
    [_fujianLabel setTextAlignment:NSTextAlignmentCenter];
    [_fujianLabel setFont:[UIFont systemFontOfSize:14]];
    _fujianLabel.lineBreakMode = UILineBreakModeWordWrap;
    _fujianLabel.numberOfLines = 0;
    [_fujianLabel setTextAlignment:UITextAlignmentLeft];
    [_formIV addSubview:_fujianLabel];
    
    
    //办理轨迹
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 75, 300, 250) style:UITableViewStylePlain];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.layer.borderWidth = 1;
    _myTableView.layer.borderColor = [[UIColor grayColor] CGColor];
    _myTableView.layer.cornerRadius = 8.0;
    
    
    _myArray = [NSArray arrayWithObjects:@"请信息中心阅示", @"请赵总阅示", @"请公司阅示，各个部门阅示", @"阅。", @"阅。", @"阅。", nil];
}
@end
