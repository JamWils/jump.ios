/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 Copyright (c) 2012, Janrain, Inc.

 All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation and/or
   other materials provided with the distribution.
 * Neither the name of the Janrain, Inc. nor the names of its
   contributors may be used to endorse or promote products derived from this
   software without specific prior written permission.


 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


#import "JRCaptureObject+Internal.h"
#import "JRTemporaryData.h"

@interface JRDevicesTemp (JRDevicesTemp_InternalMethods)
+ (id)devicesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder;
- (BOOL)isEqualToDevicesTemp:(JRDevicesTemp *)otherDevicesTemp;
@end

@interface JRRunnersWorldFavoritesTemp (JRRunnersWorldFavoritesTemp_InternalMethods)
+ (id)runnersWorldFavoritesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder;
- (BOOL)isEqualToRunnersWorldFavoritesTemp:(JRRunnersWorldFavoritesTemp *)otherRunnersWorldFavoritesTemp;
@end

@interface JRTemporaryData ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRTemporaryData
{
    JRDevicesTemp *_devicesTemp;
    JRRunnersWorldFavoritesTemp *_runnersWorldFavoritesTemp;
}
@synthesize canBeUpdatedOnCapture;

- (JRDevicesTemp *)devicesTemp
{
    return _devicesTemp;
}

- (void)setDevicesTemp:(JRDevicesTemp *)newDevicesTemp
{
    [self.dirtyPropertySet addObject:@"devicesTemp"];

    _devicesTemp = newDevicesTemp;

    [_devicesTemp setAllPropertiesToDirty];
}

- (JRRunnersWorldFavoritesTemp *)runnersWorldFavoritesTemp
{
    return _runnersWorldFavoritesTemp;
}

