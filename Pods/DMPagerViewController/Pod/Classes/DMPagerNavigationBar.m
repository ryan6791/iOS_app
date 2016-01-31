//
//  DMPagerNavigationBar.m
//  Pager controller like the one in Twitter or Tinder
//
//  Created by Daniele Margutti (me@danielemargutti.com) on 11/01/15.
//  Copyright (c) 2015 http://www.danielemargutti.com All rights reserved.
//	Distribuited under MIT License http://opensource.org/licenses/MIT
//

#import "DMPagerNavigationBar.h"
#import "DMPagerViewController.h"

@interface DMPagerNavigationBarItem () { }

@property (nonatomic,readonly) DMPagerNavigationBar		*navigationBar;
@property (nonatomic,strong) UIImageView				*iconView;
@property (nonatomic,strong) UILabel					*titleLabel;

@end

@implementation DMPagerNavigationBarItem

+ (DMPagerNavigationBarItem *) newItemWithText:(NSAttributedString *) aTitle andIcon:(UIImage *) aIcon {
	DMPagerNavigationBarItem *item = [[DMPagerNavigationBarItem alloc] init];
	item.title = aTitle;
	item.icon = aIcon;
	[item layoutSubviews];
	return item;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		_iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_iconView.contentMode = UIViewContentModeCenter;
		_iconView.clipsToBounds = YES;
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_iconView.backgroundColor = [UIColor clearColor];
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.numberOfLines = 1;
		_titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
		[self addSubview:_iconView];
		[self addSubview:_titleLabel];
		
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (DMPagerNavigationBar *)navigationBar {
	return ((DMPagerNavigationBar*)self.superview);
}

- (void)setTitle:(NSAttributedString *)title {
	_title = title;
	_titleLabel.attributedText = title;
	[self layoutSubviews];
}

- (void)setIcon:(UIImage *)icon {
	_icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	_iconView.image = _icon;
	[self layoutSubviews];
}

- (void)setRenderingMode:(DMPagerNavigationBarItemMode)renderingMode {
    if (_renderingMode != renderingMode) return;
	_renderingMode = renderingMode;
	_iconView.hidden = !(_renderingMode == DMPagerNavigationBarItemModeOnlyImage || _renderingMode == DMPagerNavigationBarItemModeTextAndImage);
	_iconView.hidden = !(_renderingMode == DMPagerNavigationBarItemModeOnlyText || _renderingMode == DMPagerNavigationBarItemModeTextAndImage);
	[self layoutSubviews];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	CGSize navigationBarSize = self.frame.size;
	CGSize imageSize = _icon.size;
    
    CGSize titleSize = [_title boundingRectWithSize:CGSizeMake(navigationBarSize.width, navigationBarSize.height-imageSize.height-5.0f)
                                            options:NSStringDrawingTruncatesLastVisibleLine
                                            context:NULL].size;
    
  //  self.title_width = titleSize.width;
    
    DMPagerNavigationBar *item;
    


    
    if ((!self.didSet && [_titleLabel.text isEqualToString:@"POD"]) && titleSize.width > 0) {
        self.title_width = titleSize.width;
        self.didSet = YES;

    }
    

    CGRect imageRect = CGRectMake(((CGRectGetWidth(self.bounds)-imageSize.width)/2.0f),0,
                                  imageSize.width, imageSize.height);
    CGRect titleRect = CGRectMake(((CGRectGetWidth(self.bounds)-titleSize.width)/2.0f),
                                  CGRectGetMaxY(imageRect),
                                  titleSize.width,
                                  titleSize.height);

/*
	if (_renderingMode == DMPagerNavigationBarItemModeOnlyImage) {
		imageRect = CGRectMake(0.0f, 0.0f, imageRect.size.width, navigationBarSize.height);
		titleRect = CGRectZero;
	} else if (_renderingMode == DMPagerNavigationBarItemModeOnlyText) {
		imageRect = CGRectZero;
		titleRect = CGRectMake(0.0f, 0.0f, titleSize.width, navigationBarSize.height);
	} */
    

    
    if ([_titleLabel.text isEqualToString:@"POD"]) {
        imageRect = CGRectZero;
        titleRect = CGRectMake(0.0f, 0.0f, self.title_width, navigationBarSize.height);
        
        
        if (self.title_offset == 0.0) {
            self.title_offset = self.frame.origin.x;
        }
        
        self.frame = CGRectMake(self.title_offset,
                                self.frame.origin.y,
                                MAX(titleRect.size.width,imageRect.size.width),
                                self.frame.size.height);
        _titleLabel.frame = titleRect;
        _iconView.frame = imageRect;
    }
    else {
        imageRect = CGRectMake(0.0f, 0.0f, imageRect.size.width, navigationBarSize.height);
        titleRect = CGRectZero;
        
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                MAX(titleRect.size.width,imageRect.size.width),
                                self.frame.size.height);
        _titleLabel.frame = titleRect;
        _iconView.frame = imageRect;
    }
/*
	self.frame = CGRectMake(self.frame.origin.x,
							self.frame.origin.y,
							MAX(titleRect.size.width,imageRect.size.width),
							self.frame.size.height);
	_titleLabel.frame = titleRect;
	_iconView.frame = imageRect; */
}

