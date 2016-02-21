//
//  MatchProfileViewController.h
//  pairedUP
//
//  Created by Neil Ballard on 1/17/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MatchProfileViewController : UIViewController

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIView *picBackground;
@property (nonatomic, strong) UIView *picBackBackground;
@property (nonatomic, strong) UIImageView *pic;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UITextView *infoText;

@property (nonatomic, strong) UIView *divideLine;
@property (nonatomic, strong) UILabel *dumpLabel;
@property (nonatomic, strong) UILabel *reportLabel;

@property (nonatomic, strong) UIButton *buttonBackground1;
@property (nonatomic, strong) UIButton *buttonBackground2;



@end
