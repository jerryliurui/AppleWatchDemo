//
//  JRWKdemoStoreManager.m
//  demoBoard
//
//  Created by 刘瑞 on 15/1/21.
//  Copyright (c) 2015年 USTE.SSE, Inc. All rights reserved.
//

#import "JRWKdemoStoreManager.h"

static JRWKdemoStoreManager *instance;

@implementation JRWKdemoStoreManager
{
    NSMutableArray *_demoModules;
}

+ (JRWKdemoStoreManager *)shareManager
{
    if (!instance) {
        instance = [[JRWKdemoStoreManager alloc] init];
    }
    return instance;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        _demoModules = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (void)adddemoModule:(JRWKdemoModule *)demoModule
{
    [[self shareManager] adddemoModule:demoModule];
}

- (void)adddemoModule:(JRWKdemoModule *)demoModule
{
    if ([_demoModules indexOfObject:demoModule] == NSNotFound) {
        [_demoModules addObject:demoModule];
    }
}

+ (void)minusdemoModule:(JRWKdemoModule *)demoModule
{
    [[self shareManager] minusdemoModule:demoModule];
}

- (void)minusdemoModule:(JRWKdemoModule *)demoModule
{
    [_demoModules removeObject:demoModule];
}

+ (JRWKdemoModule *)demoModuleAtIndex:(NSInteger)index
{
    return [[self shareManager] demoModuleAtIndex:index];
}

- (JRWKdemoModule *)demoModuleAtIndex:(NSInteger)index
{
    if (index >= _demoModules.count) {
        return nil;
    }
    return [_demoModules objectAtIndex:index];
}

+ (NSInteger)demoModuleCount
{
    return [[self shareManager] demoModuleCount];
}

- (NSInteger)demoModuleCount
{
    return _demoModules.count;
}

+ (NSInteger)lookFordemoModuleBy: (NSString *)docID
{
    
    return [[self shareManager] lookFordemoModuleBy:docID];
}

- (NSInteger)lookFordemoModuleBy: (NSString *)docID
{
    NSInteger currentdemoModuleCount = [self demoModuleCount];
    for (int i = 0; i < currentdemoModuleCount; i++) {
        JRWKdemoModule *demoModule = _demoModules[i];
        if ([demoModule.someID isEqualToString:docID]) {
            return i;
        }
    }
    return -1;
}

@end
