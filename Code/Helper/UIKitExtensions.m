//
//  UIKitExtensions.m
//  iPhoneScreenRecoder
//
//  Created by Administrator on 2016/12/14.
//
//

#import "UIKitExtensions.h"

@implementation UIApplication (beExtensions)

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
#endif

+ (NSString *)GetBundlePath{
    return [[NSBundle mainBundle] bundlePath];
}

+ (NSString *)GetDocumentPath{
    return [NSString stringWithFormat:@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0]];
}
+ (NSString *)GetCachePath{
    return [NSString stringWithFormat:@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0]];
}
+ (NSString *)GettmpPath{
    return [NSString stringWithFormat:@"%@",NSTemporaryDirectory()];
}

@end
