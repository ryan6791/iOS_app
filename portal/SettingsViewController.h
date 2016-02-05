//
//  SettingsViewController.h
//  portal
//
//  Created by Neil Ballard on 11/28/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CERangeSlider.h"
#import "DistanceRangeSlider.h"
#import "SettingsTableViewCell.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface SettingsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *distanceLabel;
@property (strong, nonatomic) UILabel *invisibleLabel;
@property (strong, nonatomic) UILabel *notificationsLabel;


@property (strong, nonatomic) UISwitch *invisibleSwitch;
@property (strong, nonatomic) UISwitch *notificationsSwitch;


@property (strong, nonatomic) UILabel *networksLabel;



@end
