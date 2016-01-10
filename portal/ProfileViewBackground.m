//
//  ProfileViewBackground.m
//  portal
//
//  Created by Neil Ballard on 12/30/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "ProfileViewBackground.h"
#import "ProfileView.h"

@implementation ProfileViewBackground

-(ProfileView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    //  DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT)];
    
    CGFloat CARD_HEIGHT = 0; //%%% height of the draggable card
    CGFloat CARD_WIDTH = 0;
    
    CGFloat pad = 0, w_pad;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 60;
        w_pad = 7;
        CARD_HEIGHT = 426;
        CARD_WIDTH = 305;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 7;
        w_pad = 20;
        CARD_HEIGHT = 470;
        CARD_WIDTH = 330;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 9;
        w_pad = 20;
        CARD_HEIGHT = 525;
        CARD_WIDTH = 370;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 3;
        w_pad = 16;
        CARD_HEIGHT = 321;
        CARD_WIDTH = 285;
    }
    
    ProfileView *profileView = [[ProfileView alloc]initWithFrame:CGRectMake(w_pad, pad, CARD_WIDTH, CARD_HEIGHT)];

    return profileView;
}

-(UIColor*)grayColor{
    
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
}

-(UIColor*)titleColor{
    
    return [UIColor colorWithRed:0.20 green:0.80 blue:1.00 alpha:1.0];
}


-(UIColor*)backgroundColor{
    
    return [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    
}

//

-(UIColor*)lineColor{
    
    return [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    
    
}

@end
