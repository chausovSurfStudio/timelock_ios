//
//  NSDictionary+SafeGetStringValueByKey.h
//  okey
//
//  Created by Ольферук Александр on 08/10/15.
//  Copyright (c) 2015 SurfStudio. All rights reserved.
//

@interface NSDictionary (SafeGetters)

-(NSString *)safeGetStringByKey:(NSString *)key;
-(NSString *)safeGetStringByKey:(NSString *)key defaultValue:(NSString *)value;
-(NSArray *) safeGetArrayByKey: (NSString *)key;

-(NSDate *)safeGetDateFromStringByKey:(NSString *)key andDateFormat:(NSString *)dateFormat;

-(NSNumber *)safeGetDoubleNumberFromStringByKey:(NSString *)key;
-(NSNumber *)safeGetLongLongNumberFromStringByKey:(NSString *)key;

@end
