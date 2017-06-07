//
//  NSDictionary+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KMExtension)

/// dic to key-value style string, e.g @"key1=value1&key2=value2"
-(NSString*) km_urlEncodedKeyValueString;

/// dic to json style string
-(NSString*) km_jsonEncodedKeyValueString;

/// dic to plist style string
-(NSString*) km_plistEncodedKeyValueString;

@end
