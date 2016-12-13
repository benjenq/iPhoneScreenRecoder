//
//  appHelper.h
//  iPhoneScreenRecoder
//
//  Created by Administrator on 2016/12/14.
//
//

#import <Foundation/Foundation.h>

@interface appHelper : NSObject

+ (BOOL)fileisExist:(NSString *)filePath;
+ (BOOL)copyfile:(NSString *)source toPath:(NSString *)destination;
+ (BOOL)removefile:(NSString *)filePath;

@end
