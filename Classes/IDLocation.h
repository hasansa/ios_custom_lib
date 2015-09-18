//
//  IDLocation.h
//  IndoorKit
//
//  Copyright (c) 2015 Spreo LLC. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
@import UIKit;

////////////////////////////////////////////////////////////////////////////////////////////
//
// IDLocation
/*! 
 * The Indoor Kit General Location Class.
 */

@interface IDLocation : NSObject<NSCoding> 


/*!
 * @brief The Location Campus identifier.
 */
@property (nonatomic, strong) NSString *campusId;


/*!
 * @brief The Location Facility identifier.
 */
@property (nonatomic, strong) NSString *facilityId;


/*!
 * @brief The Location Floor identifier Number.
 */
@property (nonatomic) NSInteger floorId;


/*!
 * @brief The Location inCoordinate Point. The indoor Position
 */
@property (nonatomic) CGPoint inCoordinate;

/*!
 * @brief The Location rawCoordinate Point. The indoor raw Position 
 */
@property (nonatomic) CGPoint rawCoordinate;


/*!
 * @brief The Location outCoordinate Coordinates. The outdoor Position
 */
@property (nonatomic) CLLocationCoordinate2D outCoordinate;


/*!
 * @brief The Location isOutdoor BOOL. if has outdoor navigation type "external"
 */
@property (nonatomic) BOOL isOutdoor;


/*!
 * @return True in case the facilityId is not equal to nil. otherwise False.
 */
@property (nonatomic, getter=isIndoor, readonly) BOOL indoor;


/*!
 * @return True in case the inCoordinate and outCoordinate are not equal to {0, 0}. otherwise False.
 */
@property (nonatomic, getter=isValid, readonly) BOOL valid;

- (instancetype)initWithCampusId:(NSString *)aCampusId
                      facilityId:(NSString *)aFacilityId
                   outCoordinate:(CLLocationCoordinate2D)outCoordinate
                    inCoordinate:(CGPoint)inCoordinate
                      andFloorId:(NSInteger)floorId;

+ (instancetype)locationWithLocation:(IDLocation *)aLocation;

@end

////////////////////////////////////////////////////////////////////////////////////////////
//
// IDUserLocation
/*! 
 * The Indoor Kit User Location Class.
 */

@interface IDUserLocation : IDLocation


/*!
 * @brief A Segment identifier.
 */
@property (nonatomic) NSInteger segmentId;


/*!
 * @brief A Attitude. The oreinteion angle
 */
@property (nonatomic) CGFloat attitude;

- (instancetype)initWithCampusId:(NSString *)aCampusId
                      facilityId:(NSString *)aFacilityId
                   outCoordinate:(CLLocationCoordinate2D)outCoordinate
                    inCoordinate:(CGPoint)inCoordinate
                         floorId:(NSInteger)floorId
                       segmentId:(NSInteger)segmentId
                     andAttitude:(CGFloat)attitude;

+ (instancetype)userLocationWithUserLocation:(IDUserLocation *)aLocation;

@end