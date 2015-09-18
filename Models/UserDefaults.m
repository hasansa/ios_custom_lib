//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import "UserDefaults.h"

// USER KEYS
static NSString * const kUserDefaultsAnalyticsModeKey            = @"kUserDefaultsAnalyticsModeKey";
static NSString * const kUserDefaultsUserLocationsModeKey        = @"kUserDefaultsUserLocationsModeKey";
static NSString * const kUserDefaultsLocationSharingModeKey      = @"kUserDefaultsLocationSharingModeKey";
static NSString * const kUserDefaultsProfileModeKey              = @"kUserDefaultsProfileModeKey";
static NSString * const kUserDefaultsApiKeysModeKey              = @"kUserDefaultsApiKeysModeKey";
static NSString * const kUserDefaultsAppApiKey                   = @"kUserDefaultsAppApiKey";
static NSString * const kUserDefaultsUserIDKey                   = @"kUserDefaultsUserIDKey";
static NSString * const kUserDefaultsProjectIDKey                = @"kUserDefaultsProjectIDKey";
static NSString * const kUserDefaultsDeveloperUserKey            = @"kUserDefaultsDeveloperUserKey";
static NSString * const kUserDefaultsOutDoorMapTypeKey           = @"kUserDefaultsOutDoorMapTypeKey";
static NSString * const kUserDefaultsInDoorMapRotationKey        = @"kUserDefaultsInDoorMapRotationKey";

// INDOOR MAP KEYS
static NSString * const kUserDefaultsUserLayerKey                = @"kUserDefaultsShowUserLayerKey";
static NSString * const kUserDefaultsCampusLayerKey              = @"kUserDefaultsCampusLayerKey";
static NSString * const kUserDefaultsFacilityLayerKey            = @"kUserDefaultsFacilityLayerKey";
static NSString * const kUserDefaultsPoisLayerKey                = @"kUserDefaultsPoisLayerKey";
static NSString * const kUserDefaultsPathsLayerKey                 = @"kUserDefaultsGisLayerKey";
static NSString * const kUserDefaultsRouteLayerKey               = @"kUserDefaultsRouteLayerKey";
static NSString * const kUserDefaultsLabelsLayerKey              = @"kUserDefaultsLabelsLayerKey";
//
static NSString * const kUserDefaultsTripNavigationPoiKey                = @"kUserDefaultsTripNavigationPoiKey";
//
static NSString * const kUserDefaultsVisibleCategoriesKey        = @"kUserDefaultsVisibleCategoriesKey";
//
static NSString * const kUserDefaultsSimulationModeKey               = @"kkUserDefaultsSimulationModeKey";
//
static NSString * const kUserDefaultsSimulatedModeKey               = @"kUserDefaultsSimulatedModeKey";
static NSString * const kUserDefaultsSimulatedLocKey               = @"kUserDefaultsSimulatedLocKey";
//
static NSString * const kUserDefaultsSoundModeKey                = @"kUserDefaultsSoundModeKey";



// GLOABL KEYS
static NSString * const kUserDefaultsPoiFavorites                = @"kUserDefaultsPoiFavorites";
static NSString * const kUserDefaultsRecentSearch                = @"kUserDefaultsRecentSearch";
static NSString * const kSaveLanguageDefaultKey                  = @"kSaveLanguageDefaultKey";


@interface UserDefaults()

@property (nonatomic, strong) NSArray* myTripPoisArray;
@property (nonatomic, strong) NSArray* myTripArrivedPoisArray;

@end

@implementation UserDefaults

static UserDefaults * _sharedUserDefaults = nil;

+ (UserDefaults *)sharedDefaults
{
    @synchronized(self) {
        if (nil == _sharedUserDefaults) {
            
            _sharedUserDefaults = [[self alloc] init];
        }
    }
    return _sharedUserDefaults;
}

