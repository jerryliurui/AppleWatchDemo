//
//  GlanceController.m
//  AppleWatchDemo WatchKit Extension
//
//  Created by JerryLiu on 15/2/19.
//  Copyright (c) 2015年 JerryLiu. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    userInfo[@"PicName"] = @"applewatch003";
    userInfo[@"Source"] = @"Glance";
    
    [self updateUserActivity:WK_HANDOFF_demoDETAIL_IDENDIFIER userInfo:userInfo webpageURL:nil];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



