//
//  DeviceManager.h
//  portal
//
//  Created by Neil Ballard on 10/9/15.
//  Copyright © 2015 Neil_appworld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

@interface DeviceManager : NSObject

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
