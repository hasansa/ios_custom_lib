//
//  IDPoi.h
//  IndoorKit
//
//  Copyright (c) 2015 Spreo LLC. All rights reserved.
//

@class IDLocation;
@import MapKit;

////////////////////////////////////////////////////////////////////////////////////////////
//
// IDPoi
/*!
 * The Indoor Kit Poi Class.
 */

@interface IDPoi : NSObject <MKAnnotation, NSCoding>

/*!
 * @brief The Poi Title.
 */
@property (nonatomic, readonly, copy) NSString *title;


/*!
 * @brief The Poi Subtitle.
 */
@property (nonatomic, readonly, copy) NSString *subtitle;


/*!
 * @brief The Poi Unique Identifier.
 */
@property (nonatomic, strong, readonly) NSString *identifier;


/*!
 * @brief The Poi Categories Array.
 */
@property (nonatomic, strong, readonly) NSArray *categories;


/*!
 * @brief The Poi Location. IDLocation Class.
 */
@property (nonatomic) IDLocation *location;


/*!
 * @brief The Poi Info Dictionary.
 */
@property (nonatomic, strong) NSDictionary *info;

- (instancetype)initPoiWithDictionary:(NSDictionary *)aDictionary andLocation:(IDLocation *)aLocation;

- (instancetype)initPoiWithTitle:(NSString *)aTitle
                        subtitle:(NSString *)aSubtitle
                     description:(NSString *)aDescription
                      identifier:(NSString *)anIdentifier
                      categories:(NSArray *)categories
                        location:(IDLocation *)aLocation
                         andInfo:(NSDictionary *)aDictionary;

+ (instancetype)initPoiWithPoi:(IDPoi*)aPoi;

@end