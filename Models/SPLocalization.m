//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "SPLocalization.h"
#import "Global.h"
#import "UserDefaults.h"

@interface SPLocalization ()

@property (nonatomic, retain) NSDictionary *strings;
@property (nonatomic, retain) NSString *defaultLanguage;

@end

@implementation SPLocalization {
    NSString * _language;
}

// Singleton
// Taken from http://lukeredpath.co.uk/blog/a-note-on-objective-c-singletons.html
+ (SPLocalization *)sharedInstance
{
    __strong static id _sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark -
#pragma mark Loading

- (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage
{
    self.strings = nil;

    NSData * JSONData = [NSData dataWithContentsOfFile:fileName];
    self.strings = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];

    self.defaultLanguage = defaultLanguage;
}

+ (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage
{
    [[self sharedInstance] loadFromJSONFile:fileName defaultLanguage:defaultLanguage];
}

#pragma mark -
#pragma mark Supported languages

- (NSArray *)supportedLanguages
{
    return self.strings.allKeys;
}

#pragma mark -
#pragma mark Language

- (void)setLanguage:(NSString *)language
{
    language = [[UserDefaults sharedDefaults] language];
    
    // Skip is the new setting is the same as the old one
    if (![language isEqual:_language]) {
        // Get rid of the current setting
        _language = nil;
        
        // Check if new setting is supported by localization
        if ([self.supportedLanguages indexOfObject:language] != NSNotFound) {
            _language = [language copy];
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocalizationLanguageDidChangeNotification
                                                                object:nil];
        }
    }
}

#pragma mark -
#pragma mark Strings

+ (BOOL)isRTL
{
    return ([[[UserDefaults sharedDefaults] language] isEqualToString:@"he"] || [[[UserDefaults sharedDefaults] language] isEqualToString:@"ar"]);
}

- (NSString *)stringForKey:(NSString *)key language:(NSString *)language
{
    NSDictionary * langugeStrings = self.strings[language];
    NSString * string = langugeStrings[key];
    return string;
}

- (NSString *)stringForKey:(NSString *)key
{
    return [self stringForKey:key language:[[UserDefaults sharedDefaults] language]];
}

+ (NSString *)stringForKey:(NSString *)key
{
    NSString* retString = [[SPLocalization sharedInstance] stringForKey:key];
    return (retString != nil)? retString : key;
}

+ (NSString *)stringForKey:(NSString *)key withPlaceholders:(NSDictionary *)placeholders
{
    return [[SPLocalization sharedInstance] stringForKey:key withPlaceholders:placeholders];
}

- (NSString *)stringForKey:(NSString *)localizationKey withPlaceholders:(NSDictionary *)placeholders
{
    __block NSString * result = [self stringForKey:localizationKey];
    [placeholders enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([key isKindOfClass:NSString.class] && [obj isKindOfClass:NSString.class]) {
            result = [result stringByReplacingOccurrencesOfString:key withString:obj];
        }
    }];
    
    return result;
}

@end
