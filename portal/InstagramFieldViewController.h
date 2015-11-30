//
//  InstagramFieldViewController.h
//  portal
//
//  Created by Neil Ballard on 10/20/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceManager.h"
#import "DataAccess.h"

@interface InstagramFieldViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *networkTextField;

@property (strong, nonatomic) UILabel *networksLabel;



@end
