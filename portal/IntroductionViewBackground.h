//
//  IntroductionViewBackground.h
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionDraggableView.h"

@interface IntroductionViewBackground : UIView<IntroDraggableDelegate>


//methods called in DraggableView
-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;

@property (retain,nonatomic)NSArray* exampleCardLabels; //%%% the labels the cards
@property (retain,nonatomic)NSMutableArray* allCards; //%%% the labels the cards

@end
