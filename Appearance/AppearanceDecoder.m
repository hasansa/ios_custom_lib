//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "AppearanceDecoder.h"
#define APPEARANCE_PLIST_DIRECTORY @"Appearance"

@implementation AppearanceDecoder

+ (instancetype)appearanceData;
{
    static AppearanceDecoder * _appearanceData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appearanceData = [[self alloc] initAppearanceData];
    });
    return _appearanceData;
}

- (id)initAppearanceData
{
    self = [super init];
    if (self) {
        
        NSString * appearanceFilePath = [[NSBundle mainBundle] pathForResource:APPEARANCE_PLIST_DIRECTORY ofType:@"plist"];
        NSDictionary * appearanceData = [NSDictionary dictionaryWithContentsOfFile:appearanceFilePath];
        
        _mainColor = [self decodeColorFromDictionary:appearanceData[@"mainColor"]];
        _secondColor = [self decodeColorFromDictionary:appearanceData[@"secondColor"]];
        _navigationTextColor = [self decodeColorFromDictionary:appearanceData[@"navigationTextColor"]];
        _highlightColor = [self decodeColorFromDictionary:appearanceData[@"highlightColor"]];
        _shadowColor = [self decodeColorFromDictionary:appearanceData[@"shadowColor"]];
        _highlightShadowColor = [self decodeColorFromDictionary:appearanceData[@"highlightShadowColor"]];
        _navigationTextShadowColor = [self decodeColorFromDictionary:appearanceData[@"navigationTextShadowColor"]];
        _backgroundColor = [self decodeColorFromDictionary:appearanceData[@"backgroundColor"]];
        _baseTintColor = [self decodeColorFromDictionary:appearanceData[@"baseTintColor"]];
        _tabbarTintColor = [self decodeColorFromDictionary:appearanceData[@"tabbarTintColor"]];
        _selectedTabbarItemTintColor = [self decodeColorFromDictionary:appearanceData[@"selectedTabbarItemTintColor"]];
        _segmentedTintColor = [self decodeColorFromDictionary:appearanceData[@"segmentedTintColor"]];
        //
        _navigationFont = appearanceData[@"navigationFont"];
        _barButtonFont = appearanceData[@"barButtonFont"];
        //
        _navigationBackground = appearanceData[@"navigationBackground"];
        _barButtonBackground = appearanceData[@"barButtonBackground"];
        _backBackground = appearanceData[@"backBackground"];
        _toolbarBackground = appearanceData[@"toolbarBackground"];
        _tableBackground = appearanceData[@"tableBackground"];
        _tableSectionHeaderBackground = appearanceData[@"tableSectionHeaderBackground"];
        _tableFooterBackground = appearanceData[@"tableFooterBackground"];
        _viewBackground = appearanceData[@"viewBackground"];
        _buttonBackground = appearanceData[@"buttonBackground"];
        _tabBarBackground = appearanceData[@"tabBarBackground"];
        _tabBarSelectionIndicator = appearanceData[@"tabBarSelectionIndicator"];
    }
    return self;
}

- (UIColor *)decodeColorFromDictionary:(NSDictionary *)aDictionary
{
    CGFloat red = [aDictionary[@"r"] floatValue] / 255.0;
    CGFloat green = [aDictionary[@"g"] floatValue] / 255.0;
    CGFloat blue = [aDictionary[@"b"] floatValue] / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
