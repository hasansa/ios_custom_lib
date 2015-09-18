//
//  Location.m
//  IOSSpreoSDK
//
//  Created by Reuven M on 5/8/14.
//  Copyright (c) 2015 Spreo LLC. All rights reserved
//

#import "IDLocation.h"
#import <MapKit/MapKit.h>

@implementation IDLocation

+ (instancetype)locationWithLocation:(IDLocation *)aLocation
{
    return [[IDLocation alloc] initWithCampusId:aLocation.campusId
                                     facilityId:aLocation.facilityId
                                  outCoordinate:aLocation.outCoordinate
                                   inCoordinate:aLocation.inCoordinate
                                     andFloorId:aLocation.floorId];
}

- (instancetype)initWithCampusId:(NSString *)aCampusId
                      facilityId:(NSString *)aFacilityId
                   outCoordinate:(CLLocationCoordinate2D)outCoordinate
                    inCoordinate:(CGPoint)inCoordinate
                      andFloorId:(NSInteger)floorId
{
    self = [super init];
    if (self) {
        _campusId = aCampusId;
        _facilityId = aFacilityId;
        _outCoordinate = outCoordinate;
        _inCoordinate = inCoordinate;
        _rawCoordinate = inCoordinate;
        _floorId = floorId;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _campusId = [aDecoder decodeObjectForKey:@"campusId"];
        _facilityId = [aDecoder decodeObjectForKey:@"facilityId"];
        _floorId = [[aDecoder decodeObjectForKey:@"floorId"] integerValue];
        _inCoordinate = [[aDecoder decodeObjectForKey:@"inCoordinate"] CGPointValue];
        _rawCoordinate = [[aDecoder decodeObjectForKey:@"rawCoordinate"] CGPointValue];
        CGPoint coord = [[aDecoder decodeObjectForKey:@"outCoordinate"] CGPointValue];
        _outCoordinate = CLLocationCoordinate2DMake(coord.x, coord.y);
    }
    return self;
}

- (BOOL)isIndoor
{
    return (nil != self.campusId) && (nil != self.facilityId) && (NO == self.isOutdoor);
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_campusId forKey:@"campusId"];
    [encoder encodeObject:_facilityId forKey:@"facilityId"];
    [encoder encodeObject:@(_floorId) forKey:@"floorId"];
    [encoder encodeObject:[NSValue valueWithCGPoint:_inCoordinate] forKey:@"inCoordinate"];
    [encoder encodeObject:[NSValue valueWithCGPoint:_rawCoordinate] forKey:@"rawCoordinate"];
    [encoder encodeObject:[NSValue valueWithCGPoint:CGPointMake(_outCoordinate.latitude, _outCoordinate.longitude)] forKey:@"outCoordinate"];
}

- (BOOL)isValid
{
    BOOL retVal;
    if ((CLLocationCoordinate2DIsValid(self.outCoordinate) && (0 != self.outCoordinate.latitude && 0 != self.outCoordinate.longitude)) ||
        ((nil != self.campusId) && (nil != self.facilityId) && !CGPointEqualToPoint(self.inCoordinate, CGPointZero))) {
        retVal = YES;
    } else {
        retVal = NO;
        NSLog(@"No valid location");
    }
    
    return retVal;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"campus id:%@, facility id:%@, outdoor coordinate:%@, floor id:%d, indoor coordinate:%@", _campusId, _facilityId, NSStringFromCGPoint(CGPointMake(_outCoordinate.latitude, _outCoordinate.longitude)), (int)_floorId, NSStringFromCGPoint(_inCoordinate)];
}

- (BOOL)isEqual:(IDLocation*)object
{
    CGPoint coordinates = CGPointMake(self.outCoordinate.latitude, self.outCoordinate.longitude);
    CGPoint objcoordinates = CGPointMake(object.outCoordinate.latitude, object.outCoordinate.longitude);
    
    BOOL equalCoordinates = CGPointEqualToPoint(coordinates, objcoordinates);
    BOOL equalPosition = CGPointEqualToPoint(self.inCoordinate, object.inCoordinate);
    BOOL equalCampuses = ([self.campusId isEqualToString:object.campusId] ||
                          (self.campusId == nil && object.campusId == nil));
    BOOL equalFacilities = ([self.facilityId isEqualToString:object.facilityId] ||
                            (self.facilityId == nil && object.facilityId == nil));
    BOOL equalFloors = (self.floorId == object.floorId);
    
    return equalCoordinates && equalPosition && equalCampuses && equalFacilities && equalFloors;
}

@end

@implementation IDUserLocation

+ (instancetype)userLocationWithUserLocation:(IDUserLocation *)aLocation
{
    return [[IDUserLocation alloc] initWithCampusId:aLocation.campusId
                                         facilityId:aLocation.facilityId
                                      outCoordinate:aLocation.outCoordinate
                                       inCoordinate:aLocation.inCoordinate
                                            floorId:aLocation.floorId
                                          segmentId:aLocation.segmentId
                                        andAttitude:aLocation.attitude];
}

- (instancetype)initWithCampusId:(NSString *)aCampusId
                      facilityId:(NSString *)aFacilityId
                   outCoordinate:(CLLocationCoordinate2D)outCoordinate
                    inCoordinate:(CGPoint)inCoordinate
                         floorId:(NSInteger)floorId
                       segmentId:(NSInteger)segmentId
                     andAttitude:(CGFloat)attitude
{
    self = [super initWithCampusId:aCampusId
                        facilityId:aFacilityId
                     outCoordinate:outCoordinate
                      inCoordinate:inCoordinate
                        andFloorId:floorId];
    if (self) {
        _segmentId = segmentId;
        _attitude = attitude;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _segmentId = [[aDecoder decodeObjectForKey:@"segmentId"] integerValue];
        _attitude = [[aDecoder decodeObjectForKey:@"attitude"] floatValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [super encodeWithCoder:encoder];
    [encoder encodeObject:@(_segmentId) forKey:@"segmentId"];
    [encoder encodeObject:@(_attitude) forKey:@"attitude"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, attitude:%d, segment id:%d", [super description], (int)(_attitude), (int)_segmentId];
}


@end