+ (void)initialize
{
    if ([self class] == [UserDefaults class]) {

        NSDictionary * defaultsDict = @{kUserDefaultsUserLayerKey        : @(YES),
                                        kUserDefaultsApiKeysModeKey      : @(YES),
                                        kUserDefaultsCampusLayerKey      : @(YES),
                                        kUserDefaultsFacilityLayerKey    : @(YES),
                                        kUserDefaultsPoisLayerKey        : @(YES),
                                        kUserDefaultsPathsLayerKey       : @(NO),
                                        kUserDefaultsRouteLayerKey       : @(YES),
                                        kUserDefaultsLabelsLayerKey      : @(YES),
                                        kUserDefaultsSimulationModeKey   : @(YES),
                                        kUserDefaultsInDoorMapRotationKey: @(1),
                                        kUserDefaultsAnalyticsModeKey    : @(YES),
                                        kUserDefaultsUserLocationsModeKey: @(NO),
                                        kUserDefaultsLocationSharingModeKey: @(NO),
                                        kUserDefaultsSoundModeKey: @(YES)};
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsDict];
    }
}

- (id)init
{
	if (self = [super init]) {
    
    }
    
    return self;
}

#pragma mark -
#pragma mark - Getters
- (NSString*)kAppApiKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsAppApiKey];
}

- (BOOL)multiApikeysMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsApiKeysModeKey];
}

- (BOOL)locationSharingMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsLocationSharingModeKey];
}

- (BOOL)analyticsMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsAnalyticsModeKey];
}

- (BOOL)userlocationsMode
{
   return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsUserLocationsModeKey];
}

- (BOOL)profileMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsProfileModeKey];
}

- (NSString*)userID
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsUserIDKey];
}

- (NSString*)projectID
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kUserDefaultsProjectIDKey];
}

- (BOOL)developerUser
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsDeveloperUserKey];
}

- (NSInteger)mapType
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsOutDoorMapTypeKey] integerValue];
}

- (NSInteger)mapRotation
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kUserDefaultsInDoorMapRotationKey];
}

- (BOOL)userLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsUserLayerKey];
}

- (BOOL)campusLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsCampusLayerKey];
}

- (BOOL)facilityLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsFacilityLayerKey];
}

- (BOOL)poisLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsPoisLayerKey];
}

- (BOOL)pathsLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsPathsLayerKey];
}

- (BOOL)routeLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsRouteLayerKey];
}

- (BOOL)labelsLayer
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsLabelsLayerKey];
}

- (NSArray *)visibleCategories
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsVisibleCategoriesKey];
}

- (BOOL)simulationMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsSimulationModeKey];
}

- (BOOL)simulatedLocationMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsSimulatedModeKey];
}

- (BOOL)muteMode
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kUserDefaultsSoundModeKey];
}

- (NSString *)language
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSaveLanguageDefaultKey];
}

- (NSDictionary *)userPersonalPois
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsPoiFavorites];
}

- (NSDictionary *)userPersonalRecentSearch
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsRecentSearch];
}

- (NSArray*)myTripPois
{
    return _myTripPoisArray;
}

- (NSArray*)myTripArrivedPois
{
    return _myTripArrivedPoisArray;
}

- (IDPoi*)myTripNavigationPio
{
    NSString* poiID = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsTripNavigationPoiKey];
    if (poiID != nil) {
         NSArray* filteredArr = [_myTripPoisArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier = %@", poiID]];
        return [filteredArr firstObject];
    }
    
    return nil;
}


#pragma mark -
#pragma mark - Setters

- (void)setAppApiKey:(NSString*)anApiKey
{
    [[NSUserDefaults standardUserDefaults] setObject:anApiKey forKey:kUserDefaultsAppApiKey];
}

- (void)setMultiApikeysMode:(BOOL)aMode
{
    [[NSUserDefaults standardUserDefaults] setBool:aMode forKey:kUserDefaultsApiKeysModeKey];
}

- (void)updateMyTripPoisWithdArray:(NSArray*)sortedArr
{
    NSMutableArray* newArr = [NSMutableArray arrayWithCapacity:sortedArr.count];
    
    for (IDPoi* poi in sortedArr) {
            if (poi.identifier != nil) {
                
                [newArr addObject:poi];
            }
    }
    
    _myTripPoisArray = [NSArray arrayWithArray:newArr];
}

