//
//  BioInfoViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/27/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BioInfoViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) UILabel *bioLabel;
@property (strong, nonatomic) UILabel *userBioLabel;
@property (nonatomic, retain) UINavigationBar * navBar;
@property (strong, nonatomic) UITextView *bioTextView;
@property (strong, nonatomic) UITextField *eduTextField;
@property (strong, nonatomic) UITextField *jobTextField;


@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *connectLabel;
@property (nonatomic, strong) UILabel *eduLabel;
@property (nonatomic, strong) UILabel *workLabel;


@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UIImageView *infoIcon;
@property (nonatomic, strong) UIImageView *educationIcon;
@property (nonatomic, strong) UIImageView *workIcon;

@end
