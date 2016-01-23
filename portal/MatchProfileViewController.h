//
//  MatchProfileViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMPagerViewController.h"


@interface MatchProfileViewController : UIViewController<DMPagerViewControllerProtocol>

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextView *infoText;

@property (nonatomic, strong) UIView *divideLine;
@property (nonatomic, strong) UILabel *dumpLabel;
@property (nonatomic, strong) UILabel *reportLabel;


@property (nonatomic,strong) DMPagerNavigationBarItem	*pagerObj;

- (instancetype)initWithText:(NSString *) aText backgroundColor:(UIColor *) aBkgColor;

@end
