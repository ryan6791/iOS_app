//
//  UserAccountTableViewCell.m
//  portal
//
//  Created by Neil Ballard on 11/16/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "UserAccountTableViewCell.h"
#import "DeviceManager.h"

@implementation UserAccountTableViewCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(20,5,34,34);
    
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.backgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundView];

        
    //    [self addImage];
        [self setupLabel];
        
    }
    return self;
}


- (void)setupLabel {
    
    CGFloat height = 0;
    
    self.Label = [[UILabel alloc] init];
    
   // self.Label.font = [UIFont systemFontOfSize:5];
    self.Label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];

    height = 15;
    
    
    
    [self.Label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.Label invalidateIntrinsicContentSize];
    self.Label.textColor = [UIColor blackColor];
    
    [self addSubview:self.Label];
    
    NSDictionary *viewsDictionary = @{@"label" : self.Label};
 //   NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[label]" options:0 metrics:nil views:viewsDictionary];
        NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.Label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.Label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:constraint2];

    
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
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 30;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 33;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 30;
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


-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(UIColor*)redishColor{
    return [UIColor colorWithRed:225.0f/255.0f green:117.0f/255.0f blue:117.0f/255.0f alpha:1.0];
}


@end
