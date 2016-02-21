//
//  PodSizeManager.m
//  Pods
//
//  Created by Neil Ballard on 2/17/16.
//
//

#import "PodSizeManager.h"

@interface PodSizeManager()
{
    BOOL isRetina;
    BOOL isZoomedScreen;    // for the 6 and 6+ screens,
    BOOL is4Screen;         // 4
    BOOL is5Screen;         // 5 or 6 zoomed
    BOOL is6Screen;         // 6 or 6+ zoomed
    BOOL is6PlusScreen;     // 6+
}
@end

@implementation PodSizeManager

+ (id)sharedInstance;
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        [sharedInstance setup];
    });
    
    return sharedInstance;
}

- (void)setup
{
    if ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 ){
        isRetina = YES;
    } else {
        isRetina = NO;
    }
    
    // prime the screen size
    CGRect r = [[UIScreen mainScreen] bounds];
    CGFloat s = [[UIScreen mainScreen] respondsToSelector:@selector(nativeScale)] ? [[UIScreen mainScreen] nativeScale] : 2.0;
    NSInteger biggest = r.size.width > r.size.height ? r.size.width : r.size.height;
    NSInteger smallest = r.size.width < r.size.height ? r.size.width : r.size.height;
    NSInteger scale = s * 100;
    
    if ( smallest == 320 )
    {
        if ( scale == 200 )
        {
            // 3.5 or 4 inch phone
            is5Screen =  ( biggest > 500 ) ? YES : NO;
            is4Screen = !is5Screen;
        }
        else if ( scale == 234) {
            // iPhone6 zoomed
            isZoomedScreen = YES;
            is6Screen = YES;
        }
    }
    else if ( smallest == 375 )
    {
        if ( scale == 288 )
        {
            // iPhone6+ Zoomed
            isZoomedScreen = YES;
            is6PlusScreen = YES;
        } else if ( scale == 200 ) {
            is6Screen = YES;             // iPhone6 Not Zoomed
        }
    }
    else if ( smallest == 414 ) {
        is6PlusScreen = YES;         // iPhone6+ Not Zoomed
    }
}

#pragma mark - Internals


- (BOOL)_getIsRetina
{
    return isRetina;
}

- (BOOL)_getIsZoomedScreen
{
    return isZoomedScreen;
}

- (BOOL)_getIs4Screen
{
    return is4Screen;
}

- (BOOL)_getIs5Screen
{
    return is5Screen;
}

- (BOOL)_getIs6Screen
{
    return is6Screen;
}

- (BOOL)_getIs6PlusScreen
{
    return is6PlusScreen;
}



#pragma mark - Device Type


- (BOOL)getIsIPad;
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

- (BOOL)getIsIPhone;
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}


#pragma mark - Device Attributes

- (BOOL)getIsRetina;
{
    return [[PodSizeManager sharedInstance] _getIsRetina];
}

- (BOOL)getIsZoomedScreen;
{
    return [[PodSizeManager sharedInstance] _getIsZoomedScreen];
}

- (BOOL)getIsNarrowPhoneScreen;
{
    return [[PodSizeManager sharedInstance] _getIs4Screen] | [[PodSizeManager sharedInstance] _getIs5Screen];
}

- (BOOL)getIsWidePhoneScreen;
{
    return ![self getIsNarrowPhoneScreen];
}

- (BOOL)getIsShortPhoneScreen;
{
    return [[PodSizeManager sharedInstance] _getIs4Screen];
}

- (BOOL)getIsTallPhoneScreen;
{
    return ![self getIsShortPhoneScreen];
}


#pragma mark - Screen Size


- (BOOL)getIsIPhone4Screen
{
    return [[PodSizeManager sharedInstance] _getIs4Screen];
}

- (BOOL)getIsIPhone5Screen
{
    return [[PodSizeManager sharedInstance] _getIs5Screen];
}

- (BOOL)getIsIPhone6Screen
{
    return [[PodSizeManager sharedInstance] _getIs6Screen];
}

- (BOOL)getIsIPhone6PlusScreen
{
    return [[PodSizeManager sharedInstance] _getIs6PlusScreen];
}

@end
