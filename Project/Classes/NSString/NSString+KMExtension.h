//
//  NSString+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KMExtension)

/// MD5 Encoded String
- (NSString *) km_md5;

/// UUID String
+ (NSString *) km_uniqueString;

/// URL Encoded String
- (NSString *) km_urlEncodedString;

/// URL Decoded String
- (NSString *) km_urlDecodedString;

/// Json str to Json obj
- (id) km_JSONObject;

/// full string range
- (NSRange)km_range;

@end
