//
//  LinkedinFieldViewController.h
//  portal
//
//  Created by Neil Ballard on 10/29/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <linkedin-sdk/LISDK.h>
#import "DeviceManager.h"

@interface LinkedinFieldViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *networkTextField;

@property (strong, nonatomic) UILabel *networksLabel;


@end