@end


#pragma mark - DMPagerNavigationBar -

@interface DMPagerNavigationBar () { }
@property (nonatomic,weak) DMPagerViewController *controller;
@property (nonatomic,strong) DMPagerNavigationBarItem	*settingsIcon;

@end

@implementation DMPagerNavigationBar

- (instancetype) initWithController:(DMPagerViewController *) aController {
	CGRect frame;
	CGFloat statusBarHeight = (aController.isFullScreen ? [UIApplication sharedApplication].statusBarFrame.size.height : 0.0f);
	frame.origin.x = 0.0f;
	frame.origin.y = 0.0f;
	frame.size.width = CGRectGetWidth(aController.view.frame);
	frame.size.height = aController.navigationBarHeight+statusBarHeight+(kNavigationBarOffset*2);
	
	self = [super initWithFrame:frame];
	if (self) {
		_colorizeMode = DMPagerNavigationBarItemColorizeWithFade;
		_activeItemColor = [UIColor orangeColor];
		_inactiveItemColor = [UIColor darkGrayColor];
		
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor whiteColor];
		self.controller = aController;
	}
	return self;
}

- (void)setItems:(NSArray *)items {
	if ([_items isEqualToArray:items]) return;
	[_items makeObjectsPerformSelector:@selector(removeFromSuperview)];
	_items = items;
    
	
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

	for (NSUInteger idx = 0; idx < _items.count; ++idx) {
		// Frame
		DMPagerNavigationBarItem *cItem = _items[idx];
		CGRect cItemFrame = cItem.frame;
		cItemFrame.size.height = _controller.navigationBarHeight;
		[cItem layoutSubviews];
		
		cItemFrame.origin.x = (screenSize.width/2.0f)-(CGRectGetWidth(cItem.frame) + idx*100);
		cItemFrame.origin.y = statusBarHeight+kNavigationBarOffset;
		cItemFrame.size.width = CGRectGetWidth(cItem.frame);
		cItem.frame = cItemFrame;
		
		// Action
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnItem:)];
		[cItem addGestureRecognizer:tap];
		[cItem setUserInteractionEnabled:YES];
		
		[self addSubview:cItem];
	}
    
    
}

- (void)setInactiveItemColor:(UIColor *)inactiveItemColor {
	_inactiveItemColor = inactiveItemColor;
	[self layoutItems];
}

- (void)setActiveItemColor:(UIColor *)activeItemColor {
	_activeItemColor = activeItemColor;
	[self layoutItems];
}

-(void)tapOnItem:(UITapGestureRecognizer *)recognizer {
	DMPagerNavigationBarItem *item = (DMPagerNavigationBarItem *)recognizer.view;
	NSInteger idx = [self.subviews indexOfObject:recognizer.view];
	if (self.action) self.action(idx,item);
}

- (void) pagerScrollerDidScroll:(UIScrollView *) scrollView {
	[self layoutItems];
}

