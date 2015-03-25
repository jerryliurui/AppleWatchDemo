//
//  LoginInterfaceController.m
//  demoBoard
//
//  Created by 刘瑞 on 15/1/15.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//

#import "JRWKStateIndicateController.h"


@interface JRWKStateIndicateController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *indicateBG;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *indicateTips;

@end


@implementation JRWKStateIndicateController
{
    //显示那种状态
    indicateType _indicateType;
    
    //收藏与否
    BOOL _favorite;
    
    //是否是直接跳转到主Controller
    BOOL _jumptomaincontroller;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSString *indicateTypeString = [context objectForKey:@"type"];
    
    NSString *isNeedReturnMainPage = [context objectForKey:@"isNeedReturnMainPage"];
    
    if ([isNeedReturnMainPage isEqualToString:@"YES"]) {
        _jumptomaincontroller = YES;
    }

    if ([indicateTypeString isEqualToString:@"Login"]) {
        _indicateType = indicateLogin;
    }else if ([indicateTypeString isEqualToString:@"NetWorkError"])
    {
        _indicateType = indicateNetworkError;
    }else if ([indicateTypeString isEqualToString:@"CommentSucc"])
    {
        _indicateType = indicateCommentSuc;
    }else if ([indicateTypeString isEqualToString:@"FavoriteSucc"])
    {
        _indicateType = indicateFavoriteSuc;
        NSString *favoriteString = [context objectForKey:@"whetherFavotitedemo"];
        _favorite = ([favoriteString isEqualToString:@"favorite"])? YES:NO;
    }else
    {
        //扩展
    }
}

- (void)willActivate {
    [super willActivate];
    [self setUpUI];
}

- (void)didDeactivate {
    [super didDeactivate];
    if (_jumptomaincontroller) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AW_JUMP_FROM_INDICATEPAGE_TO_MAINPAGE object:nil];
    }
}

- (void)setUpUI
{
    NSString *imageName = @"";
    NSString *tips = @"";
    switch (_indicateType) {
        case indicateLogin:
            imageName = @"yellowapple";
            tips = @"请先在手机客户端上登录";
            break;
        case indicateNetworkError:
            imageName = @"orangeapple";
            tips = @"网络连接失败/n 请检查网络";
            break;
        case indicateCommentSuc:
            imageName = @"purpleapple";
            tips = @"发表成功";
            break;
        case indicateFavoriteSuc:
            imageName = @"colorfulapple";
            if (_favorite) {
                tips = @"收藏成功";
            }else
            {
                tips = @"取消收藏成功";
            }
            break;
        default:
            
            break;
    }
    
    [self.indicateBG setImageNamed:imageName];
    [self.indicateTips setText:tips];
}

@end



