//
//  NTESNBWKdemoRowController.m
//  demoBoard
//
//  Created by 刘瑞 on 15/2/5.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//

#import "JRWKdemoRowController.h"
#import "JRWKdemoRow.h"

@interface JRWKdemoRowController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *demoRowTabel;

@end

@implementation JRWKdemoRowController
{
    //当前index
    NSInteger _currentIndex;
    
    BOOL whetherfirstopen;
    
    NSString *_picName;
    
    NSInteger _index;
}

#pragma mark - Controller life
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    _picName = [context objectForKey:@"PicName"];
    NSNumber *indexNum = [context objectForKey:@"index"];
    _index = [indexNum integerValue];
    NSString *isGlancedemo = [context objectForKey:@"isGlancedemo"];
    if ([isGlancedemo isEqualToString:@"YES"]) {
        [self becomeCurrentPage];
    }
}

- (void)willActivate {
    [super willActivate];
    
    if (!whetherfirstopen) {
        whetherfirstopen = YES;
        [self setUpUI];
    }
    //HandOff
    [self updateUserActivity:WK_HANDOFF_demoDETAIL_IDENDIFIER userInfo:@{@"PicName":_picName} webpageURL:nil];
}

- (void)didDeactivate {
    [super didDeactivate];
    
    //HandOff
    [self invalidateUserActivity];
}

#pragma mark - UI
- (void)setUpUI
{
    [self.demoRowTabel setNumberOfRows:1 withRowType:@"RowForOnedemo"];
    for (int i = 0; i < self.demoRowTabel.numberOfRows; i++) {
        JRWKdemoRow *demoRow = [self.demoRowTabel rowControllerAtIndex:i];
        [demoRow.demoCategory setText:[NSString stringWithFormat:@"第%ld张",_index+1]];

        [demoRow.demoTitle setText:@"Apple Watch图片鉴赏"];

        [demoRow.demoImage setBackgroundImageNamed:_picName];
        
        [demoRow.demoCommentsCount setText:[NSString stringWithFormat:@"已有%li评论",200+_index]];

        //2015-01-16 11:46:25
        NSString *dateString = @"2015-03-10 11:46:25";
        static NSDateFormatter *parser = nil;
        static NSString *dateFormat = @"yyyy-MM-dd HH:mm:ss";
        if (parser == nil) {
            parser = [[NSDateFormatter alloc] init];
            [parser setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*3600]];//设置为中国时区
            [parser setDateFormat:dateFormat];
        }
        if (dateString.length > dateFormat.length) {
            dateString = [dateString substringToIndex:dateFormat.length];
        }
        
        NSDate *date = [parser dateFromString:dateString];
        [demoRow.demoTimer setDate:date];
        [demoRow.demoTimer start];
    }
}

#pragma mark - Table Row Select
-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSDictionary *contextDic = @{@"PicName":_picName,@"index":[NSNumber numberWithInteger:_index]};
    [self presentControllerWithName:WKdemoDETAILCONTROLLERIDENTIFIER context:contextDic];
}

@end