- (void) layoutItems {
	CGFloat xOffset = _controller.scrollView.contentOffset.x;
	int i = 0;
	CGSize screenSize = [[UIScreen mainScreen] bounds].size;
	CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

	for(DMPagerNavigationBarItem *v in self.subviews){
        if([v.titleLabel.text isEqualToString:@"settings"]){
            
        }else{
            CGFloat distance = 100 + self.style;
            CGSize vSize     = v.frame.size;
            CGFloat originX  = ((screenSize.width/2 - vSize.width/2) + i*distance) - xOffset/(screenSize.width/distance);
            v.frame          = (CGRect){originX, statusBarHeight, vSize.width, vSize.height};
		
            [self colorizeItem:v idx:i];
            i++;
        }
	}
}

-(void)addSettingsIcon{
    
    self.settingsIcon = [[DMPagerNavigationBarItem alloc] init];
    
    self.settingsIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.settingsIcon invalidateIntrinsicContentSize];
    
    
    self.settingsIcon.layer.masksToBounds = NO;
    self.settingsIcon.layer.shadowOffset = CGSizeMake(-.1, .2);
    self.settingsIcon.layer.shadowRadius = .5;
    self.settingsIcon.layer.shadowOpacity = 0.5;
    
    self.settingsIcon.userInteractionEnabled = YES;
    
    
    self.settingsIcon.iconView = [[UIImageView alloc] init];
    self.settingsIcon.iconView.contentMode = UIViewContentModeCenter;
    self.settingsIcon.iconView.clipsToBounds = YES;
    self.settingsIcon.iconView.image = [UIImage imageNamed:@"settings"];
    self.settingsIcon.icon = [UIImage imageNamed:@"settings"];
    self.settingsIcon.titleLabel.text = @"settings";
    
    [self.settingsIcon addSubview:self.settingsIcon.iconView];
    
    [self colorizeItem:self.settingsIcon idx:0];
    
    UITapGestureRecognizer *settingsTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goThere:)];
    [self.settingsIcon addGestureRecognizer:settingsTap];
    
    [self addSubview:self.settingsIcon];
    
    CGFloat pad = 20, pad2 = 32, height = 0;
    CGFloat width = 250;
/*    if([[DeviceManager sharedInstance] getIsIPhone5Screen])
    {
        pad = 6;
        height = 415;
        width = 292;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6Screen])
    {
        pad = 7;
        height= 505;
        width = 322;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone6PlusScreen])
    {
        pad = 8;
        height = 533;
        width = 350;
    }
    else if ([[DeviceManager sharedInstance] getIsIPhone4Screen] || [[DeviceManager sharedInstance] getIsIPad]) {
        pad = 5;
        height = 351;
        width = 292;
    } */
    
    
    
    NSDictionary *viewsDictionary = @{@"back":self.settingsIcon};
    NSArray *constraint1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad]} views:viewsDictionary];
    NSArray *constraint2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-pad-[back]" options:0 metrics:@{@"pad":[NSNumber numberWithFloat:pad2]} views:viewsDictionary];
    [self addConstraints:constraint1];
    [self addConstraints:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:self.settingsIcon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25];
    [self addConstraint:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:self.settingsIcon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25];
    [self addConstraint:constraint4];
    
}

- (void) colorizeItem:(DMPagerNavigationBarItem *) aItem idx:(NSInteger) aIdx {
	


    if(_controller.currentPage == 0){
        //show the settings button
        self.settingsIcon.hidden = NO;
        if ([aItem.titleLabel.text isEqualToString:@"DOP"]) {
            aItem.iconView.hidden = YES;
            [self switchToText:aItem];
            
        }

    }else{
        //hide the settings button
        self.settingsIcon.hidden = YES;
        if ([aItem.titleLabel.text isEqualToString:@"POD"]) {
            [self switchToImage:aItem];
            aItem.iconView.hidden = NO;
        }
    }
    
    if (!_activeItemColor || !_inactiveItemColor)
		return;
	
	if (_colorizeMode == DMPagerNavigationBarItemColorizeWithFade && _activeItemColor) {
		CGRect itemFrame = aItem.frame;
		
		UIColor *color = _inactiveItemColor;
		if(CGRectGetMinX(itemFrame) > 45.0f && CGRectGetMinX(itemFrame)  < 145.0f) // Left part
			color = [self iconWithGradient: CGRectGetMinX(itemFrame)
									   top: 46.0f
									bottom: 144.0f
									  init: _activeItemColor
									  goal: _inactiveItemColor];
		else if(CGRectGetMinX(itemFrame) > 145.0f && CGRectGetMinX(itemFrame) < 245.0f) // Right part
			color = [self iconWithGradient: CGRectGetMinX(itemFrame)
									   top: 146.0f
									bottom: 244.0f
									  init: _inactiveItemColor
									  goal: _activeItemColor];
		else if(CGRectGetMinX(itemFrame) == 145.0f)
			color = _activeItemColor;
		
		aItem.titleLabel.textColor = color;
		aItem.iconView.tintColor = color;
	} else if (_colorizeMode == DMPagerNavigationBarItemColorizeSolid) {
		NSInteger currentPage = _controller.currentPage;
      //  if (currentPage == 1) {
      //  }
		aItem.titleLabel.textColor = (currentPage == aIdx ? _activeItemColor : _inactiveItemColor);
		aItem.iconView.tintColor = aItem.titleLabel.textColor;
	}
}

