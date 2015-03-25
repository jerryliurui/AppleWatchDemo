//
//  JRWKdemoStoreManager.h
//  demoBoard
//
//  Created by 刘瑞 on 15/1/21.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//  这个类用来管理apple watch获取到的一个模型数组

#import <Foundation/Foundation.h>
#import "JRWKdemoModule.h"

@interface JRWKdemoStoreManager : NSObject

//增加demomodel方法
+ (void)adddemoModule:(JRWKdemoModule *)demoModule;

//删除demomodel方法
+ (void)minusdemoModule:(JRWKdemoModule *)demoModule;

//返回指定索引的demomodule
+ (JRWKdemoModule *)demoModuleAtIndex:(NSInteger)index;

//返回当前一共有多少个demoModule
+ (NSInteger)demoModuleCount;

//根据docId 来判断是否在当前demomodule的数组中
+ (NSInteger)lookFordemoModuleBy: (NSString *)docID;

@end
