//
//  AppDelegate.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 06/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "AppDelegate.h"
#import "TumblrAPIClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TumblrAPIClient.sharedClient go];
    return YES;
}
@end
