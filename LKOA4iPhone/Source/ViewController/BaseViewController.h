//
//  BaseViewController.h
//  LKOA4iPhone
//
//  Created by liao jia on 13-7-27.
//  Copyright (c) 2013年 DHC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollViewController;

@interface BaseViewController : UIViewController<UITextFieldDelegate>



@property(nonatomic, assign)BOOL hasCheckButton;
@property(nonatomic, assign)BOOL hasHomeButton;
@property(nonatomic, assign)ScrollViewController *scrollVC;
@end
