//
//  SizeManager.h
//  Pods
//
//  Created by Neil Ballard on 1/16/16.
//
//

#import <Foundation/Foundation.h>

@interface SizeManager : NSObject

+ (id)sharedInstance;

- (BOOL)getIsIPhone4Screen;
- (BOOL)getIsIPhone5Screen;
- (BOOL)getIsIPhone6Screen;
- (BOOL)getIsIPhone6PlusScreen;
- (BOOL)getIsIPad;
- (BOOL)getIsIPhone;
- (BOOL)getIsRetina;
- (BOOL)getIsZoomedScreen;
- (BOOL)getIsNarrowPhoneScreen;
- (BOOL)getIsWidePhoneScreen;
- (BOOL)getIsShortPhoneScreen;
- (BOOL)getIsTallPhoneScreen;

@end
