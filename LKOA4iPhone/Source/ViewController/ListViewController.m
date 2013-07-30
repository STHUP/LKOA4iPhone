//
//  ListViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-29.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "ListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DBGWViewController.h"
#import "QSBGViewController.h"
#import "ZJXTViewController.h"
#import "XMGLViewController.h"

#define CELL_HEIGHT 84


@interface ListViewController ()

@end

@implementation ListViewController

@synthesize myArray = _myArray;
@synthesize myTableView = _myTableView;
@synthesize catalogTag = _catalogTag;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [[LKOAAppDelegate getDelegate].rootNavigationController setNavigationBarHidden:YES animated:YES ];
    
    _myArray = [[NSArray alloc] initWithObjects:@"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知。", @"12", @"12", nil];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 10, 310, 325) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView setBackgroundColor:[UIColor clearColor]];
    UIView *nullView = [[UIView alloc] init];
    [_myTableView setBackgroundView:nullView];
    [self.view addSubview:_myTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
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
    UIImageView *cellBg = [[UIImageView alloc] initWithFrame:cell.frame];
    [cellBg setImage:[UIImage imageNamed:@"group_bg_n"]];
    [cell setBackgroundView:cellBg];
    
    //自定义UITableViewCell选中时背景
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"group_bg_s"]];
    
    UIImageView *leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 7)];
    [leftIV setImage:[UIImage imageNamed:@"arrows"]];
    [cell.contentView addSubview:leftIV];
    
    NSLog(@"cout:  %d", [_myArray count]);
    
    NSString *content = [_myArray objectAtIndex:indexPath.section];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 225, 40)];
    [contentLabel setText:content];
    contentLabel.lineBreakMode = UILineBreakModeWordWrap;
    contentLabel.numberOfLines = 0;
    [contentLabel setBackgroundColor:[UIColor clearColor]];
    [contentLabel setFont:[UIFont systemFontOfSize:15]];
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(225.0f, 2000.0f)
                       lineBreakMode:UILineBreakModeWordWrap];
    CGRect rect=contentLabel.frame;
    rect.size=size;
    [contentLabel setFrame:rect];
    [contentLabel setText:content];
    [cell.contentView addSubview:contentLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 55, 100, 25)];
    [timeLabel setBackgroundColor:[UIColor clearColor]];
    [timeLabel setTextColor:[UIColor blueColor]];
    [timeLabel setText:@"2012-05-09"];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    [cell.contentView addSubview:timeLabel];
    
//
//    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_X, NAME_H, 80, 25)];
//    [nameLabel setText:@"刘凤山"];
//    [nameLabel setFont:[UIFont systemFontOfSize:13]];
//    [cell.contentView addSubview:nameLabel];
//    
//    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_X + 55, NAME_H, 100, 25)];
//    [timeLabel setText:@"2013-05-05"];
//    [timeLabel setFont:[UIFont systemFontOfSize:13]];
//    [timeLabel setTextColor:[UIColor blueColor]];
//    [cell.contentView addSubview:timeLabel];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat
{
//    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    switch (_catalogTag) {
        case 1:
        {
            DBGWViewController *vc = [[DBGWViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            QSBGViewController *vc = [[QSBGViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            XMGLViewController *vc = [[XMGLViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:
        {
            ZJXTViewController *vc = [[ZJXTViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
