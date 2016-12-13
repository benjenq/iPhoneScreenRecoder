//
//  appHelper.m
//  iPhoneScreenRecoder
//
//  Created by Administrator on 2016/12/14.
//
//

#import "appHelper.h"

@implementation appHelper

+ (BOOL)fileisExist:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath])
        return YES;
    else
        return NO;
}

+ (BOOL)copyfile:(NSString *)source toPath:(NSString *)destination{
    if (![self fileisExist:source]) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL success = [fileManager copyItemAtPath:source toPath:destination error:&error];
    if (error != nil) {
        NSLog(@"copyfile error:%@",[error description]);
        
    }
    return success;
}

+ (BOOL)removefile:(NSString *)filePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL success = NO;
    if ([fileManager fileExistsAtPath:filePath]){
        success = [fileManager removeItemAtPath:filePath error:&error];
    }
    if (error != nil) {
        NSLog(@"removefile error:%@",[error description]);
    }
    return success;
}


@end
