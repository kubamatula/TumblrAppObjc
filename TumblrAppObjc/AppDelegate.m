//
//  AppDelegate.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 06/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "AppDelegate.h"
#import "PostsViewController.h"
#import "Chameleon.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    PostsViewController *postsVC = [[PostsViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController: postsVC];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    [Chameleon setGlobalThemeUsingPrimaryColor: [UIColor flatRedColor] withContentStyle: UIContentStyleContrast];
    return YES;
}
@end
