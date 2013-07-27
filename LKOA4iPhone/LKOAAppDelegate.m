//
//  LKOAAppDelegate.m
//  LKOA4iPhone
//
//  Created by  STH on 7/26/13.
//  Copyright (c) 2013 DHC. All rights reserved.
//

#import "LKOAAppDelegate.h"
#import "LoginViewController.h"
@implementation LKOAAppDelegate
@synthesize rootNavigationController = _rootNavigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    self.window.rootViewController = self.rootNavigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    // 判断程序以前是否有登录过，是否是第一次运行程序
    if (![UserDefaults boolForKey:kEVERLaunched]) {
        [UserDefaults setBool:YES forKey:kEVERLaunched];
        [UserDefaults setBool:YES forKey:kFIRSTLaunched];
    }
    else{
        [UserDefaults setBool:NO forKey:kFIRSTLaunched];
    }
    
    
    // 如果程序是第一次运行
    if ([UserDefaults boolForKey:kFIRSTLaunched]) {
        // 设置默认的IP地址
        [UserDefaults setObject:@"124.205.53.178:9596" forKey:kHOSTNAME];
        [UserDefaults synchronize];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
