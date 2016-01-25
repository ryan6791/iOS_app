//
//  NSMutableData+AES.m
//
//  Created by Brian Merz on 9/29/15.
//  Copyright © 2015 Blackfeetpdx. All rights reserved.
//
#import "NSMutableData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "OAuthSecurity.h"

@implementation NSMutableData(AES)

- (NSMutableData*) encryptAES {
    NSString *key = [OAuthSecurity retrievePasswordSalt];
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF16StringEncoding];
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    NSMutableData *output = [[NSMutableData alloc] init];
    
    CCCryptorStatus result = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [self mutableBytes], [self length], buffer, bufferSize, &numBytesEncrypted);
    
    output = [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    
    if(result == kCCSuccess) {
        return output;
    }
    return NULL;
}

- (NSMutableData*)decryptAESforData:(NSMutableData*)objEncryptedData {
    NSString *key = [OAuthSecurity retrievePasswordSalt];
    char  keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF16StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer_decrypt = malloc(bufferSize);
    NSMutableData *output_decrypt = [[NSMutableData alloc] init];
    CCCryptorStatus result = CCCrypt(kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyPtr, kCCKeySizeAES256, NULL, [self mutableBytes], [self length], buffer_decrypt, bufferSize, &numBytesEncrypted);
    
    output_decrypt = [NSMutableData dataWithBytesNoCopy:buffer_decrypt length:numBytesEncrypted];
    
    if(result == kCCSuccess) {
        return output_decrypt;
    }
    return NULL;
}


@end