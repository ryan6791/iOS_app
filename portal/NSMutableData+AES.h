//
//  NSMutableData+AES.h
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData(AES)
- (NSMutableData*)encryptAES;
- (NSMutableData*)decryptAESforData:(NSMutableData*)objEncryptedData;
@end