//
//  NSString+URLEncoding.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)

- (NSString *)utf8AndURLEncode;
+ (NSString *)getNonce;

@end
