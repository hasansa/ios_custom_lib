//
//  IDPoi.m
//  IOSSpreoSDK
//
//  Created by Reuven M on 6/11/14.
//  Copyright (c) 2015 Spreo LLC. All rights reserved
//

#import "IDPoi.h"
#import "IDLocation.h"
#import "IDPoi_Keys.h"

#define kNavTypeInternal        @"internal"
#define kNavTypeExternal        @"external"

@interface IDPoi ()
{
    NSString *_description;
}

@end
@implementation IDPoi

@synthesize coordinate;

- (instancetype)initPoiWithDictionary:(NSDictionary *)aDictionary andLocation:(IDLocation *)aLocation
{
    if (self = [super init]) {
        _title          = aDictionary[kTitle];
        _subtitle       = aDictionary[kSubTitle];
        _identifier     = aDictionary[kID];
        _description    = aDictionary[kDescription];
        _categories     = aDictionary[kCategory];
        _info           = aDictionary[kUserInfo];
        _location = aLocation;
        coordinate = aLocation.outCoordinate;
        
        if ([aDictionary[kNavType] isEqualToString:kNavTypeExternal]) {
            _location.isOutdoor = YES;
        }
        else {
            _location.isOutdoor = NO;
        }
    }
    return self;
}

- (instancetype)initPoiWithTitle:(NSString *)aTitle
                        subtitle:(NSString *)aSubtitle
                     description:(NSString *)aDescription
                      identifier:(NSString *)anIdentifier
                      categories:(NSArray *)categories
                        location:(IDLocation *)aLocation
                         andInfo:(NSDictionary *)aDictionary
{
    if (self = [super init]) {
        _title          = aTitle;
        _subtitle       = aSubtitle;
        _identifier     = anIdentifier;
        _description    = aDescription;
        _categories     = categories;
        _info           = aDictionary;
        _location       = aLocation;
        coordinate      = aLocation.outCoordinate;

        if ([aDictionary[kNavType] isEqualToString:kNavTypeExternal]) {
            _location.isOutdoor = YES;
        }
        else {
            _location.isOutdoor = NO;
        }
    }
    return self;
}

+ (instancetype)initPoiWithPoi:(IDPoi*)aPoi
{
    return [[IDPoi alloc] initPoiWithTitle:aPoi.title
                                  subtitle:aPoi.subtitle
                               description:aPoi.description
                                identifier:aPoi.identifier
                                categories:aPoi.categories
                                  location:aPoi.location
                                   andInfo:aPoi.info];
}

- (NSString *)description
{
    return _description;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _title          = [aDecoder decodeObjectForKey:@"title"];
        _subtitle       = [aDecoder decodeObjectForKey:@"subtitle"];
        _identifier     = [aDecoder decodeObjectForKey:@"identifier"];
        _description     = [aDecoder decodeObjectForKey:@"description"];
        _categories     = [aDecoder decodeObjectForKey:@"categories"];
        _info           = [aDecoder decodeObjectForKey:@"info"];
        _location       = [aDecoder decodeObjectForKey:@"location"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"title"];
    [encoder encodeObject:_subtitle forKey:@"subtitle"];
    [encoder encodeObject:_identifier forKey:@"identifier"];
    [encoder encodeObject:_description forKey:@"description"];
    [encoder encodeObject:_categories forKey:@"categories"];
    [encoder encodeObject:_info forKey:@"info"];
    [encoder encodeObject:_location forKey:@"location"];
    
}


@end
