//
//  AccountTableViewCell.m
//  portal
//
//  Created by Neil Ballard on 11/1/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "AccountTableViewCell.h"
#import "DeviceManager.h"


@implementation AccountTableViewCell





//setting the frames of views within the cell
- (void)layoutSubviews
{
    [super layoutSubviews];

    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundView];
        
        
        [self addImage];
        [self setupLabel];
      //  [self setupSuperLabel];
        
    }
    return self;
}



- (void)addImage {
    
    self.pic = [[UIImageView alloc]initWithFrame:self.frame];
    
    self.pic.backgroundColor = [UIColor clearColor];
    self.pic.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pic invalidateIntrinsicContentSize];
    
    
    self.pic.layer.masksToBounds = YES;
    
    
    self.pic.alpha = 2.0;
    
    self.pic.userInteractionEnabled = YES;
    
    
    
    
    [self addSubview:self.pic];
    
    CGFloat pad = 0, height = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 3;
        height = 25;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 26;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 28;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 21;
    }
    
    
    
    
    
    NSDictionary *viewsDictionary = @{@"label" : self.pic};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[label]" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.pic attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.pic attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint4];
    
}


//if()
//something goes down




//bring out the next instance of social network


///if no network you can biring on


- (void)setupLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.Label = [[UILabel alloc] init];
    
    
    CGFloat pad = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 75;
        self.Label.font = [UIFont systemFontOfSize:16];

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 75;
        self.Label.font = [UIFont systemFontOfSize:17];


    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 75;
        self.Label.font = [UIFont systemFontOfSize:18];


    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 75;
        self.Label.font = [UIFont systemFontOfSize:15];
    }
    
    
    
    [self.Label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Label invalidateIntrinsicContentSize];
  //  self.Label.font = font;
    self.Label.textColor = [UIColor blackColor];
    
    [self addSubview:self.Label];
    
    NSDictionary *viewsDictionary = @{@"label" : self.Label};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[label]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    [self addConstraints:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.Label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:constraint2];
    
    
}

@end
