//
//  HomeTableViewCell.h
//  portal
//
//  Created by Neil Ballard on 11/22/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <linkedin-sdk/LISDK.h>


@interface HomeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;

@property (nonatomic, strong) NSString *linkedinId;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *instagram;
@property (nonatomic, strong) NSString *snapchat;

@property (strong, nonatomic) IBOutlet UIView *socialbackground;
@property (strong, nonatomic) IBOutlet UIView *snapchatbackground;
@property (strong, nonatomic) IBOutlet UITextView *snapchatlabel;




@property (strong, nonatomic) IBOutlet UIButton *facebookIcon;
@property (strong, nonatomic) IBOutlet UIButton *instagramIcon;
@property (strong, nonatomic) IBOutlet UIButton *linkedinIcon;
@property (strong, nonatomic) IBOutlet UIButton *snapchatIcon;




@end
