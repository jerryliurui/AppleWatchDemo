//
//  InterfaceController.h
//  AppleWatchDemo WatchKit Extension
//
//  Created by JerryLiu on 15/2/19.
//  Copyright (c) 2015年 JerryLiu. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

typedef enum  {
    JRWKOpenForNormal,          //普通打开
    JRWKOpenForComment,         //打开评论页
    JRWKOpenForFavorite,        //打开收藏页
    JRWKOpenForGlancedemo,      //打开来自glance 的信息
    JRWKOpenForNotificationdemo //打开来自Notification 的信息
} JRWKOpenType;

@interface JRMainInterfaceController : WKInterfaceController
{
    JRWKOpenType wkOpenType;
}

@end
