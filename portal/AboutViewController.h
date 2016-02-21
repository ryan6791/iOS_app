//
//  AboutViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 2/19/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (nonatomic, strong) UILabel *nameLabel;
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

@property (nonatomic, strong) UIView *Line;

@end
