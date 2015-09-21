//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <unistd.h>

// appearance
#import "HWSAppearanceTheme.h"

// combobox
#import "HWSBSKeyboardControls.h"
#import "HWSCombobox.h"

// details vc
#import "HWSDetailsViewController.h"
#import "HWSTGFoursquareDetail.h"
#import "HWSDetailLocationCell.h"
#import "HWSInfoLocationCell.h"
#import "HWSTipCell.h"

// user defaults
#import "HWSUserDefaults.h"

// localization
#import "HWSLocalization.h"

#import "HWSRevealViewController.h"

// search bar
#import "HWSSearchBar.h"

////////////////////////////////////////////////////////////////////////////////////////
//  GLOBAL KEYS
////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark GLOBAL KEYS

static NSString *const kwords              =        @"keywords";
static NSString *const kIconFileName       =        @"iconFileName";
//
static NSString *const kOfficeInstructions =        @"instructions";
static NSString *const kUrl                =        @"url";
static NSString *const kIsMedia            =        @"isMedia";
static NSString *const kAnswearingHours    =        @"answearing";
static NSString *const kVisit              =        @"visit";
//
static NSString *const kNurse              =        @"nurse";
static NSString *const kStation            =        @"station";
static NSString *const kEmail              =        @"email";
//
static NSString *const kShowInCategory     =        @"showInCategory";
static NSString *const kShowOnMap          =        @"showOnMap";
static NSString *const kIsShowInSearch     =        @"showInSearch";
static NSString *const kIsShowBubble       =        @"showBubble";
static NSString *const kIsAtZoomLevel      =        @"zoomLevel";
static NSString *const kMultiMedia         =        @"multiMedia";
//

static NSString *const kHead               =        @"head";
static NSString *const kGalleries          =        @"gallery";

#define kHeightForRowAtIndexPath    44.

////////////////////////////////////////////////////////////////////////////////////////
// Notification Keys
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Notification Keys

static NSString *const kLocalizationLanguageDidChangeNotification   = @"kLocalizationLanguageDidChangeNotification";


////////////////////////////////////////////////////////////////////////////////////////
// Macros
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Macros

#define LOCALIZATION(text) [HWSLocalization stringForKey:text]