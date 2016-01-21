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
#import "JRUserSettings.h"

@interface JRUserSettings ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRUserSettings
{
    JRDecimal *_delayedStart;
    NSString *_distanceUnits;
    JRBoolean *_keepScreenOn;
    NSString *_temperatureUnits;
}
@synthesize canBeUpdatedOnCapture;

- (JRDecimal *)delayedStart
{
    return _delayedStart;
}

- (void)setDelayedStart:(JRDecimal *)newDelayedStart
{
    [self.dirtyPropertySet addObject:@"delayedStart"];

    _delayedStart = [newDelayedStart copy];
}

- (NSString *)distanceUnits
{
    return _distanceUnits;
}

- (void)setDistanceUnits:(NSString *)newDistanceUnits
{
    [self.dirtyPropertySet addObject:@"distanceUnits"];

    _distanceUnits = [newDistanceUnits copy];
}

- (JRBoolean *)keepScreenOn
{
    return _keepScreenOn;
}

- (void)setKeepScreenOn:(JRBoolean *)newKeepScreenOn
{
    [self.dirtyPropertySet addObject:@"keepScreenOn"];

    _keepScreenOn = [newKeepScreenOn copy];
}

- (BOOL)getKeepScreenOnBoolValue
{
    return [_keepScreenOn boolValue];
}

- (void)setKeepScreenOnWithBool:(BOOL)boolVal
{
    [self.dirtyPropertySet addObject:@"keepScreenOn"];

    _keepScreenOn = [NSNumber numberWithBool:boolVal];
}

- (NSString *)temperatureUnits
{
    return _temperatureUnits;
}

- (void)setTemperatureUnits:(NSString *)newTemperatureUnits
{
    [self.dirtyPropertySet addObject:@"temperatureUnits"];

    _temperatureUnits = [newTemperatureUnits copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/runnersWorld/runnersWorldGoApp/userSettings";
        self.canBeUpdatedOnCapture = YES;


        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)userSettings
{
    return [[JRUserSettings alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.delayedStart ? self.delayedStart : [NSNull null])
                   forKey:@"delayedStart"];
    [dictionary setObject:(self.distanceUnits ? self.distanceUnits : [NSNull null])
                   forKey:@"distanceUnits"];
    [dictionary setObject:(self.keepScreenOn ? [NSNumber numberWithBool:[self.keepScreenOn boolValue]] : [NSNull null])
                   forKey:@"keepScreenOn"];
    [dictionary setObject:(self.temperatureUnits ? self.temperatureUnits : [NSNull null])
                   forKey:@"temperatureUnits"];

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

+ (id)userSettingsObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRUserSettings *userSettings = [JRUserSettings userSettings];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        userSettings.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    userSettings.delayedStart =
        [dictionary objectForKey:@"delayedStart"] != [NSNull null] ? 
        [dictionary objectForKey:@"delayedStart"] : nil;

    userSettings.distanceUnits =
        [dictionary objectForKey:@"distanceUnits"] != [NSNull null] ? 
        [dictionary objectForKey:@"distanceUnits"] : nil;

    userSettings.keepScreenOn =
        [dictionary objectForKey:@"keepScreenOn"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"keepScreenOn"] boolValue]] : nil;

    userSettings.temperatureUnits =
        [dictionary objectForKey:@"temperatureUnits"] != [NSNull null] ? 
        [dictionary objectForKey:@"temperatureUnits"] : nil;

    if (fromDecoder)
        [userSettings.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [userSettings.dirtyPropertySet removeAllObjects];

    return userSettings;
}

+ (id)userSettingsObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRUserSettings userSettingsObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.delayedStart =
        [dictionary objectForKey:@"delayedStart"] != [NSNull null] ? 
        [dictionary objectForKey:@"delayedStart"] : nil;

    self.distanceUnits =
        [dictionary objectForKey:@"distanceUnits"] != [NSNull null] ? 
        [dictionary objectForKey:@"distanceUnits"] : nil;

    self.keepScreenOn =
        [dictionary objectForKey:@"keepScreenOn"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"keepScreenOn"] boolValue]] : nil;

    self.temperatureUnits =
        [dictionary objectForKey:@"temperatureUnits"] != [NSNull null] ? 
        [dictionary objectForKey:@"temperatureUnits"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"delayedStart", @"distanceUnits", @"keepScreenOn", @"temperatureUnits", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"userSettings"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"userSettings"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"userSettings"] allObjects]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"delayedStart"])
        [dictionary setObject:(self.delayedStart ? self.delayedStart : [NSNull null]) forKey:@"delayedStart"];

    if ([self.dirtyPropertySet containsObject:@"distanceUnits"])
        [dictionary setObject:(self.distanceUnits ? self.distanceUnits : [NSNull null]) forKey:@"distanceUnits"];

    if ([self.dirtyPropertySet containsObject:@"keepScreenOn"])
        [dictionary setObject:(self.keepScreenOn ? [NSNumber numberWithBool:[self.keepScreenOn boolValue]] : [NSNull null]) forKey:@"keepScreenOn"];

    if ([self.dirtyPropertySet containsObject:@"temperatureUnits"])
        [dictionary setObject:(self.temperatureUnits ? self.temperatureUnits : [NSNull null]) forKey:@"temperatureUnits"];

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

    [dictionary setObject:(self.delayedStart ? self.delayedStart : [NSNull null]) forKey:@"delayedStart"];
    [dictionary setObject:(self.distanceUnits ? self.distanceUnits : [NSNull null]) forKey:@"distanceUnits"];
    [dictionary setObject:(self.keepScreenOn ? [NSNumber numberWithBool:[self.keepScreenOn boolValue]] : [NSNull null]) forKey:@"keepScreenOn"];
    [dictionary setObject:(self.temperatureUnits ? self.temperatureUnits : [NSNull null]) forKey:@"temperatureUnits"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToUserSettings:(JRUserSettings *)otherUserSettings
{
    if (!self.delayedStart && !otherUserSettings.delayedStart) /* Keep going... */;
    else if ((self.delayedStart == nil) ^ (otherUserSettings.delayedStart == nil)) return NO; // xor
    else if (![self.delayedStart isEqualToNumber:otherUserSettings.delayedStart]) return NO;

    if (!self.distanceUnits && !otherUserSettings.distanceUnits) /* Keep going... */;
    else if ((self.distanceUnits == nil) ^ (otherUserSettings.distanceUnits == nil)) return NO; // xor
    else if (![self.distanceUnits isEqualToString:otherUserSettings.distanceUnits]) return NO;

    if (!self.keepScreenOn && !otherUserSettings.keepScreenOn) /* Keep going... */;
    else if ((self.keepScreenOn == nil) ^ (otherUserSettings.keepScreenOn == nil)) return NO; // xor
    else if (![self.keepScreenOn isEqualToNumber:otherUserSettings.keepScreenOn]) return NO;

    if (!self.temperatureUnits && !otherUserSettings.temperatureUnits) /* Keep going... */;
    else if ((self.temperatureUnits == nil) ^ (otherUserSettings.temperatureUnits == nil)) return NO; // xor
    else if (![self.temperatureUnits isEqualToString:otherUserSettings.temperatureUnits]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"JRDecimal" forKey:@"delayedStart"];
    [dictionary setObject:@"NSString" forKey:@"distanceUnits"];
    [dictionary setObject:@"JRBoolean" forKey:@"keepScreenOn"];
    [dictionary setObject:@"NSString" forKey:@"temperatureUnits"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
