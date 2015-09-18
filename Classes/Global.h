//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <unistd.h>

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

#define ICONS_IMAGES_DIRECTORY      @"Images/MapIcons"

#define BASE_URL                    @"https://developer.spreo.co/middle/ios/"
#define LOCATION_SHARING_URL        @"LocationSharingServlet?"

#define MULTI_USERS_FILE_NAME       @"spreo_users_setting.json"

#define HOME_JSON_FILE_NAME         @"homeactions.json"
#define BANNERS_JSON_FILE_NAME      @"banners.json"

#define ADMIN_PASS                  @"spreodev"

#define kParkingId                   @"myCarPark"

#define kLocationSharing            @"location sharing"

#define IPHONE_4S                   4.1

#define KBannerTimerDuration        7.0     // sec
#define KMinSecondsBetweenBanners   30.0    // sec

#define ENTRANCE_POI_IDINTIFIER         @"idr"
#define PARKING_POI_IDINTIFIER          @"idr_parking_poi"
#define SWITCH_FLOOR_POI_IDINTIFIER     @"switch_floor_poi"


#define USER_ALERT_TAG                   19891182
#define PROJECTS_ALERT_TAG          77854331
////////////////////////////////////////////////////////////////////////////////////////
// Notification Keys
////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Notification Keys

static NSString *const kLocalizationLanguageDidChangeNotification   = @"kLocalizationLanguageDidChangeNotification";
static NSString *const kFollowTheHighlightedPath                    = @"Follow the highlighted path to";

#pragma mark -
#pragma mark Macros
////////////////////////////////////////////////////////////////////////////////////////

#define LOCALIZATION(text) [SPLocalization stringForKey:text]

#define kDetailsIconUrlByAppendName(name) [NSString stringWithFormat:@"%@res/%@/%@/homeicons/%@", BASE_URL, [[UserDefaults sharedDefaults] projectID], kCampusId, name]

#define kBannersIconUrlByAppendName(name) [NSString stringWithFormat:@"%@res/%@/%@/%@/spreo_banners/%@", BASE_URL, [[UserDefaults sharedDefaults] projectID], kCampusId, kFacilityId ,name]

#define API_KEY     [[UserDefaults sharedDefaults] kAppApiKey]

#define kCampusId   [[[CMSDataAdapter sharedAdapter] getAllCampuses] firstObject]

#define kFacilityId [[[CMSDataAdapter sharedAdapter] getAllFacilitiesAtCampusId:kCampusId] firstObject]


#pragma mark -
#pragma mark API KEYS
////////////////////////////////////////////////////////////////////////////////////////
// DEFENITIONS
////////////////////////////////////////////////////////////////////////////////////////

//#define TEST
//#define USE_SEARCH_RIGHT_MENU
//#define LOCK_INDOOR_MAP
//

//#define SSH_PRODUCTION
//#define SSH_STAGING
//#define SSH_TESTING
//#define SSH_NEW
//#define SAJ_STAGING
//
//#define UTC_PRODUCTION
//#define UTC_STAGING
//#define UTC_RELEASE
//
//#define TVO_PRODUCTION
//#define TVO_STAGING
//#define TVO_TRAINING
//
//#define DOLPHIN
//#define DOLPHIN_SPANISH_TESTING

//#define CARMEL_TESTING
//#define CARMEL_SRG
//#define CARMEL_DEMO
//
#define ASURE
//
//#define DUBAI_WTC_STAGING
//#define DUBAI_WTC_TESTING
//
//#define OFFICE_DEBUG
//
//#define NIH
//
//#define ENGLEWOOD_PRODUCTION
//#define ENGLEWOOD_STAGING
//#define ENGLEWOOD_DEMO



////////////////////////////////////////////////////////////////////////////////////////
// APP_API_KEYS, URLS AND Campus + Facility Identifiers
////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark TEST API KEY
#ifdef TEST

#define APP_API_KEY @"lcnctx5070c7e0747d11e482f80800200c9a66"
#define APP_URL @"http://www.shopshorthills.com"

static NSString *  const kCampusId    = @"location_context_campus";
static NSString *  const kFacilityId  = @"location_context_facility";

#endif // TEST

#pragma mark -
#pragma mark SSH API KEY
#if (defined(SSH_STAGING) || defined(SSH_TESTING) || defined(SSH_PRODUCTION) || defined(SSH_NEW) || defined(SAJ_STAGING))

#ifdef SSH_PRODUCTION
#define APP_API_KEY @"2ab41240fb7011e3a3ac0800200c9a66"
#endif // SSH_PRODUCTION

#ifdef SSH_STAGING
#define APP_API_KEY @"4ddd591f952542e89b15bb95c6cfe5d814303746389351532816706"//@"0256a977f2304757aafb2cdc2cddbbda"
#endif // SSH_STAGING

#ifdef SSH_TESTING
#define APP_API_KEY @"50bd377688974a6e9cac07716c50aca01424697362112258417499"
#endif // SSH_TESTING

#ifdef SSH_NEW
#define APP_API_KEY @"mb5a530a0b158845fc929615548506194b"
#endif // SSH_NEW

#ifdef SAJ_STAGING
#define APP_API_KEY @"aa5046a1d1e8461bb1d4845fddc4ad431427791380532436862197"
#endif // SAJ

#define APP_URL @"http://www.shopshorthills.com"

#endif // (defined (SSH_STAGING) || defined (SSH_TESTING))


#pragma mark -
#pragma mark UTC API KEY
#if (defined (UTC_STAGING) || defined (UTC_RELEASE) ||defined (UTC_PRODUCTION))

