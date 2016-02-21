//
//  AccountViewController.h
//  portal
//
//  Created by Neil Ballard on 10/10/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *networkBox;
@property (strong, nonatomic) IBOutlet UILabel *userBioLabel;

@property (nonatomic, strong) UIView *editIcon;
@property (nonatomic, strong) UILabel *editLabel;
@property (nonatomic, strong) UIImageView *editPencil;




@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *locationTextLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UITextView *infoTextLabel;
@property (nonatomic, strong) UILabel *connectLabel;
@property (nonatomic, strong) UILabel *eduLabel;
@property (nonatomic, strong) UILabel *eduTextLabel;
@property (nonatomic, strong) UILabel *workLabel;
@property (nonatomic, strong) UILabel *workTextLabel;

@property (nonatomic, strong) UIImageView *photoIcon;
@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UIImageView *infoIcon;
@property (nonatomic, strong) UIImageView *educationIcon;
@property (nonatomic, strong) UIImageView *workIcon;


@end
