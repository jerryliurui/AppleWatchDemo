//
//  demoDetailInterfaceController.m
//  demoBoard
//
//  Created by JerryLiu on 14/12/25.
//  Copyright (c) 2014年 USTE.SSE, Inc. All rights reserved.
//

#import "JRWKdemoDetailController.h"

@interface JRWKdemoDetailController()

//标题
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *demoDetailTitle;
//评论数
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *comment;
//发生时间
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *demoTimer;
//图片
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *demoImageGroup;
//正文
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *demoContent;
//handoff Tips
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *tipsLabel;

@end


@implementation JRWKdemoDetailController
{
    BOOL _whetherJumpToMainPage;
    
    //是否收藏
    BOOL _whetherFavorite;
    
    NSString *_picName;
    
    NSInteger _index;
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _picName = [context objectForKey:@"PicName"];
    NSNumber *indexNum = [context objectForKey:@"index"];
    _index = [indexNum integerValue];
    [self setUpUI];
}		

- (void)willActivate {
    [super willActivate];
    //HandOff
    [self updateUserActivity:WK_HANDOFF_demoDETAIL_IDENDIFIER userInfo:@{@"PicName":_picName} webpageURL:nil];
    //增加Menu Item
    [self addMenuItems];
}

- (void)didDeactivate {
    [super didDeactivate];
    if (_whetherJumpToMainPage) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AW_demoDETAILPAGE_TO_MAINPAGE object:nil];
    }
    //HandOff
    [self invalidateUserActivity];
}


#pragma mark - UI
- (void)addMenuItems
{
    //Fouce Touch Item Button
    //收藏Item
    NSDictionary *paraDic = @{@"PicName":_picName};
    [WKInterfaceController openParentApplication:@{@"type":@"isFavorite",@"para":paraDic} reply:^(NSDictionary *replyInfo, NSError *error) {
        if (error || !replyInfo) {
            [self addMenuItemWithCommentTitile:@"评论" withFavorite:@"收藏"];
            return;
        }
        NSString *favoriteItemName;
        BOOL whetherFavorite = [[replyInfo objectForKey:@"isFavorite"] boolValue];
        _whetherFavorite = (whetherFavorite)?YES:NO;
        if (whetherFavorite) {
            favoriteItemName = @"取消收藏";
        }else
        {
            favoriteItemName = @"收藏";
        }
        [self addMenuItemWithCommentTitile:@"评论" withFavorite:favoriteItemName];
    }];
}

-(void)setUpUI
{
    //图片 可以在这里设置不同尺寸
    if (is38mm) {
        [self.demoImageGroup setBackgroundImageNamed:_picName];
    }else
    {
        [self.demoImageGroup setBackgroundImageNamed:_picName];
    }
    
    //配置评论数
    [self.comment setText:[NSString stringWithFormat:@"已有%li评论",200+_index]];
    //配置新闻标题
    [self.demoDetailTitle setText:@"Apple Watch图片鉴赏"];
    //配置新闻时间
    //2015-01-16 11:46:25
    NSString *dateString = @"2015-03-10 11:46:25";
    static NSDateFormatter *parser = nil;
    static NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
    if (parser == nil) {
        parser = [[NSDateFormatter alloc] init];
        [parser setDateFormat:dateFormat];
    }
    if (dateString.length > dateFormat.length) {
        dateString = [dateString substringToIndex:dateFormat.length];
    }
    NSDate *date = [parser dateFromString:dateString];
    [self.demoTimer setDate:date];
    [self.demoTimer start];
    
    //配置新闻摘要
    [self.demoContent setText:@"Imagine you’re back at September 9, 2014. Tim Cook has been taking a packed audience through the finer details of the new iPhone 6 and 6+, as well as the just- announced Apple Pay service. Just when things appear to be wrapping up, the familiar “One more thing...” keynote slide appears."];
    //配置tips
    [self.tipsLabel setText:@"「请使用HandOff查看更多内容」"];
}

#pragma mark - IBAction
//评论新闻
- (IBAction)commentdemo
{
    [self presentTextInputControllerWithSuggestions:kWatchRecommendCommentTips allowedInputMode:WKTextInputModeAllowAnimatedEmoji completion:^(NSArray *results) {
        NSLog(@"Text Input Results: %@", results);
        
        if (results[0] != nil) {
            // Sends a non-nil result to the parent iOS application.
            BOOL didOpenParent = [WKInterfaceController openParentApplication:@{@"type":@"replySomething"} reply:^(NSDictionary *replyInfo, NSError *error) {
                NSLog(@"Reply Info: %@", replyInfo);
                NSLog(@"Error: %@", [error localizedDescription]);
            }];
            NSLog(@"Did open parent application? %i", didOpenParent);
        }
    }];
}

//收藏新闻
- (IBAction)favoritedemo
{
    //如果没有登陆，跳到登陆页面
    [WKInterfaceController openParentApplication:@{@"type":@"isLogin"} reply:^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
        if (error || !replyInfo) {
            NSDictionary *contextDic = @{@"type":@"NetWorkError",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:WKINDICATECONTROLLERIDENTIFIER context:contextDic];
            return;
        }
        
        NSString *whetherLogin = [replyInfo objectForKey:@"whetherLogin"];
        if ([whetherLogin isEqualToString:@"YES"]) {
            //这里按照需求写
            [WKInterfaceController openParentApplication:@{@"type":@"favoritedemo"} reply:^(NSDictionary *replyInfo, NSError *error) {
                if (!error && replyInfo) {
                    NSNumber *code = [replyInfo objectForKey:@"code"];
                    int codeint = [code intValue];
                    if (codeint == 1) {
                        //显示收藏成功/取消收藏界面
                        NSDictionary *contextDic = @{@"type":@"FavoriteSucc",@"whetherFavotitedemo":@"favorite",@"isNeedReturnMainPage":@"NO"};
                        [self presentControllerWithName:WKINDICATECONTROLLERIDENTIFIER context:contextDic];
                        [self addMenuItemWithCommentTitile:@"评论" withFavorite:@"收藏"];
                        _whetherFavorite = !_whetherFavorite;
                    }
                }else
                {
                    //显示错误界面
                    NSDictionary *contextDic = @{@"type":@"NetWorkError",@"isNeedReturnMainPage":@"NO"};
                    [self presentControllerWithName:WKINDICATECONTROLLERIDENTIFIER context:contextDic];
                }
            }];
        }else
        {
            NSDictionary *contextDic = @{@"type":@"Login",@"isNeedReturnMainPage":@"NO"};
            [self presentControllerWithName:WKINDICATECONTROLLERIDENTIFIER context:contextDic];
        }
    }];
}

- (void)addMenuItemWithCommentTitile:(NSString *)commentTitle withFavorite:(NSString *)favoriteTitle
{
    [self clearAllMenuItems];
    [self addMenuItemWithImageNamed:@"user_comment_menu_button" title:commentTitle action:@selector(commentdemo)];
    if ([favoriteTitle isEqualToString:@"收藏"]) {
        [self addMenuItemWithImageNamed:@"user_favourite_menu_button" title:favoriteTitle action:@selector(favoritedemo)];
    }else
    {
        [self addMenuItemWithImageNamed:@"user_unfavourite_menu_button" title:favoriteTitle action:@selector(favoritedemo)];
    }
    
}

@end