-(UIColor *) iconWithGradient:(double)percent top:(double)topX bottom:(double)bottomX init:(UIColor*)init goal:(UIColor*)goal{
	double t = (percent - bottomX) / (topX - bottomX);
	
	t = MAX(0.0, MIN(t, 1.0));
	
	const CGFloat *cgInit = CGColorGetComponents(init.CGColor);
	const CGFloat *cgGoal = CGColorGetComponents(goal.CGColor);
	
	double r = cgInit[0] + t * (cgGoal[0] - cgInit[0]);
	double g = cgInit[1] + t * (cgGoal[1] - cgInit[1]);
	double b = cgInit[2] + t * (cgGoal[2] - cgInit[2]);
	
	return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void)switchToText:(DMPagerNavigationBarItem *) aItem{
    
    
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Superclarendon-Regular" size:21.0],
                                      NSForegroundColorAttributeName : [self navColor]};
    
    aItem.title = [[NSAttributedString alloc] initWithString:@"POD" attributes:textAttributes];
    aItem.icon = [UIImage imageNamed:@"logo"];

 /*
    aItem.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    aItem.iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    aItem.iconView.image = [UIImage imageNamed:@"logo"];
    aItem.iconView.contentMode = UIViewContentModeCenter;
    aItem.iconView.clipsToBounds = YES;
    aItem.titleLabel.text = @"POD";
    aItem.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    aItem.iconView.backgroundColor = [UIColor clearColor];
    aItem.titleLabel.backgroundColor = [UIColor clearColor];
    aItem.titleLabel.numberOfLines = 1;
    aItem.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:aItem.iconView];
    [self addSubview:aItem.titleLabel];
   */
    
    [aItem layoutSubviews];
    
}

-(void)switchToImage:(DMPagerNavigationBarItem *) aItem{
    
    NSDictionary *textAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Superclarendon-Regular" size:21.0],
                                      NSForegroundColorAttributeName : [self navColor]};
    
    aItem.title = [[NSAttributedString alloc] initWithString:@"DOP" attributes:textAttributes];
    aItem.icon = [UIImage imageNamed:@"logo"];
/*
    aItem.renderingMode = DMPagerNavigationBarItemModeOnlyText;
    
    aItem.iconView = [[UIImageView alloc] initWithFrame:CGRectZero];
    aItem.iconView.image = [UIImage imageNamed:@"logo"];
    aItem.iconView.contentMode = UIViewContentModeCenter;
    aItem.iconView.clipsToBounds = YES;
    aItem.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    aItem.titleLabel.text = @"DOP";
    aItem.iconView.backgroundColor = [UIColor clearColor];
    aItem.titleLabel.backgroundColor = [UIColor clearColor];
    aItem.titleLabel.numberOfLines = 1;
    aItem.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:aItem.iconView];
    [self addSubview:aItem.titleLabel];  */
    
    [aItem layoutSubviews];

}

- (void)goThere:(id)sender {
    
   NSNotification* notification = [NSNotification notificationWithName:@"pushSettings" object:self];
  [[NSNotificationCenter defaultCenter] postNotification:notification];

}

-(UIColor*)navColor{
    
    return [UIColor colorWithRed:0.0 green:172.0f/255.0f blue:237.0f/255.0f alpha:1.0];
}

@end
