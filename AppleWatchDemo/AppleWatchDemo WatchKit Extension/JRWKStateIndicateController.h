//
//  LoginInterfaceController.h
//  demoBoard
//
//  Created by 刘瑞 on 15/1/15.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

typedef enum
{
    indicateLogin = 0,
    indicateNetworkError,
    indicateCommentSuc,
    indicateFavoriteSuc
}
indicateType;

@interface JRWKStateIndicateController : WKInterfaceController

@end