#ifdef UTC_PRODUCTION
#define APP_API_KEY     @"mb5557d09d7dfc44d8a1114b28fba66293"
#endif // UTC_PRODUCTION

#ifdef UTC_STAGING
#define APP_API_KEY @"mxmutcstg7a4e925d9cfb41169e156d51f54dfed8"
#endif // UTC_STAGING

#ifdef UTC_RELEASE
#define APP_API_KEY @"38ba9b22fe72466f8499d36a04fa99091426755472758487082622"
#endif // UTC_RELEASE

#define APP_URL @"http://www.mallatutc.com"

#endif // (defined (UTC_STAGING) || defined (UTC_RELEASE) ||defined (UTC_PRODUCTION))

#pragma mark -
#pragma mark TVO API KEY
#if (defined (TVO_STAGING) || defined (TVO_TRAINING) ||defined (TVO_PRODUCTION))

#ifdef UTC_PRODUCTION
#define APP_API_KEY     @"7e3fb25ca93845a39dbbb3deffbe2893"
#endif // UTC_PRODUCTION

#ifdef TVO_STAGING
#define APP_API_KEY     @"mxm12oakstgebd927702cfe11e48c210800200c9a66"
#endif // TVO_STAGING

#ifdef TVO_TRAINING
#define APP_API_KEY     @"7386b5548432485fb717913c57a0c5f814283997915461657458721"
#endif // TVO_TRAINING

#define APP_URL @"http://www.mallatutc.com"

#endif // (defined (TVO_STAGING) || defined (TVO_TRAINING) ||defined (TVO_PRODUCTION))


#pragma mark -
#pragma mark DOLPHIN API KEY
#if (defined (DOLPHIN) || defined (DOLPHIN_SPANISH_TESTING))

#ifdef DOLPHIN
#define APP_API_KEY @"dolstge19aebd0366911e48c210800200c9a66"

#endif // DOLPHIN

#ifdef DOLPHIN_SPANISH_TESTING
#define APP_API_KEY @"b69c23848ec4447fa719134d0a93d23b14169057830911738299357"

#endif // DOLPHIN_SPANISH_TESTING

#define APP_URL @"http://www.shopdolphinmall.com"

#endif // (defined (DOLPHIN) || defined (DOLPHIN_SPANISH_TESTING))


#pragma mark -
#pragma mark CARMEL API KEY
#if (defined (CARMEL_TESTING) || defined (CARMEL_SRG) || defined (CARMEL_DEMO))

#ifdef CARMEL_TESTING
#define APP_API_KEY @"5b4f23924877434ba630bf0fa76831eb"
#endif // CARMEL_TESTING

#ifdef CARMEL_SRG
#define APP_API_KEY @"3d5039143cae4fc8b03e52f95704932e14178828109801158695180"
#endif // CARMEL_SRG

#ifdef CARMEL_DEMO
#define APP_API_KEY @"5dd65435a8ba46c2bb05bdd479ed473514367902240951928019825"
#endif

#define APP_URL @"http://www.clalit.co.il"

#endif // (defined (CARMEL_TESTING) || defined (CARMEL_SRG))


#pragma mark -
#pragma mark OFFICE API KEY
#if (defined (OFFICE_DEBUG))

#ifdef OFFICE_DEBUG
#define APP_API_KEY @"mba26ad85a0bb543ca8ab42cc7fcaaed47"
#endif // OFFICE_DEBUG


#define APP_URL @"http://www.spreo.co"

#endif // (defined (OFFICE_DEBUG))


#pragma mark -
#pragma mark NIH API KEY
#ifdef NIH

#define APP_API_KEY @"a180bd3ee4864ea691f66ecbc07d21c114231344223761260838196"
#define APP_URL @"http://www.nih.gov"

#endif // NIH


#pragma mark -
#pragma mark ENGLEWOOD API KEY
#if (defined (ENGLEWOOD_STAGING) || defined (ENGLEWOOD_PRODUCTION) || defined(ENGLEWOOD_DEMO))

#ifdef ENGLEWOOD_DEMO
#define APP_API_KEY @"3c2f81ea872b452d835f9e49eaab194014230522512551892778037"
#endif // ENGLEWOOD_DEMO

#ifdef ENGLEWOOD_PRODUCTION
#define APP_API_KEY @"34c79f0642634376bd4e5eb6ae3cea70"
#endif // ENGLEWOOD_PRODUCTION

#ifdef ENGLEWOOD_STAGING
#define APP_API_KEY @"engstg0f3517b059c311e48ed60800200c9a66"
#endif //ENGLEWOOD_STAGING

#define APP_URL @"http://www.englewoodhospital.com/"

#endif // (defined (ENGLEWOOD_STAGING) || defined (ENGLEWOOD_PRODUCTION))


#pragma mark -
#pragma mark DUBAI API KEY
#if (defined (DUBAI_WTC_STAGING) || defined (DUBAI_WTC_TESTING))

#ifdef DUBAI_WTC_STAGING
#define APP_API_KEY @"dwtc233dd0850c11e4b4a90800200c9a66"
#endif // DUBAI_WTC_STAGING

#ifdef DUBAI_WTC_TESTING
#define APP_API_KEY @"dwtc233dd0850c11e4b4a90800200c9a66"
#endif //DUBAI_WTC_TESTING

#define APP_URL @"http://www.dwtc.com/"

#endif // (defined (ENGLEWOOD_STAGING) || defined (ENGLEWOOD_PRODUCTION))


#pragma mark -
#pragma mark ASURE

#ifdef ASURE
#define APP_API_KEY @"f02e4a84ad304751b4272458b2fa2fd414409219907771088681295"
#endif //ASURE


