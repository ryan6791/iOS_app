//
//  SettingsTableViewCell.m
//  pairedUP
//
//  Created by Neil Ballard on 2/5/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

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
    
        [self setupSuperLabel];
        
    }
    return self;
}

- (void)setupSuperLabel {
    UIFont *font;
    
    CGFloat height = 0;
    
    self.superLabel = [[UILabel alloc] init];
    
    self.superLabel.font = [UIFont systemFontOfSize:5];
    height = 15;
    
    
    
    [self.superLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.superLabel invalidateIntrinsicContentSize];
    self.superLabel.font = font;
    self.superLabel.textColor = [UIColor blackColor];
    
    [self addSubview:self.superLabel];
    
    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:self.superLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:constraint1];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.superLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:constraint2];
    
    
}

@end
