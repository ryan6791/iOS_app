//
//  NotificationLayover.m
//  pairedUP
//
//  Created by Neil Ballard on 1/20/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "NotificationLayover.h"

@implementation NotificationLayover


+ (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}


@end
