//
//  DraggableViewBackground.m
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import "DraggableViewBackground.h"

@implementation DraggableViewBackground{
    NSInteger cardsLoadedIndex;
    NSMutableArray *loadedCards;
    
 //   UIButton* menuButton;
 //   UIButton* messageButton;
    UIButton* checkButton;
    UIButton* xButton;
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
        [self setupSearchTextField];
        exampleCardLabels = [[NSArray alloc]initWithObjects:@"first",@"second",@"third",@"fourth",@"last", nil]; //%%% placeholder for card-specific information
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

    self.backgroundColor = [UIColor whiteColor];
/*
    CGFloat Button_HEIGHT = 0; //%%% height of the draggable card
    CGFloat Button_WIDTH = 0;
    
    CGFloat pad = 0, w_pad = 0, w_pad2 = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 432;
        w_pad = 60;
        w_pad2 = 200;
        Button_HEIGHT = 59; //%%% height of the draggable card
        Button_WIDTH = 59;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 515;
        w_pad = 80;
        w_pad2 = 210;
        Button_HEIGHT = 66; //%%% height of the draggable card
        Button_WIDTH = 66;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 565;
        w_pad = 85;
        w_pad2 = 225;
        Button_HEIGHT = 80; //%%% height of the draggable card
        Button_WIDTH = 80;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 358;
        w_pad = 80;
        w_pad2 = 180;
        Button_HEIGHT = 55; //%%% height of the draggable card
        Button_WIDTH = 55;
    }

    xButton = [[UIButton alloc]initWithFrame:CGRectMake(w_pad, pad, Button_HEIGHT, Button_WIDTH)];
    [xButton setImage:[UIImage imageNamed:@"xButton"] forState:UIControlStateNormal];
    [xButton addTarget:self action:@selector(swipeLeft) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [[UIButton alloc]initWithFrame:CGRectMake(w_pad2, pad, Button_HEIGHT, Button_WIDTH)];
    [checkButton setImage:[UIImage imageNamed:@"checkButton"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(swipeRight) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:xButton];
    [self addSubview:checkButton]; */
}

- (void)setupSearchTextField {
    self.searchTextField = [[UITextField alloc] init];
    [self addSubview:self.searchTextField];
    self.searchTextField.delegate = self;
    self.searchTextField.layer.cornerRadius = 7.0;
    self.searchTextField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchTextField invalidateIntrinsicContentSize];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat height = 0, width = 0, xpad = 0, ypad = 0;
    width = screen.size.width - 30;
    
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(32/2)];
        height = 40;
        xpad = 15;
        ypad = 8;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(38/2)];
        height = 42;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(62/3)];
        height = 45;
        xpad = 15;
        ypad = 10;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad])
    {
        self.searchTextField.font = [UIFont fontWithName:@"HelveticaNeue" size:ceilf(28/2)];
        height = 36;
        xpad = 15;
        ypad = 7;
    }
    
    self.searchTextField.backgroundColor = [self grayColor];
    self.searchTextField.placeholder = @"Find People";
    self.searchTextField.textAlignment = NSTextAlignmentCenter;
    self.searchTextField.textColor = [self lineColor];
    self.searchTextField.layer.shadowRadius = 0.01;
    self.searchTextField.layer.shadowOpacity = 0.01;
    
    self.searchTextField.layer.masksToBounds = NO;
    
  //    self.searchTextField.layer.shouldRasterize = YES;
 //   self.searchTextField.layer.borderColor = [UIColor grayColor].CGColor;
 //   self.searchTextField.layer.borderWidth = 1;
 //   self.searchTextField.layer.masksToBounds = true;
    
    NSMutableDictionary *viewsDictionary = [[NSMutableDictionary alloc] init];
    [viewsDictionary setObject:self.searchTextField forKey:@"textField"];
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-xpad-[textField]" options:0 metrics:@{@"xpad" : [NSNumber numberWithFloat:xpad], @"width" : [NSNumber numberWithFloat:width]} views:viewsDictionary];
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[textField(height)]" options:0 metrics:@{@"height" : [NSNumber numberWithFloat:height], @"pad" : [NSNumber numberWithFloat:ypad]} views:viewsDictionary];
    
    [self addConstraints:hConstraints];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.searchTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
    
    [self addConstraints:vConstraints];
    
}





// use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
// to get rid of it (eg: if you are building cards from data from the internet)
-(DraggableView *)createDraggableViewWithDataAtIndex:(NSInteger)index
{
    
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
        pad = 62;
        w_pad = 20;
        CARD_HEIGHT = 520;
        CARD_WIDTH = 340;

    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 70;
        w_pad = 20;
        CARD_HEIGHT = 550;
        CARD_WIDTH = 370;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 50;
        w_pad = 7;
        CARD_HEIGHT = 361;
        CARD_WIDTH = 305;
    }
    
    DraggableView *draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(w_pad, pad, CARD_WIDTH, CARD_HEIGHT)];
    
    
    
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
            DraggableView* newCard = [self createDraggableViewWithDataAtIndex:i];
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
}

#warning include own action here!
//%%% action called when the card goes to the right.
// This should be customized with your own action
-(void)cardSwipedRight:(UIView *)card
{
    //do whatever you want with the card that was swiped
    //    DraggableView *c = (DraggableView *)card;
    
    [loadedCards removeObjectAtIndex:0]; //%%% card was swiped, so it's no longer a "loaded card"
    
    if (cardsLoadedIndex < [allCards count]) { //%%% if we haven't reached the end of all cards, put another into the loaded cards
        [loadedCards addObject:[allCards objectAtIndex:cardsLoadedIndex]];
        cardsLoadedIndex++;//%%% loaded a card, so have to increment count
        [self insertSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-1)] belowSubview:[loadedCards objectAtIndex:(MAX_BUFFER_SIZE-2)]];
    }

}



//%%% when you hit the right button, this is called and substitutes the swipe
-(void)swipeRight
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeRight;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView rightClickAction];
}

//%%% when you hit the left button, this is called and substitutes the swipe
-(void)swipeLeft
{
    DraggableView *dragView = [loadedCards firstObject];
    dragView.overlayView.mode = GGOverlayViewModeLeft;
    [UIView animateWithDuration:0.2 animations:^{
        dragView.overlayView.alpha = 1;
    }];
    [dragView leftClickAction];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchTextField.placeholder = nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.searchTextField.placeholder = @"Find People";
    [self.searchTextField resignFirstResponder];
    [self.searchTextField endEditing:YES];

}

- (void)textFieldDidChange {
    //
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField setReturnKeyType:UIReturnKeyDone];
    return TRUE;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTextField resignFirstResponder];
    return YES;
}



- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event {
    NSArray *subviews = [self subviews];
    for (id objects in subviews) {
        if ([objects isKindOfClass:[UITextField class]]) {
            UITextField *theTextField = objects;
            if ([objects isFirstResponder]) {
                [theTextField resignFirstResponder];
            }
        }
    }
}



@end