- (void)updateMyTripPoiWithPoi:(IDPoi*)aPoi add:(BOOL)add
{
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:_myTripPoisArray];

    if (aPoi.identifier != nil) {
        
        if (add) {
            if (![self myTripListContainsPoi:aPoi withArray:_myTripPoisArray]) {
                [newArr addObject:aPoi];
            }
        }
        else {
            if ([self myTripListContainsPoi:aPoi withArray:_myTripPoisArray]) {
                [newArr removeObject:aPoi];
            }
        }
    }
    _myTripPoisArray = [NSArray arrayWithArray:newArr];
}

- (void)updateMyTripArrivedPoisWithPoi:(IDPoi*)aPoi add:(BOOL)add
{
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:_myTripArrivedPoisArray];
    
    if (aPoi.identifier != nil) {
        
        if (add) {
            if (![self myTripListContainsPoi:aPoi withArray:_myTripArrivedPoisArray]) {
                [newArr addObject:aPoi];
            }
        }
        else {
            if ([self myTripListContainsPoi:aPoi withArray:_myTripArrivedPoisArray]) {
                [newArr removeObject:aPoi];
            }
        }
    }
    _myTripArrivedPoisArray = [NSArray arrayWithArray:newArr];
}

- (BOOL)myTripListContainsPoi:(IDPoi*)aPoi
{
    return [self myTripListContainsPoi:aPoi withArray:_myTripArrivedPoisArray];
}

- (BOOL)myTripListContainsPoi:(IDPoi*)aPoi withArray:(NSArray*)arr
{
    NSArray* filteredArr = [arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF.identifier = %@", aPoi.identifier]];
    
    return [filteredArr firstObject] != nil;
}

- (void)setMyTripNavigationPoi:(IDPoi*)aPoi
{
    [[NSUserDefaults standardUserDefaults] setObject:aPoi.identifier forKey:kUserDefaultsTripNavigationPoiKey];
}

-(void)setLocationSharingMode:(BOOL)mode
{
   [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsLocationSharingModeKey];
}

-(void)setAnalyticsMode:(BOOL)mode
{
   [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsAnalyticsModeKey];
}

- (void)setUserLocationsMode:(BOOL)mode
{
   [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsUserLocationsModeKey];
}

- (void)setProfileMode:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsProfileModeKey];
}

- (void)setUserID:(NSString*)userID
{
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:kUserDefaultsUserIDKey];
}

- (void)setProjectID:(NSString*)projectID
{
    [[NSUserDefaults standardUserDefaults] setObject:projectID forKey:kUserDefaultsProjectIDKey];
}

- (void)setDeveloperUser:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsDeveloperUserKey];
}

- (void)setMapType:(NSInteger)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kUserDefaultsOutDoorMapTypeKey];
}

- (void)setMapRotation:(NSInteger)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kUserDefaultsInDoorMapRotationKey];
}

- (void)setUserLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsUserLayerKey];
}

- (void)setCampusLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsCampusLayerKey];
}

- (void)setFacilityLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsFacilityLayerKey];
}

- (void)setPoisLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsPoisLayerKey];
}

- (void)setPathsLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsPathsLayerKey];
}

- (void)setRouteLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsRouteLayerKey];
}

- (void)setLabelsLayer:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsLabelsLayerKey];
}

- (void)setVisibleCategories:(NSArray *)categories
{
    [[NSUserDefaults standardUserDefaults] setObject:categories forKey:kUserDefaultsVisibleCategoriesKey];
}

- (void)setSimulationMode:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsSimulationModeKey];
}

- (void)setSimulatedLocationMode:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsSimulatedModeKey];
}

- (void)setMutedMode:(BOOL)mode
{
    [[NSUserDefaults standardUserDefaults] setBool:mode forKey:kUserDefaultsSoundModeKey];
}

- (void)setUserPersonalLanguage:(NSString *)language
{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:kSaveLanguageDefaultKey];
    [self storeDefaults];
}

- (void)setUserPersonalPoi:(NSDictionary *)poiData
{
    [[NSUserDefaults standardUserDefaults] setObject:poiData forKey:kUserDefaultsPoiFavorites];
    [self storeDefaults];
}

- (void)setUserPersonalRecentSearch:(NSDictionary *)recentSearchData
{
    [[NSUserDefaults standardUserDefaults] setObject:recentSearchData forKey:kUserDefaultsRecentSearch];
    [self storeDefaults];
}

- (void)storeDefaults
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
