//
//  AppDelegate.m
//  AppleWatchDemo
//
//  Created by JerryLiu on 15/2/19.
//  Copyright (c) 2015年 JerryLiu. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - WatchKit Data
-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply
{
    NSString *type = userInfo[@"type"];
    NSDictionary *para = userInfo[@"para"];
    NSString *picName = para[@"PicName"];
    NSArray *picNamesArray = [NSArray arrayWithObjects:@"applewatch001",@"applewatch002",@"applewatch003",@"applewatch004",@"applewatch005",@"applewatch006", nil];
    NSDictionary *replyInfo;
    if ([type isEqualToString:@"isLogin"]) {
        int random = arc4random()%10 + 1;
        NSString *whetherLogin = @"";
        if (random == 1) {
            whetherLogin = @"YES";
        }else
        {
            whetherLogin =@"NO";
        }
        replyInfo = @{@"whetherLogin":whetherLogin};
    }
    else if ([type isEqualToString:@"isFavorite"])
    {
        NSString *whetherFav = @"";
        if (picName) {
            if (picNamesArray.count > 2) {
                NSString *favPic1 = picNamesArray[0];
                NSString *favPic2 = picNamesArray[1];
                if ([picName isEqualToString:favPic1] || [picName isEqualToString:favPic2]) {
                    whetherFav = @"YES";
                }else
                {
                    whetherFav = @"NO";
                }
            }else
            {
                whetherFav = @"NO";
            }
        }else
        {
            whetherFav = @"NO";
        }
        replyInfo = @{@"isFavorite":whetherFav};
    }
    else if ([type isEqualToString:@"replySomething"])
    {
        replyInfo = @{@"TextInput":@"Received"};
    }
    
    reply(replyInfo);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
