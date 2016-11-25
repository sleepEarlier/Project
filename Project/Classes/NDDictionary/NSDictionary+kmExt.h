//
//  NSDictionary+kmExt.h
//  Project
//
//  Created by kimiLin on 2016/11/25.
//  Copyright © 2016年 kimiLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (kmExt)
-(NSString*) km_urlEncodedKeyValueString;
-(NSString*) km_jsonEncodedKeyValueString;
-(NSString*) km_plistEncodedKeyValueString;
@end
