//
//  XTSZViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-28.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "XTSZViewController.h"
#import <QuartzCore/QuartzCore.h>
#define CELL_HEIGHT 40

@interface XTSZViewController ()

@end

@implementation XTSZViewController

@synthesize textArray = _textArray;

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
    [self.view setBackgroundColor:[UIColor whiteColor]];

    _textArray = [NSArray arrayWithObjects:@"帮助", @"新手引导", @"意见反馈", @"检查更新", @"访问官网", @"关于我们", @"注销登录", nil];
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, 300, 7*CELL_HEIGHT) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.layer.borderWidth = 1;
    myTableView.layer.borderColor = [[UIColor blackColor] CGColor];
    myTableView.layer.cornerRadius = 8.0;
    [self.view addSubview:myTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_textArray count];
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
    NSString *contentText = [_textArray objectAtIndex:indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 6, 100, 25)];
    [label setText:contentText];
    [label setFont:[UIFont systemFontOfSize:15]];
    [cell.contentView addSubview:label];
    
    NSString *imageName = [NSString stringWithFormat:@"seting_%d", indexPath.row+1];
    UIImageView *leftIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [leftIV setFrame:CGRectMake(15, 12, 15, 15)];
    [cell.contentView addSubview:leftIV];
    
    if (indexPath.row == 1 || indexPath.row == 4) {
        UIImageView *newIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new"]];
        [newIV setFrame:CGRectMake(250, 12.5, 29, 15)];
        [cell.contentView addSubview:newIV];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPat
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
@end
