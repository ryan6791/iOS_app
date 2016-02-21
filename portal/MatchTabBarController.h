//
//  MatchTabBarController.h
//  pairedUP
//
//  Created by Neil Ballard on 2/19/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPagerViewController.h"
#import "MessagesViewController.h"
#import "MatchProfileViewController.h"


@interface MatchTabBarController : UITabBarController<UITabBarControllerDelegate,DMPagerViewControllerProtocol>

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;

@property (strong, nonatomic) MatchProfileViewController *firstViewController;
@property (strong, nonatomic) MessagesViewController *secondViewController;

@end