- (void)setRunnersWorldFavoritesTemp:(JRRunnersWorldFavoritesTemp *)newRunnersWorldFavoritesTemp
{
    [self.dirtyPropertySet addObject:@"runnersWorldFavoritesTemp"];

    _runnersWorldFavoritesTemp = newRunnersWorldFavoritesTemp;

    [_runnersWorldFavoritesTemp setAllPropertiesToDirty];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/temporaryData";
        self.canBeUpdatedOnCapture = YES;

        _devicesTemp = [[JRDevicesTemp alloc] init];
        _runnersWorldFavoritesTemp = [[JRRunnersWorldFavoritesTemp alloc] init];

        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)temporaryData
{
    return [[JRTemporaryData alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.devicesTemp ? [self.devicesTemp newDictionaryForEncoder:forEncoder] : [NSNull null])
                   forKey:@"devicesTemp"];
    [dictionary setObject:(self.runnersWorldFavoritesTemp ? [self.runnersWorldFavoritesTemp newDictionaryForEncoder:forEncoder] : [NSNull null])
                   forKey:@"runnersWorldFavoritesTemp"];

    if (forEncoder)
    {
        [dictionary setObject:([self.dirtyPropertySet allObjects] ? [self.dirtyPropertySet allObjects] : [NSArray array])
                       forKey:@"dirtyPropertiesSet"];
        [dictionary setObject:(self.captureObjectPath ? self.captureObjectPath : [NSNull null])
                       forKey:@"captureObjectPath"];
        [dictionary setObject:[NSNumber numberWithBool:self.canBeUpdatedOnCapture]
                       forKey:@"canBeUpdatedOnCapture"];
    }

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

+ (id)temporaryDataObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRTemporaryData *temporaryData = [JRTemporaryData temporaryData];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        temporaryData.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    temporaryData.devicesTemp =
        [dictionary objectForKey:@"devicesTemp"] != [NSNull null] ? 
        [JRDevicesTemp devicesTempObjectFromDictionary:[dictionary objectForKey:@"devicesTemp"] withPath:temporaryData.captureObjectPath fromDecoder:fromDecoder] : nil;

    temporaryData.runnersWorldFavoritesTemp =
        [dictionary objectForKey:@"runnersWorldFavoritesTemp"] != [NSNull null] ? 
        [JRRunnersWorldFavoritesTemp runnersWorldFavoritesTempObjectFromDictionary:[dictionary objectForKey:@"runnersWorldFavoritesTemp"] withPath:temporaryData.captureObjectPath fromDecoder:fromDecoder] : nil;

    if (fromDecoder)
        [temporaryData.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [temporaryData.dirtyPropertySet removeAllObjects];

    return temporaryData;
}

+ (id)temporaryDataObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRTemporaryData temporaryDataObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    if (![dictionary objectForKey:@"devicesTemp"] || [dictionary objectForKey:@"devicesTemp"] == [NSNull null])
        self.devicesTemp = nil;
    else if (!self.devicesTemp)
        self.devicesTemp = [JRDevicesTemp devicesTempObjectFromDictionary:[dictionary objectForKey:@"devicesTemp"] withPath:self.captureObjectPath fromDecoder:NO];
    else
        [self.devicesTemp replaceFromDictionary:[dictionary objectForKey:@"devicesTemp"] withPath:self.captureObjectPath];

    if (![dictionary objectForKey:@"runnersWorldFavoritesTemp"] || [dictionary objectForKey:@"runnersWorldFavoritesTemp"] == [NSNull null])
        self.runnersWorldFavoritesTemp = nil;
    else if (!self.runnersWorldFavoritesTemp)
        self.runnersWorldFavoritesTemp = [JRRunnersWorldFavoritesTemp runnersWorldFavoritesTempObjectFromDictionary:[dictionary objectForKey:@"runnersWorldFavoritesTemp"] withPath:self.captureObjectPath fromDecoder:NO];
    else
        [self.runnersWorldFavoritesTemp replaceFromDictionary:[dictionary objectForKey:@"runnersWorldFavoritesTemp"] withPath:self.captureObjectPath];

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"devicesTemp", @"runnersWorldFavoritesTemp", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"temporaryData"];

    if (self.devicesTemp)
        [snapshotDictionary setObject:[self.devicesTemp snapshotDictionaryFromDirtyPropertySet]
                               forKey:@"devicesTemp"];

    if (self.runnersWorldFavoritesTemp)
        [snapshotDictionary setObject:[self.runnersWorldFavoritesTemp snapshotDictionaryFromDirtyPropertySet]
                               forKey:@"runnersWorldFavoritesTemp"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"temporaryData"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"temporaryData"] allObjects]];

    if ([snapshotDictionary objectForKey:@"devicesTemp"])
        [self.devicesTemp restoreDirtyPropertiesFromSnapshotDictionary:
                    [snapshotDictionary objectForKey:@"devicesTemp"]];

    if ([snapshotDictionary objectForKey:@"runnersWorldFavoritesTemp"])
        [self.runnersWorldFavoritesTemp restoreDirtyPropertiesFromSnapshotDictionary:
                    [snapshotDictionary objectForKey:@"runnersWorldFavoritesTemp"]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"devicesTemp"])
        [dictionary setObject:(self.devicesTemp ?
                              [self.devicesTemp toUpdateDictionary] :
                              [[JRDevicesTemp devicesTemp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                       forKey:@"devicesTemp"];
    else if ([self.devicesTemp needsUpdate])
        [dictionary setObject:[self.devicesTemp toUpdateDictionary]
                       forKey:@"devicesTemp"];

    if ([self.dirtyPropertySet containsObject:@"runnersWorldFavoritesTemp"])
        [dictionary setObject:(self.runnersWorldFavoritesTemp ?
                              [self.runnersWorldFavoritesTemp toUpdateDictionary] :
                              [[JRRunnersWorldFavoritesTemp runnersWorldFavoritesTemp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                       forKey:@"runnersWorldFavoritesTemp"];
    else if ([self.runnersWorldFavoritesTemp needsUpdate])
        [dictionary setObject:[self.runnersWorldFavoritesTemp toUpdateDictionary]
                       forKey:@"runnersWorldFavoritesTemp"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (void)updateOnCaptureForDelegate:(id<JRCaptureObjectDelegate>)delegate context:(NSObject *)context
{
    [super updateOnCaptureForDelegate:delegate context:context];
}

- (NSDictionary *)toReplaceDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];


    [dictionary setObject:(self.devicesTemp ?
                          [self.devicesTemp toReplaceDictionary] :
                          [[JRDevicesTemp devicesTemp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                   forKey:@"devicesTemp"];

    [dictionary setObject:(self.runnersWorldFavoritesTemp ?
                          [self.runnersWorldFavoritesTemp toReplaceDictionary] :
                          [[JRRunnersWorldFavoritesTemp runnersWorldFavoritesTemp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                   forKey:@"runnersWorldFavoritesTemp"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    if ([self.devicesTemp needsUpdate])
        return YES;

    if ([self.runnersWorldFavoritesTemp needsUpdate])
        return YES;

    return NO;
}

- (BOOL)isEqualToTemporaryData:(JRTemporaryData *)otherTemporaryData
{
    if (!self.devicesTemp && !otherTemporaryData.devicesTemp) /* Keep going... */;
    else if (!self.devicesTemp && [otherTemporaryData.devicesTemp isEqualToDevicesTemp:[JRDevicesTemp devicesTemp]]) /* Keep going... */;
    else if (!otherTemporaryData.devicesTemp && [self.devicesTemp isEqualToDevicesTemp:[JRDevicesTemp devicesTemp]]) /* Keep going... */;
    else if (![self.devicesTemp isEqualToDevicesTemp:otherTemporaryData.devicesTemp]) return NO;

    if (!self.runnersWorldFavoritesTemp && !otherTemporaryData.runnersWorldFavoritesTemp) /* Keep going... */;
    else if (!self.runnersWorldFavoritesTemp && [otherTemporaryData.runnersWorldFavoritesTemp isEqualToRunnersWorldFavoritesTemp:[JRRunnersWorldFavoritesTemp runnersWorldFavoritesTemp]]) /* Keep going... */;
    else if (!otherTemporaryData.runnersWorldFavoritesTemp && [self.runnersWorldFavoritesTemp isEqualToRunnersWorldFavoritesTemp:[JRRunnersWorldFavoritesTemp runnersWorldFavoritesTemp]]) /* Keep going... */;
    else if (![self.runnersWorldFavoritesTemp isEqualToRunnersWorldFavoritesTemp:otherTemporaryData.runnersWorldFavoritesTemp]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"JRDevicesTemp" forKey:@"devicesTemp"];
    [dictionary setObject:@"JRRunnersWorldFavoritesTemp" forKey:@"runnersWorldFavoritesTemp"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
