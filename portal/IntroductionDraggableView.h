//
//  IntroductionDraggableView.h
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataAccess.h"
#import "DeviceManager.h"


@protocol IntroDraggableDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;


@end

@interface IntroductionDraggableView : UIView

@property (weak) id <IntroDraggableDelegate> delegate;



@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGPoint originalPoint;


@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UIView *pickbackground;
@property (strong, nonatomic) IBOutlet UIView *cellbackground;


-(void)leftClickAction;
-(void)rightClickAction;

@property (nonatomic, strong) UILabel *explainLabel;


+ (id)singletonInstance;
@end
