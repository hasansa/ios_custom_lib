//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "AppearanceTheme.h"
#import "CustomAppearanceTheme.h"

@implementation AppearanceTheme

+ (id <AppearanceThemeDelegate>)sharedTheme
{
    static id <AppearanceThemeDelegate> sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTheme = [[CustomAppearanceTheme alloc] init];
    });
    return sharedTheme;
}
+ (void)customizeAppAppearance
{
    id <AppearanceThemeDelegate> theme = [self sharedTheme];
    UIStatusBarStyle statusBarStyle = [theme statusBarStyle];
    if (statusBarStyle) {
//        [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:NO];
    }
    
    [[UIBarButtonItem appearance] setTintColor:[theme mainColor]];
    [[UINavigationBar appearance] setTintColor:[theme mainColor]];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    UINavigationBar * navigationBarAppearance = [UINavigationBar appearance];
    navigationBarAppearance.barTintColor = [theme secondColor];
    
//    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
//    [navigationBarAppearance setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsLandscapePhone] forBarMetrics:UIBarMetricsLandscapePhone];
    
    UIBarButtonItem * barButtonItemAppearance = [UIBarButtonItem appearance];
//
//    [barButtonItemAppearance setBackgroundImage:[theme barButtonBackgroundForState:UIControlStateNormal style:UIBarButtonItemStyleBordered barMetrics:UIBarMetricsDefault]
//                                       forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//
//    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsDefault]
//                                                 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
//    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault]
//                                                 forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//
//    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone]
//                                                 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
//
//    [barButtonItemAppearance setBackButtonBackgroundImage:[theme backBackgroundForState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone]
//                                                 forState:UIControlStateHighlighted barMetrics:UIBarMetricsLandscapePhone];
    
    UITabBar * tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setBackgroundImage:[theme tabBarBackground]];
    [tabBarAppearance setSelectionIndicatorImage:[theme tabBarSelectionIndicator]];
    [tabBarAppearance setTintColor:[theme tabbarTintColor]];
    
    UIToolbar * toolbarAppearance = [UIToolbar appearance];
    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsDefault] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
//    [toolbarAppearance setBackgroundImage:[theme toolbarBackgroundForBarMetrics:UIBarMetricsLandscapePhone] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsLandscapePhone];
    [toolbarAppearance setTintColor:[theme mainColor]];
    
    NSMutableDictionary * titleTextAttributesNav = [[NSMutableDictionary alloc] init];
    UIColor * navTextColor = [theme navigationTextColor];
    if (navTextColor) {
        titleTextAttributesNav[NSForegroundColorAttributeName] = navTextColor;
    }
    
    UIColor * navTextShadowColor = [theme navigationTextShadowColor];
    if (navTextShadowColor) {
        NSShadow * shadow = [[NSShadow alloc] init];
        shadow.shadowColor = navTextShadowColor;
        shadow.shadowOffset = [theme shadowOffset];
        titleTextAttributesNav[NSShadowAttributeName] = shadow;
    }
    UIFont * navTextFont = [theme navigationFont];
    if (navTextFont) {
        titleTextAttributesNav[NSFontAttributeName] = navTextFont;
    }
    
    [navigationBarAppearance setTitleTextAttributes:titleTextAttributesNav];
    
    NSMutableDictionary * titleTextAttributesBarButton = [titleTextAttributesNav mutableCopy];
    UIFont * barButtonTextFont = [theme barButtonFont];
    if (barButtonTextFont) {
        titleTextAttributesBarButton[NSFontAttributeName] = barButtonTextFont;
    }
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributesBarButton forState:UIControlStateNormal];
    
    NSMutableDictionary * titleTextAttributes = [[NSMutableDictionary alloc] init];
    UIColor * mainColor = [theme mainColor];
    if (mainColor) {
        titleTextAttributes[NSForegroundColorAttributeName] = mainColor;
    }
    
    UIColor * secondColor = [theme secondColor];
    if (secondColor) {
        titleTextAttributes[NSForegroundColorAttributeName] = secondColor;
    }
    UIColor * shadowColor = [theme shadowColor];
    if (shadowColor) {
        NSShadow * shadow = [[NSShadow alloc] init];
        shadow.shadowColor = shadowColor;
        shadow.shadowOffset = [theme shadowOffset];
        titleTextAttributes[NSShadowAttributeName] = shadow;
    }
    
    NSMutableDictionary * titleTextAttributesH = [[NSMutableDictionary alloc] init];
    UIColor * highlightShadowColor = [theme highlightShadowColor];
    if (highlightShadowColor) {
        NSShadow * shadow = [[NSShadow alloc] init];
        shadow.shadowColor = highlightShadowColor;
        shadow.shadowOffset = [theme shadowOffset];
        titleTextAttributesH[NSShadowAttributeName] = shadow;
    }
    
    UIColor * highlightColor = [theme highlightColor];
    if (highlightColor) {
        titleTextAttributesH[NSForegroundColorAttributeName] = highlightColor;
    }
    [barButtonItemAppearance setTitleTextAttributes:titleTextAttributesH forState:UIControlStateHighlighted];

