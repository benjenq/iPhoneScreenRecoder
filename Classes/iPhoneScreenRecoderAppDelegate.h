//
//  iPhoneScreenRecoderAppDelegate.h
//  iPhoneScreenRecoder
//
//  Created by Administrator on 16/12/14.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPhoneScreenRecoderAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

