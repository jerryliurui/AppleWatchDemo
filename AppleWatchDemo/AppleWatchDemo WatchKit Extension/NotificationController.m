//
//  NotificationController.m
//  AppleWatchDemo WatchKit Extension
//
//  Created by JerryLiu on 15/2/19.
//  Copyright (c) 2015年 JerryLiu. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *newsTitle;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *newsDigest;
@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

/*
- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}
*/

- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification inteface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    if (remoteNotification) {
        NSDictionary *aps = [remoteNotification objectForKey:@"aps"];
        NSString *category = [aps objectForKey:@"category"];
        if ([category isEqualToString:@"NEWS_CATEGORY"]) {
            NSString *title = [aps objectForKey:@"title"];
            NSString *digest = [aps objectForKey:@"alert"];
            [self.newsTitle setText:title];
            [self.newsDigest setText:digest];
            

            NSMutableDictionary *userInfo = [NSMutableDictionary new];
            userInfo[@"PicName"] = @"applewatch004";
            userInfo[@"Source"] = @"Notification";
            
            [self updateUserActivity:WK_HANDOFF_demoDETAIL_IDENDIFIER userInfo:userInfo webpageURL:nil];
        }
    }
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}

@end



