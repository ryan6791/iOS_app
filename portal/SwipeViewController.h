//
//  SwipeViewController.h
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableViewBackground.h"
#import "DMPagerViewController.h"

@class DMPagerNavigationBarItem;


@interface SwipeViewController : UIViewController<DMPagerViewControllerProtocol>

@property (nonatomic, strong) UINavigationBar *navBar;
@property(nonatomic, strong) UINavigationController *navController;
@property (strong, nonatomic) UIWindow *window;


-(void) pushDetailView:(id)sender;


@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;
@property (strong, nonatomic) DMPagerNavigationBar	*pagerNav;


- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;

@end
