//
//  SwipeViewController.h
//  portal
//
//  Created by Neil Ballard on 12/13/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraggableViewBackground.h"


@interface SwipeViewController : UIViewController

@property (nonatomic, strong) UINavigationBar *navBar;

-(void) pushDetailView:(id)sender;


@end
