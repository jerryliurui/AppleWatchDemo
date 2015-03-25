//
//  NTESNBWKdemoRow.h
//  demoBoard
//
//  Created by 刘瑞 on 15/2/5.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//

@import WatchKit;

@interface JRWKdemoRow : NSObject

//已经发生了多久
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *demoTimer;
//图片
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *demoImage;
//标题
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *demoTitle;
//类别
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *demoCategory;
//跟帖数
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *demoCommentsCount;

@end
