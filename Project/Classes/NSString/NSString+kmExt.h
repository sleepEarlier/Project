//
//  NSString+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (kmExt)
- (NSString *) km_md5;
+ (NSString *) km_uniqueString;
- (NSString *) km_urlEncodedString;
- (NSString *) km_urlDecodedString;
- (id) km_JSONObject;
@end
