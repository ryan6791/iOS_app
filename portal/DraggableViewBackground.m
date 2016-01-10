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
        [self setupSearchLabels];
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

-(void)setupSearchLabels{
    
    CGFloat height = 0;
    
    self.label123 = [[UILabel alloc] init];
    self.a = [[UILabel alloc] init];
    self.b = [[UILabel alloc] init];
    self.c = [[UILabel alloc] init];
    self.d = [[UILabel alloc] init];
    self.e = [[UILabel alloc] init];
    self.f = [[UILabel alloc] init];
    self.g = [[UILabel alloc] init];
    self.h = [[UILabel alloc] init];
    self.i = [[UILabel alloc] init];
    self.j = [[UILabel alloc] init];
    self.k = [[UILabel alloc] init];
    self.l = [[UILabel alloc] init];
    self.m = [[UILabel alloc] init];
    self.n = [[UILabel alloc] init];
    self.o = [[UILabel alloc] init];
    self.p = [[UILabel alloc] init];
    self.q = [[UILabel alloc] init];
    self.r = [[UILabel alloc] init];
    self.s = [[UILabel alloc] init];
    self.t = [[UILabel alloc] init];
    self.u = [[UILabel alloc] init];
    self.v = [[UILabel alloc] init];
    self.w = [[UILabel alloc] init];
    self.x = [[UILabel alloc] init];
    self.y = [[UILabel alloc] init];
    self.z = [[UILabel alloc] init];
    
    self.a.userInteractionEnabled = YES;
    self.b.userInteractionEnabled = YES;
    self.c.userInteractionEnabled = YES;
    self.d.userInteractionEnabled = YES;
    self.e.userInteractionEnabled = YES;
    self.f.userInteractionEnabled = YES;
    self.g.userInteractionEnabled = YES;
    self.h.userInteractionEnabled = YES;
    self.i.userInteractionEnabled = YES;
    self.j.userInteractionEnabled = YES;
    self.k.userInteractionEnabled = YES;
    self.l.userInteractionEnabled = YES;
    self.m.userInteractionEnabled = YES;
    self.n.userInteractionEnabled = YES;
    self.o.userInteractionEnabled = YES;
    self.p.userInteractionEnabled = YES;
    self.q.userInteractionEnabled = YES;
    self.r.userInteractionEnabled = YES;
    self.s.userInteractionEnabled = YES;
    self.t.userInteractionEnabled = YES;
    self.u.userInteractionEnabled = YES;
    self.v.userInteractionEnabled = YES;
    self.w.userInteractionEnabled = YES;
    self.x.userInteractionEnabled = YES;
    self.y.userInteractionEnabled = YES;
    self.z.userInteractionEnabled = YES;
    
    self.a.hidden = YES;
    self.b.hidden = YES;
    self.c.hidden = YES;
    self.d.hidden = YES;
    self.e.hidden = YES;
    self.f.hidden = YES;
    self.g.hidden = YES;
    self.h.hidden = YES;
    self.i.hidden = YES;
    self.j.hidden = YES;
    self.k.hidden = YES;
    self.l.hidden = YES;
    self.m.hidden = YES;
    self.n.hidden = YES;
    self.o.hidden = YES;
    self.p.hidden = YES;
    self.q.hidden = YES;
    self.r.hidden = YES;
    self.s.hidden = YES;
    self.t.hidden = YES;
    self.u.hidden = YES;
    self.v.hidden = YES;
    self.w.hidden = YES;
    self.x.hidden = YES;
    self.y.hidden = YES;
    self.z.hidden = YES;



    UITapGestureRecognizer *aTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(aPressed:)];
    
    UITapGestureRecognizer *bTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(bPressed:)];
    UITapGestureRecognizer *cTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cPressed:)];
    
    UITapGestureRecognizer *dTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(dPressed:)];
    
    UITapGestureRecognizer *eTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(ePressed:)];
    
    UITapGestureRecognizer *fTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(fPressed:)];
    
    UITapGestureRecognizer *gTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(gPressed:)];
    
    UITapGestureRecognizer *hTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hPressed:)];
    
    UITapGestureRecognizer *iTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(iPressed:)];
    
    UITapGestureRecognizer *jTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(jPressed:)];
    
    UITapGestureRecognizer *kTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(kPressed:)];
    UITapGestureRecognizer *lTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(lPressed:)];
    
    UITapGestureRecognizer *mTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(mPressed:)];
    
    UITapGestureRecognizer *nTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(nPressed:)];
    
    UITapGestureRecognizer *oTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(oPressed:)];
    
    UITapGestureRecognizer *pTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(pPressed:)];
    
    UITapGestureRecognizer *qTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(qPressed:)];
    
    UITapGestureRecognizer *rTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(rPressed:)];
    
    UITapGestureRecognizer *sTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(sPressed:)];
    
    UITapGestureRecognizer *tTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tPressed:)];
    
    UITapGestureRecognizer *uTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(uPressed:)];
    
    UITapGestureRecognizer *vTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(vPressed:)];
    
    UITapGestureRecognizer *wTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(wPressed:)];
    
    UITapGestureRecognizer *xTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(xPressed:)];
    
    UITapGestureRecognizer *yTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(yPressed:)];
    
    UITapGestureRecognizer *zTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(zPressed:)];
    
    [self.a addGestureRecognizer:aTap];
    [self.b addGestureRecognizer:bTap];
    [self.c addGestureRecognizer:cTap];
    [self.d addGestureRecognizer:dTap];
    [self.e addGestureRecognizer:eTap];
    [self.f addGestureRecognizer:fTap];
    [self.g addGestureRecognizer:gTap];
    [self.h addGestureRecognizer:hTap];
    [self.i addGestureRecognizer:iTap];
    [self.j addGestureRecognizer:jTap];
    [self.k addGestureRecognizer:kTap];
    [self.l addGestureRecognizer:lTap];
    [self.m addGestureRecognizer:mTap];
    [self.n addGestureRecognizer:nTap];
    [self.o addGestureRecognizer:oTap];
    [self.p addGestureRecognizer:pTap];
    [self.q addGestureRecognizer:qTap];
    [self.r addGestureRecognizer:rTap];
    [self.s addGestureRecognizer:sTap];
    [self.t addGestureRecognizer:tTap];
    [self.u addGestureRecognizer:uTap];
    [self.v addGestureRecognizer:vTap];
    [self.w addGestureRecognizer:wTap];
    [self.x addGestureRecognizer:xTap];
    [self.y addGestureRecognizer:yTap];
    [self.z addGestureRecognizer:zTap];


    
    
    
    
    height = 15;
    
    CGFloat pad = 0, font = 0;
    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 0;
        height = 180;
        font = 15;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 0;
        height = 180;
        font = 11;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 0;
        height = 180;
        font = 12;
        
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 0;
        height = 180;
        font = 9;
        
    }
    
    self.a.alpha = 100.0;
    self.b.alpha = 100.0;
    self.c.alpha = 100.0;
    self.d.alpha = 100.0;
    self.e.alpha = 100.0;
    self.f.alpha = 100.0;
    self.g.alpha = 100.0;
    self.h.alpha = 100.0;
    self.i.alpha = 100.0;
    self.j.alpha = 100.0;
    self.k.alpha = 100.0;
    self.l.alpha = 100.0;
    self.m.alpha = 100.0;
    self.n.alpha = 100.0;
    self.o.alpha = 100.0;
    self.p.alpha = 100.0;
    self.q.alpha = 100.0;
    self.r.alpha = 100.0;
    self.s.alpha = 100.0;
    self.t.alpha = 100.0;
    self.u.alpha = 100.0;
    self.v.alpha = 100.0;
    self.w.alpha = 100.0;
    self.x.alpha = 100.0;
    self.y.alpha = 100.0;
    self.z.alpha = 100.0;

    
    self.label123.font = [UIFont systemFontOfSize:font];
    self.a.font = [UIFont systemFontOfSize:font];
    self.b.font = [UIFont systemFontOfSize:font];
    self.c.font = [UIFont systemFontOfSize:font];
    self.d.font = [UIFont systemFontOfSize:font];
    self.e.font = [UIFont systemFontOfSize:font];
    self.f.font = [UIFont systemFontOfSize:font];
    self.g.font = [UIFont systemFontOfSize:font];
    self.h.font = [UIFont systemFontOfSize:font];
    self.i.font = [UIFont systemFontOfSize:font];
    self.j.font = [UIFont systemFontOfSize:font];
    self.k.font = [UIFont systemFontOfSize:font];
    self.l.font = [UIFont systemFontOfSize:font];
    self.m.font = [UIFont systemFontOfSize:font];
    self.n.font = [UIFont systemFontOfSize:font];
    self.o.font = [UIFont systemFontOfSize:font];
    self.p.font = [UIFont systemFontOfSize:font];
    self.q.font = [UIFont systemFontOfSize:font];
    self.r.font = [UIFont systemFontOfSize:font];
    self.s.font = [UIFont systemFontOfSize:font];
    self.t.font = [UIFont systemFontOfSize:font];
    self.u.font = [UIFont systemFontOfSize:font];
    self.v.font = [UIFont systemFontOfSize:font];
    self.w.font = [UIFont systemFontOfSize:font];
    self.x.font = [UIFont systemFontOfSize:font];
    self.y.font = [UIFont systemFontOfSize:font];
    self.z.font = [UIFont systemFontOfSize:font];
    
    
    
    [self.a setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.label123 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.b setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.c setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.d  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.e setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.f  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.g  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.h  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.i setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.j setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.k setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.l setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.m setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.n setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.o setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.p setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.q setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.r setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.s setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.t setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.u setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.v setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.w setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.x setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.y setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.z setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.label123 invalidateIntrinsicContentSize];
    [self.a invalidateIntrinsicContentSize];
    [self.b invalidateIntrinsicContentSize];
    [self.c invalidateIntrinsicContentSize];
    [self.d invalidateIntrinsicContentSize];
    [self.e invalidateIntrinsicContentSize];
    [self.f invalidateIntrinsicContentSize];
    [self.g invalidateIntrinsicContentSize];
    [self.h invalidateIntrinsicContentSize];
    [self.i invalidateIntrinsicContentSize];
    [self.j invalidateIntrinsicContentSize];
    [self.k invalidateIntrinsicContentSize];
    [self.l invalidateIntrinsicContentSize];
    [self.m invalidateIntrinsicContentSize];
    [self.n invalidateIntrinsicContentSize];
    [self.o invalidateIntrinsicContentSize];
    [self.p invalidateIntrinsicContentSize];
    [self.q invalidateIntrinsicContentSize];
    [self.r invalidateIntrinsicContentSize];
    [self.s invalidateIntrinsicContentSize];
    [self.t invalidateIntrinsicContentSize];
    [self.u invalidateIntrinsicContentSize];
    [self.v invalidateIntrinsicContentSize];
    [self.w invalidateIntrinsicContentSize];
    [self.x invalidateIntrinsicContentSize];
    [self.y invalidateIntrinsicContentSize];
    [self.z invalidateIntrinsicContentSize];



    self.label123.textColor = [UIColor lightGrayColor];
    self.a.textColor = [UIColor lightGrayColor];
    self.b.textColor = [UIColor lightGrayColor];
    self.c.textColor = [UIColor lightGrayColor];
    self.d.textColor = [UIColor lightGrayColor];
    self.e.textColor = [UIColor lightGrayColor];
    self.f.textColor = [UIColor lightGrayColor];
    self.g.textColor = [UIColor lightGrayColor];
    self.h.textColor = [UIColor lightGrayColor];
    self.i.textColor = [UIColor lightGrayColor];
    self.j.textColor = [UIColor lightGrayColor];
    self.k.textColor = [UIColor lightGrayColor];
    self.l.textColor = [UIColor lightGrayColor];
    self.m.textColor = [UIColor lightGrayColor];
    self.n.textColor = [UIColor lightGrayColor];
    self.o.textColor = [UIColor lightGrayColor];
    self.p.textColor = [UIColor lightGrayColor];
    self.q.textColor = [UIColor lightGrayColor];
    self.r.textColor = [UIColor lightGrayColor];
    self.s.textColor = [UIColor lightGrayColor];
    self.t.textColor = [UIColor lightGrayColor];
    self.u.textColor = [UIColor lightGrayColor];
    self.v.textColor = [UIColor lightGrayColor];
    self.w.textColor = [UIColor lightGrayColor];
    self.x.textColor = [UIColor lightGrayColor];
    self.y.textColor = [UIColor lightGrayColor];
    self.z.textColor = [UIColor lightGrayColor];
    
    self.label123.text = @"123";
    self.a.text = @"A";
    self.b.text = @"B";
    self.c.text = @"C";
    self.d.text = @"D";
    self.e.text = @"E";
    self.f.text = @"F";
    self.g.text = @"G";
    self.h.text = @"H";
    self.i.text = @"I";
    self.j.text = @"J";
    self.k.text = @"K";
    self.l.text = @"L";
    self.m.text = @"M";
    self.n.text = @"N";
    self.o.text = @"O";
    self.p.text = @"P";
    self.q.text = @"Q";
    self.r.text = @"R";
    self.s.text = @"S";
    self.t.text = @"T";
    self.u.text = @"U";
    self.v.text = @"V";
    self.w.text = @"W";
    self.x.text = @"X";
    self.y.text = @"Y";
    self.z.text = @"Z";
    
    [self addSubview:self.label123];
    [self addSubview:self.a];
    [self addSubview:self.b];
    [self addSubview:self.c];
    [self addSubview:self.d];
    [self addSubview:self.e];
    [self addSubview:self.f];
    [self addSubview:self.g];
    [self addSubview:self.h];
    [self addSubview:self.i];
    [self addSubview:self.j];
    [self addSubview:self.k];
    [self addSubview:self.l];
    [self addSubview:self.m];
    [self addSubview:self.n];
    [self addSubview:self.o];
    [self addSubview:self.p];
    [self addSubview:self.q];
    [self addSubview:self.r];
    [self addSubview:self.s];
    [self addSubview:self.t];
    [self addSubview:self.u];
    [self addSubview:self.v];
    [self addSubview:self.w];
    [self addSubview:self.x];
    [self addSubview:self.x];
    [self addSubview:self.y];
    [self addSubview:self.z];



    
    UIView *top = self;
    NSDictionary *viewsDictionary = @{@"top":top, @"label123" : self.label123, @"labela" : self.a, @"labelb" : self.b, @"labelc" : self.c, @"labeld" : self.d, @"labele" : self.e, @"labelf" : self.f, @"labelg" : self.g, @"labelh" : self.h, @"labeli" : self.i, @"labelj" : self.j, @"labelk" : self.k, @"labell" : self.l, @"labelm" : self.m, @"labeln" : self.n, @"labelo" : self.o, @"labelp" : self.p, @"labelq" : self.q, @"labelr" : self.r, @"labels" : self.s, @"labelt" : self.t, @"labelu" : self.u, @"labelv" : self.v, @"labelw" : self.w, @"labelx" : self.x, @"labely" : self.y, @"labelz" : self.z};
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labela]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint2];
    NSArray *constraint3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelb]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint3];
    NSArray *constraint4 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelc]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint4];
    NSArray *constraint5 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labeld]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint5];
    NSArray *constraint6 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labele]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint6];
    NSArray *constraint7 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelf]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint7];
    NSArray *constraint8 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelg]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint8];
    NSArray *constraint9 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelh]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint9];
    NSArray *constraint10 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labeli]-14-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint10];
    NSArray *constraint11 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelj]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint11];
    NSArray *constraint12 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelk]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint12];
    NSArray *constraint13 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labell]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint13];
    NSArray *constraint14 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelm]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint14];
    NSArray *constraint15 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labeln]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint15];
    NSArray *constraint16 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelo]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint16];
    NSArray *constraint17 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelp]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint17];
    NSArray *constraint18 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelq]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint18];
    NSArray *constraint19 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelr]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint19];
    NSArray *constraint20 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labels]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint20];
    NSArray *constraint21 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelt]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint21];
    NSArray *constraint22 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelu]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint22];
    NSArray *constraint23 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelv]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint23];
    NSArray *constraint24 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelw]-8-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint24];
    NSArray *constraint26 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelx]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint26];
    NSArray *constraint27 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labely]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint27];
    NSArray *constraint28 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[labelz]-10-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint28];
    NSArray *constraint25 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[labela]-0-[labelb]-0-[labelc]-0-[labeld]-0-[labele]-0-[labelf]-0-[labelg]-0-[labelh]-0-[labeli]-0-[labelj]-0-[labelk]-0-[labell]-0-[labelm]-0-[labeln]-0-[labelo]-0-[labelp]-0-[labelq]-0-[labelr]-0-[labels]-0-[labelt]-0-[labelu]-0-[labelv]-0-[labelw]-0-[labelx]-0-[labely]-0-[labelz]" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraint25];
    
    NSLayoutConstraint *constraint30 = [NSLayoutConstraint constraintWithItem:self.z attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10];
    [self addConstraint:constraint30];
    
    NSLayoutConstraint *constraint40 = [NSLayoutConstraint constraintWithItem:self.z attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:10];
    [self addConstraint:constraint40];
    
    
    
}

- (void)aPressed:(id)sender {
    
    
    NSLog(@"HIT");
    
    self.a.textColor = [UIColor blueColor];
    
    
    
    
}

- (void)zPressed:(id)sender {
    
    
    NSLog(@"HIT");
    
    self.a.textColor = [UIColor blueColor];
    
    
    
    
}

@end
