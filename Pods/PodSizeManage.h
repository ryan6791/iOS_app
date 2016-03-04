//
//  PodSizeManage.h
//  Pods
//
//  Created by Neil Ballard on 3/1/16.
//
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"


@interface PodSizeManage : NSObject

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
