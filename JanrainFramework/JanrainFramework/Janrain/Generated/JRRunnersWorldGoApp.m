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
#import "JRRunnersWorldGoApp.h"

@interface JRUserSettings (JRUserSettings_InternalMethods)
+ (id)userSettingsObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder;
- (BOOL)isEqualToUserSettings:(JRUserSettings *)otherUserSettings;
@end

@interface JRRunnersWorldGoApp ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRRunnersWorldGoApp
{
    JRDate *_trialStartDate;
    JRUserSettings *_userSettings;
}
@synthesize canBeUpdatedOnCapture;

- (JRDate *)trialStartDate
{
    return _trialStartDate;
}

- (void)setTrialStartDate:(JRDate *)newTrialStartDate
{
    [self.dirtyPropertySet addObject:@"trialStartDate"];

    _trialStartDate = [newTrialStartDate copy];
}

- (JRUserSettings *)userSettings
{
    return _userSettings;
}

- (void)setUserSettings:(JRUserSettings *)newUserSettings
{
    [self.dirtyPropertySet addObject:@"userSettings"];

    _userSettings = newUserSettings;

    [_userSettings setAllPropertiesToDirty];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/runnersWorld/runnersWorldGoApp";
        self.canBeUpdatedOnCapture = YES;

        _userSettings = [[JRUserSettings alloc] init];

        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)runnersWorldGoApp
{
    return [[JRRunnersWorldGoApp alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.trialStartDate ? [self.trialStartDate stringFromISO8601Date] : [NSNull null])
                   forKey:@"trialStartDate"];
    [dictionary setObject:(self.userSettings ? [self.userSettings newDictionaryForEncoder:forEncoder] : [NSNull null])
                   forKey:@"userSettings"];

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

+ (id)runnersWorldGoAppObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRRunnersWorldGoApp *runnersWorldGoApp = [JRRunnersWorldGoApp runnersWorldGoApp];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        runnersWorldGoApp.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    runnersWorldGoApp.trialStartDate =
        [dictionary objectForKey:@"trialStartDate"] != [NSNull null] ? 
        [JRDate dateFromISO8601DateString:[dictionary objectForKey:@"trialStartDate"]] : nil;

    runnersWorldGoApp.userSettings =
        [dictionary objectForKey:@"userSettings"] != [NSNull null] ? 
        [JRUserSettings userSettingsObjectFromDictionary:[dictionary objectForKey:@"userSettings"] withPath:runnersWorldGoApp.captureObjectPath fromDecoder:fromDecoder] : nil;

    if (fromDecoder)
        [runnersWorldGoApp.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [runnersWorldGoApp.dirtyPropertySet removeAllObjects];

    return runnersWorldGoApp;
}

+ (id)runnersWorldGoAppObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRRunnersWorldGoApp runnersWorldGoAppObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.trialStartDate =
        [dictionary objectForKey:@"trialStartDate"] != [NSNull null] ? 
        [JRDate dateFromISO8601DateString:[dictionary objectForKey:@"trialStartDate"]] : nil;

    if (![dictionary objectForKey:@"userSettings"] || [dictionary objectForKey:@"userSettings"] == [NSNull null])
        self.userSettings = nil;
    else if (!self.userSettings)
        self.userSettings = [JRUserSettings userSettingsObjectFromDictionary:[dictionary objectForKey:@"userSettings"] withPath:self.captureObjectPath fromDecoder:NO];
    else
        [self.userSettings replaceFromDictionary:[dictionary objectForKey:@"userSettings"] withPath:self.captureObjectPath];

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"trialStartDate", @"userSettings", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"runnersWorldGoApp"];

    if (self.userSettings)
        [snapshotDictionary setObject:[self.userSettings snapshotDictionaryFromDirtyPropertySet]
                               forKey:@"userSettings"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"runnersWorldGoApp"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"runnersWorldGoApp"] allObjects]];

    if ([snapshotDictionary objectForKey:@"userSettings"])
        [self.userSettings restoreDirtyPropertiesFromSnapshotDictionary:
                    [snapshotDictionary objectForKey:@"userSettings"]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"trialStartDate"])
        [dictionary setObject:(self.trialStartDate ? [self.trialStartDate stringFromISO8601Date] : [NSNull null]) forKey:@"trialStartDate"];

    if ([self.dirtyPropertySet containsObject:@"userSettings"])
        [dictionary setObject:(self.userSettings ?
                              [self.userSettings toUpdateDictionary] :
                              [[JRUserSettings userSettings] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                       forKey:@"userSettings"];
    else if ([self.userSettings needsUpdate])
        [dictionary setObject:[self.userSettings toUpdateDictionary]
                       forKey:@"userSettings"];

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

    [dictionary setObject:(self.trialStartDate ? [self.trialStartDate stringFromISO8601Date] : [NSNull null]) forKey:@"trialStartDate"];

    [dictionary setObject:(self.userSettings ?
                          [self.userSettings toReplaceDictionary] :
                          [[JRUserSettings userSettings] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                   forKey:@"userSettings"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    if ([self.userSettings needsUpdate])
        return YES;

    return NO;
}

- (BOOL)isEqualToRunnersWorldGoApp:(JRRunnersWorldGoApp *)otherRunnersWorldGoApp
{
    if (!self.trialStartDate && !otherRunnersWorldGoApp.trialStartDate) /* Keep going... */;
    else if ((self.trialStartDate == nil) ^ (otherRunnersWorldGoApp.trialStartDate == nil)) return NO; // xor
    else if (![self.trialStartDate isEqualToDate:otherRunnersWorldGoApp.trialStartDate]) return NO;

    if (!self.userSettings && !otherRunnersWorldGoApp.userSettings) /* Keep going... */;
    else if (!self.userSettings && [otherRunnersWorldGoApp.userSettings isEqualToUserSettings:[JRUserSettings userSettings]]) /* Keep going... */;
    else if (!otherRunnersWorldGoApp.userSettings && [self.userSettings isEqualToUserSettings:[JRUserSettings userSettings]]) /* Keep going... */;
    else if (![self.userSettings isEqualToUserSettings:otherRunnersWorldGoApp.userSettings]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"JRDate" forKey:@"trialStartDate"];
    [dictionary setObject:@"JRUserSettings" forKey:@"userSettings"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
