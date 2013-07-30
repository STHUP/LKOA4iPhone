//
//  DBListViewController.m
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-29.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import "DBListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DBGWViewController.h"
#import "CatalogViewController.h"
#import "ScrollViewController.h"

#define CELL_HEIGHT 84
#define REFRESH_HEADER_HEIGHT 15.0f

@interface DBListViewController ()

@end

@implementation DBListViewController

@synthesize myArray = _myArray;
@synthesize myTableView = _myTableView;
@synthesize textPull, textRelease, textLoading, refreshFooterView, refreshLabel, refreshArrow, refreshSpinner, hasMore, textNoMore;
//@synthesize scrollVC = _scrollVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setupStrings];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [[LKOAAppDelegate getDelegate].rootNavigationController setNavigationBarHidden:YES animated:YES ];
//    [self.navigationController setNavigationBarHidden:NO];
    
    _myArray = [[NSMutableArray alloc] initWithObjects:@"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知", @"关于转发国资委加强中英名保企业安全生产工作的紧急通知。", @"12", @"12",@"1234", @"12344", nil];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 10, 310, 325) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView setBackgroundColor:[UIColor clearColor]];
    UIView *nullView = [[UIView alloc] init];
    [_myTableView setBackgroundView:nullView];
    
    
    [self.view addSubview:_myTableView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self addPullToRefreshFooter];

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
    DBGWViewController *vc = [[DBGWViewController alloc] init];
    vc.title = @"待办公文";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupStrings{
    textPull    = @"上拉刷新...";
    textRelease = @"释放开始刷新...";
    textLoading = @"正在加载...";
    textNoMore  = @"没有更多内容了...";
    hasMore = YES;
}

-(void)addPullToRefreshFooter{
    refreshFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, REFRESH_HEADER_HEIGHT)];
    NSLog(@"fram: %f, contentheight: %f", self.myTableView.frame.size.height, self.myTableView.contentSize.height);
    refreshFooterView.backgroundColor = [UIColor clearColor];
    
    refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    refreshLabel.backgroundColor = [UIColor clearColor];
    refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    refreshLabel.textAlignment = UITextAlignmentCenter;
    
    refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    refreshArrow.frame = CGRectMake(floorf((52 - 27) / 2),
                                    (floorf(58 - 44) / 2),
                                    27, 44);
    
    refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshSpinner.frame = CGRectMake(floorf(floorf(52 - 20) / 2), floorf((52 - 20) / 2), 20, 20);
    refreshSpinner.hidesWhenStopped = YES;
    
    [refreshFooterView addSubview:refreshLabel];
    [refreshFooterView addSubview:refreshArrow];
    [refreshFooterView addSubview:refreshSpinner];
//    [self.myTableView addSubview:refreshFooterView];
    [self.myTableView setTableFooterView:refreshFooterView];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading) return;
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading && scrollView.contentOffset.y > 0) {
        // Update the content inset, good for section headers
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, REFRESH_HEADER_HEIGHT, 0);
    }else if(!hasMore){
        refreshLabel.text = self.textNoMore;
        refreshArrow.hidden = YES;
    }else if (isDragging && scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= 0 ) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        refreshArrow.hidden = NO;
        if (scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            refreshLabel.text = self.textRelease;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            refreshLabel.text = self.textPull;
            [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading || !hasMore) return;
    isDragging = NO;
    
    //    CGPoint offset = scrollView.contentOffset;
    //    CGRect bounds = scrollView.bounds;
    //    CGSize size = scrollView.contentSize;
    //    UIEdgeInsets inset = scrollView.contentInset;
    //    CGFloat currentOffset = offset.y + bounds.size.height - inset.bottom;
    //
    //    CGFloat maximumOffset = size.height;
    //
    //    (maximumOffset - currentOffset) <= -REFRESH_HEADER_HEIGHT)
    
    //上拉刷新
    if(scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.bounds.size.height - scrollView.contentInset.bottom) <= -REFRESH_HEADER_HEIGHT && scrollView.contentOffset.y > 0){
        [self startLoading];
    }
}

- (void)startLoading {
    isLoading = YES;
    
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.myTableView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, 0, 0, 0);
    refreshLabel.text = self.textLoading;
    refreshArrow.hidden = YES;
    [refreshSpinner startAnimating];
    [UIView commitAnimations];
    
    // Refresh action!
    [self refresh];
}

- (void)stopLoading {
    isLoading = NO;
    
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
    self.myTableView.contentInset = UIEdgeInsetsZero;
    UIEdgeInsets tableContentInset = self.myTableView.contentInset;
    tableContentInset.top = 0.0;
    self.myTableView.contentInset = tableContentInset;
    [refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    NSLog(@"%f",self.myTableView.contentSize.height);
    
    refreshLabel.text = self.textPull;
    refreshArrow.hidden = NO;
    
//    [refreshFooterView setFrame:CGRectMake(0, self.myTableView.contentSize.height, 320, 0)];
    
    [refreshSpinner stopAnimating];
}

- (void)refresh {
    // This is just a demo. Override this method with your custom reload action.
    // Don't forget to call stopLoading at the end.
    [_myArray addObject:@"23456"];
    [_myArray addObject:@"999"];
    [_myTableView reloadData];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:2.0];
}

//-(IBAction)backBUttonAction:(id)sender
//{
//    NSLog(@"ddd");
////    CatalogViewController *vc = [[CatalogViewController alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
//
////    [self.scrollVC.navigationController popViewControllerAnimated:YES];
//
//}
@end
