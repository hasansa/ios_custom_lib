//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPLocalization : NSObject

@property (nonatomic, copy) NSString * language;
@property (nonatomic, readonly) NSArray * supportedLanguages;
@property (nonatomic, readonly) NSString * systemLanguage;

+ (NSString *)stringForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key withPlaceholders:(NSDictionary *)placeholders;
+ (SPLocalization *)sharedInstance;
+ (BOOL)isRTL;
+ (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage;

@end