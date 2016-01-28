//
//  BioInfoViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioInfoViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UILabel *userBioLabel;
@property (nonatomic, retain) UINavigationBar * navBar;
@property (strong, nonatomic) IBOutlet UITextField *bioTextField;


@end
