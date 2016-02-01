//
//  IntroductionViewBackground.m
//  pairedUP
//
//  Created by Neil Ballard on 1/31/16.
//  Copyright © 2016 Neil_appworld. All rights reserved.
//

#import "IntroductionViewBackground.h"

@implementation IntroductionViewBackground{
    NSInteger cardsLoadedIndex;
    NSMutableArray *loadedCards;
}

static const int MAX_BUFFER_SIZE = 2;

@synthesize exampleCardLabels;
@synthesize allCards;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [super layoutSubviews];
        [self setupView];
        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third", nil]; //%%% placeholder for card-specific information
        loadedCards = [[NSMutableArray alloc] init];
        allCards = [[NSMutableArray alloc] init];
        cardsLoadedIndex = 0;
        [self loadCards];
        self.userInteractionEnabled = YES;
    }
    return self;
}


-(void)setupView
{
    
    self.backgroundColor = [UIColor clearColor];

}


// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(IntroductionDraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    
    CGFloat CARD_HEIGHT = CGRectGetHeight([[UIScreen mainScreen] bounds]) - 10;
; //%%% height of the draggable card
    CGFloat CARD_WIDTH = CGRectGetWidth([[UIScreen mainScreen] bounds]) - 10;
    
    CGFloat pad = 0, w_pad;
    
    pad = 5;
    w_pad = 5;
    /*
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {


        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 42;
        w_pad = 20;

        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 50;
        w_pad = 20;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 30;
        w_pad = 7;
    }*/
    
    UIImage *image = nil;
    
    if(index == 0){
        image = [UIImage imageNamed:@"girl1"];
        
    }else if(index == 1){
        image = [UIImage imageNamed:@"girl2"];
        
        
    }else{
        image = [UIImage imageNamed:@"girl3"];
    }
    
    IntroductionDraggableView *draggableView = [[IntroductionDraggableView alloc]initWithFrame:CGRectMake(w_pad, pad, CARD_WIDTH, CARD_HEIGHT)];
    
    
    draggableView.delegate = self;
    return draggableView;
}

//%%% loads all the cards and puts the first x in the "loaded cards" array
-(void)loadCards
{
    if([exampleCardLabels count] > 0) {
        NSInteger numLoadedCardsCap =(([exampleCardLabels count] > MAX_BUFFER_SIZE)?MAX_BUFFER_SIZE:[exampleCardLabels count]);
        //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
        
        //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
        for (int i = 0; i<[exampleCardLabels count]; i++) {
            IntroductionDraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
            [allCards addObject:newCard];
            
            if (i<numLoadedCardsCap) {
                //%%% adds a small number of cards to be loaded
                [loadedCards addObject:newCard];
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (int i = 0; i<[loadedCards count]; i++) {
            if (i>0) {
                [self insertSubview:[loadedCards objectAtIndex:i] belowSubview:[loadedCards objectAtIndex:i-1]];
            } else {
                [self addSubview:[loadedCards objectAtIndex:i]];
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
}

#warning include own action here!
//%%% action called when the card goes to the left.
// This should be customized with your own action
-(void)cardSwipedLeft:(UIView *)card;
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    if ([loadedCards count] < 1) {
        NSNotification* notification = [NSNotification notificationWithName:@"dismissIntroView" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    }
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }
    
    if ([loadedCards count] < 1) {
        NSNotification* notification = [NSNotification notificationWithName:@"dismissIntroView" object:self];
        [[NSNotificationCenter defaultCenter] postNotification:notification];

    }
    
}



//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    IntroductionDraggableView *dragView = [loadedCards firstObject];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    IntroductionDraggableView *dragView = [loadedCards firstObject];
    [dragView leftClickAction];
}


- (void)DismissIntroView {
    
    NSNotification* notification = [NSNotification notificationWithName:@"DismissIntroView" object:self];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

@end
