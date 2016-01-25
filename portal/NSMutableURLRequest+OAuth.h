//
//  OAuthConsumerServices.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthToken.h"

@interface NSMutableURLRequest (OAuth)

- (BOOL)signRequestWithEmptyToken;
- (BOOL)signWithCurrentAccessToken;
- (BOOL)signRequestWithRequestToken:(OAuthToken*)token;

@end