//    UIColor * accentTintColor = [theme accentTintColor];
//    if (accentTintColor) {
//        UIBarButtonItem * toolbarBarButtonItemAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UIToolbar class], nil];
//        [toolbarBarButtonItemAppearance setTintColor:accentTintColor];
//    }
    
    UIColor * baseTintColor = [theme baseTintColor];
    if (baseTintColor) {
        [navigationBarAppearance setTintColor:baseTintColor];
        [barButtonItemAppearance setTintColor:baseTintColor];
        [toolbarAppearance setTintColor:baseTintColor];
    }
}
+ (void)customizeView:(UIView *)view
{
    id <AppearanceThemeDelegate> theme = [self sharedTheme];
    UIImage * backgroundImage = [theme viewBackground];
    UIColor * backgroundColor = [theme backgroundColor];
    if (backgroundImage) {
        [view setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    } else if (backgroundColor) {
        [view setBackgroundColor:backgroundColor];
    }
}
+ (void)customizeTableView:(UITableView *)tableView
{
    id <AppearanceThemeDelegate> theme = [self sharedTheme];
    UIImage * backgroundImage = [theme tableBackground];
    UIColor * backgroundColor = [theme backgroundColor];
    if (backgroundImage) {
        UIImageView * background = [[UIImageView alloc] initWithImage:backgroundImage];
        [tableView setBackgroundView:background];
    } else if (backgroundColor) {
        [tableView setBackgroundView:nil];
        [tableView setBackgroundColor:backgroundColor];
    }
}
+ (void)customizeTabBarItem:(UITabBarItem *)item
{
//    id <AppearanceThemeDelegate> theme = [self sharedTheme];
//    UIImage * image = [theme imageForTab:tab];
//    if (image) {
//        // If we have a regular image, set that
//        [item setImage:image];
//    }
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    
//    [item setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:0.58f green:0.58f blue:0.60f alpha:1.00f], NSForegroundColorAttributeName,
//      [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:12], NSFontAttributeName,
//      nil]
//                        forState:UIControlStateNormal];
//    [item setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor whiteColor], NSForegroundColorAttributeName,
//      [UIFont fontWithName:@"HelveticaNeueLTStd-Roman" size:12], NSFontAttributeName,
//      nil]
//                        forState:UIControlStateSelected];
}
+ (void)customizeNavigationBar:(UINavigationBar *)navigationBar
{
    id<AppearanceThemeDelegate> theme = [self sharedTheme];
    
    navigationBar.barTintColor = [theme secondColor];
//    [navigationBar setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setBackgroundImage:[theme navigationBackgroundForBarMetrics:UIBarMetricsLandscapePhone] forBarMetrics:UIBarMetricsLandscapePhone];
}
+ (void)customizeMainLabel:(UILabel *)label
{
    label.textColor = [[AppearanceTheme sharedTheme] mainColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
}
@end