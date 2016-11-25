//
//  NSString+kmExt.m
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import "NSString+kmExt.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (kmExt)
- (NSString *) km_md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString*) km_uniqueString
{
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);
    NSString	*uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

- (NSString*) km_urlEncodedString {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "];
    return [self stringByAddingPercentEncodingWithAllowedCharacters:set];
}

- (NSString*) km_urlDecodedString {
    return [self stringByRemovingPercentEncoding];
}

- (id)km_JSONObject {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) return nil;
    NSError *error = nil;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return error?nil:json;
}

@end
