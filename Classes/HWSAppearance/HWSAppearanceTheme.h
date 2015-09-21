//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef enum  {
    ThemeTabSecure,
    ThemeTabDocs,
    ThemeTabBugs,
    ThemeTabBook,
    ThemeTabOptions
} ThemeTab;

@protocol HWSAppearanceThemeDelegate <NSObject>

- (UIStatusBarStyle)statusBarStyle;

- (UIColor *)mainColor;
- (UIColor *)secondColor;
- (UIColor *)navigationTextColor;
- (UIColor *)highlightColor;
- (UIColor *)shadowColor;
- (UIColor *)highlightShadowColor;
- (UIColor *)navigationTextShadowColor;
- (UIColor *)backgroundColor;
- (UIColor *)baseTintColor;
- (UIColor *)tabbarTintColor;
- (UIColor *)selectedTabbarItemTintColor;
- (UIColor *)segmentedTintColor;
//
- (UIFont *)navigationFont;
- (UIFont *)barButtonFont;
//
- (CGSize)shadowOffset;
- (UIImage *)navigationBackgroundForBarMetrics:(UIBarMetrics)metrics;
- (UIImage *)barButtonBackgroundForState:(UIControlState)state style:(UIBarButtonItemStyle)style barMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)backBackgroundForState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;
- (UIImage *)toolbarBackgroundForBarMetrics:(UIBarMetrics)metrics;
- (UIImage *)tableBackground;
- (UIImage *)tableSectionHeaderBackground;
- (UIImage *)tableFooterBackground;
- (UIImage *)viewBackground;
- (UIImage *)buttonBackgroundForState:(UIControlState)state;
- (UIImage *)tabBarBackground;
- (UIImage *)tabBarSelectionIndicator;
// One of these must return a non-nil image for each tab:
- (UIImage *)imageForTab:(ThemeTab)tab;
- (UIImage *)finishedImageForTab:(ThemeTab)tab selected:(BOOL)selected;


@end
@interface HWSAppearanceTheme : NSObject

+ (id <HWSAppearanceThemeDelegate>)sharedTheme;

+ (void)customizeAppAppearance;
+ (void)customizeView:(UIView *)view;
+ (void)customizeTableView:(UITableView *)tableView;
+ (void)customizeTabBarItem:(UITabBarItem *)item;
+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar;
+ (void)customizeMainLabel:(UILabel *)label;

@end
