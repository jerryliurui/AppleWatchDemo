//
//  InterfaceController.m
//  AppleWatchDemo WatchKit Extension
//
//  Created by JerryLiu on 15/2/19.
//  Copyright (c) 2015年 JerryLiu. All rights reserved.
//

#import "JRMainInterfaceController.h"

@interface JRMainInterfaceController()

@end


@implementation JRMainInterfaceController
{
    //page-based controllers
    NSMutableArray *_controllersArrays;
    
    //page-based contexts
    NSMutableArray *_contextsArray;
    
    //pics Array
    NSArray *_appleWatcPics;
    
    NSString *_glancePicName;

}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _appleWatcPics = [NSArray arrayWithObjects:@"applewatch001",@"applewatch002",@"applewatch003",@"applewatch004",@"applewatch005",@"applewatch006", nil];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    switch (wkOpenType) {
        case JRWKOpenForGlancedemo:
            //
            break;
        case JRWKOpenForNotificationdemo:
            //
            break;
            
        default:
            [self showPageBaseddemoController];
            break;
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

//Watch App 主要的呈现新闻的方法，六条新闻
-(void)showPageBaseddemoController
{
    if (_appleWatcPics.count > 0) {
        _controllersArrays = [[NSMutableArray alloc] initWithCapacity:_appleWatcPics.count];
        _contextsArray = [[NSMutableArray alloc] initWithCapacity:_appleWatcPics.count];
        for (int i = 0; i < _appleWatcPics.count; i++) {
            [_controllersArrays addObject:WKdemoPAGECONTROLLERIDENTIFIER];
            NSDictionary *contextDic = @{@"PicName":_appleWatcPics[i],@"isGlancedemo":@"NO",@"index":[NSNumber numberWithInt:i]};
            [_contextsArray addObject:contextDic];
        }
        [WKInterfaceController reloadRootControllersWithNames:_controllersArrays contexts:_contextsArray];
    }
}

-(void)handleUserActivity:(NSDictionary *)userInfo
{
    wkOpenType = JRWKOpenForGlancedemo;
    if (userInfo) {
        NSString *sourceString = [userInfo objectForKey:@"Source"];
        NSString *picName = [userInfo objectForKey:@"PicName"];
        
        if ([sourceString isEqualToString:@"Glance"]) {
            _glancePicName = picName;
        }
    }
}

-(void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{
    wkOpenType = JRWKOpenForNotificationdemo;

    //巴拉巴拉巴拉
    [self showPageBaseddemoController];
}

@end



