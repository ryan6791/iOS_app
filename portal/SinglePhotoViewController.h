//
//  SinglePhotoViewController.h
//  portal
//
//  Created by Neil Ballard on 10/17/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinglePhotoViewController : UIViewController

@property (nonatomic, strong) UIImage *photo;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
+ (id)singletonInstance;



@end
