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
#import "JRRunnersWorld.h"

@interface JRRunnersWorldGoApp (JRRunnersWorldGoApp_InternalMethods)
+ (id)runnersWorldGoAppObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder;
- (BOOL)isEqualToRunnersWorldGoApp:(JRRunnersWorldGoApp *)otherRunnersWorldGoApp;
@end

@interface JRTrainingPlanSelection (JRTrainingPlanSelection_InternalMethods)
+ (id)trainingPlanSelectionObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder;
- (BOOL)isEqualToTrainingPlanSelection:(JRTrainingPlanSelection *)otherTrainingPlanSelection;
@end

@interface JRRunnersWorld ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRRunnersWorld
{
    JRDate *_challengeExpireDate;
    JRBoolean *_runnersWorldGo;
    JRRunnersWorldGoApp *_runnersWorldGoApp;
    NSString *_tags;
    JRTrainingPlanSelection *_trainingPlanSelection;
}
@synthesize canBeUpdatedOnCapture;

- (JRDate *)challengeExpireDate
{
    return _challengeExpireDate;
}

- (void)setChallengeExpireDate:(JRDate *)newChallengeExpireDate
{
    [self.dirtyPropertySet addObject:@"challengeExpireDate"];

    _challengeExpireDate = [newChallengeExpireDate copy];
}

- (JRBoolean *)runnersWorldGo
{
    return _runnersWorldGo;
}

- (void)setRunnersWorldGo:(JRBoolean *)newRunnersWorldGo
{
    [self.dirtyPropertySet addObject:@"runnersWorldGo"];

    _runnersWorldGo = [newRunnersWorldGo copy];
}

- (BOOL)getRunnersWorldGoBoolValue
{
    return [_runnersWorldGo boolValue];
}

- (void)setRunnersWorldGoWithBool:(BOOL)boolVal
{
    [self.dirtyPropertySet addObject:@"runnersWorldGo"];

    _runnersWorldGo = [NSNumber numberWithBool:boolVal];
}

- (JRRunnersWorldGoApp *)runnersWorldGoApp
{
    return _runnersWorldGoApp;
}

- (void)setRunnersWorldGoApp:(JRRunnersWorldGoApp *)newRunnersWorldGoApp
{
    [self.dirtyPropertySet addObject:@"runnersWorldGoApp"];

    _runnersWorldGoApp = newRunnersWorldGoApp;

    [_runnersWorldGoApp setAllPropertiesToDirty];
}

- (NSString *)tags
{
    return _tags;
}

- (void)setTags:(NSString *)newTags
{
    [self.dirtyPropertySet addObject:@"tags"];

    _tags = [newTags copy];
}

- (JRTrainingPlanSelection *)trainingPlanSelection
{
    return _trainingPlanSelection;
}

- (void)setTrainingPlanSelection:(JRTrainingPlanSelection *)newTrainingPlanSelection
{
    [self.dirtyPropertySet addObject:@"trainingPlanSelection"];

    _trainingPlanSelection = newTrainingPlanSelection;

    [_trainingPlanSelection setAllPropertiesToDirty];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/runnersWorld";
        self.canBeUpdatedOnCapture = YES;

        _runnersWorldGoApp = [[JRRunnersWorldGoApp alloc] init];
        _trainingPlanSelection = [[JRTrainingPlanSelection alloc] init];

        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)runnersWorld
{
    return [[JRRunnersWorld alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.challengeExpireDate ? [self.challengeExpireDate stringFromISO8601Date] : [NSNull null])
                   forKey:@"challengeExpireDate"];
    [dictionary setObject:(self.runnersWorldGo ? [NSNumber numberWithBool:[self.runnersWorldGo boolValue]] : [NSNull null])
                   forKey:@"runnersWorldGo"];
    [dictionary setObject:(self.runnersWorldGoApp ? [self.runnersWorldGoApp newDictionaryForEncoder:forEncoder] : [NSNull null])
                   forKey:@"runnersWorldGoApp"];
    [dictionary setObject:(self.tags ? self.tags : [NSNull null])
                   forKey:@"tags"];
    [dictionary setObject:(self.trainingPlanSelection ? [self.trainingPlanSelection newDictionaryForEncoder:forEncoder] : [NSNull null])
                   forKey:@"trainingPlanSelection"];

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

+ (id)runnersWorldObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRRunnersWorld *runnersWorld = [JRRunnersWorld runnersWorld];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        runnersWorld.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    runnersWorld.challengeExpireDate =
        [dictionary objectForKey:@"challengeExpireDate"] != [NSNull null] ? 
        [JRDate dateFromISO8601DateString:[dictionary objectForKey:@"challengeExpireDate"]] : nil;

    runnersWorld.runnersWorldGo =
        [dictionary objectForKey:@"runnersWorldGo"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"runnersWorldGo"] boolValue]] : nil;

    runnersWorld.runnersWorldGoApp =
        [dictionary objectForKey:@"runnersWorldGoApp"] != [NSNull null] ? 
        [JRRunnersWorldGoApp runnersWorldGoAppObjectFromDictionary:[dictionary objectForKey:@"runnersWorldGoApp"] withPath:runnersWorld.captureObjectPath fromDecoder:fromDecoder] : nil;

    runnersWorld.tags =
        [dictionary objectForKey:@"tags"] != [NSNull null] ? 
        [dictionary objectForKey:@"tags"] : nil;

    runnersWorld.trainingPlanSelection =
        [dictionary objectForKey:@"trainingPlanSelection"] != [NSNull null] ? 
        [JRTrainingPlanSelection trainingPlanSelectionObjectFromDictionary:[dictionary objectForKey:@"trainingPlanSelection"] withPath:runnersWorld.captureObjectPath fromDecoder:fromDecoder] : nil;

    if (fromDecoder)
        [runnersWorld.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [runnersWorld.dirtyPropertySet removeAllObjects];

    return runnersWorld;
}

+ (id)runnersWorldObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRRunnersWorld runnersWorldObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.challengeExpireDate =
        [dictionary objectForKey:@"challengeExpireDate"] != [NSNull null] ? 
        [JRDate dateFromISO8601DateString:[dictionary objectForKey:@"challengeExpireDate"]] : nil;

    self.runnersWorldGo =
        [dictionary objectForKey:@"runnersWorldGo"] != [NSNull null] ? 
        [NSNumber numberWithBool:[(NSNumber*)[dictionary objectForKey:@"runnersWorldGo"] boolValue]] : nil;

    if (![dictionary objectForKey:@"runnersWorldGoApp"] || [dictionary objectForKey:@"runnersWorldGoApp"] == [NSNull null])
        self.runnersWorldGoApp = nil;
    else if (!self.runnersWorldGoApp)
        self.runnersWorldGoApp = [JRRunnersWorldGoApp runnersWorldGoAppObjectFromDictionary:[dictionary objectForKey:@"runnersWorldGoApp"] withPath:self.captureObjectPath fromDecoder:NO];
    else
        [self.runnersWorldGoApp replaceFromDictionary:[dictionary objectForKey:@"runnersWorldGoApp"] withPath:self.captureObjectPath];

    self.tags =
        [dictionary objectForKey:@"tags"] != [NSNull null] ? 
        [dictionary objectForKey:@"tags"] : nil;

    if (![dictionary objectForKey:@"trainingPlanSelection"] || [dictionary objectForKey:@"trainingPlanSelection"] == [NSNull null])
        self.trainingPlanSelection = nil;
    else if (!self.trainingPlanSelection)
        self.trainingPlanSelection = [JRTrainingPlanSelection trainingPlanSelectionObjectFromDictionary:[dictionary objectForKey:@"trainingPlanSelection"] withPath:self.captureObjectPath fromDecoder:NO];
    else
        [self.trainingPlanSelection replaceFromDictionary:[dictionary objectForKey:@"trainingPlanSelection"] withPath:self.captureObjectPath];

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"challengeExpireDate", @"runnersWorldGo", @"runnersWorldGoApp", @"tags", @"trainingPlanSelection", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"runnersWorld"];

    if (self.runnersWorldGoApp)
        [snapshotDictionary setObject:[self.runnersWorldGoApp snapshotDictionaryFromDirtyPropertySet]
                               forKey:@"runnersWorldGoApp"];

    if (self.trainingPlanSelection)
        [snapshotDictionary setObject:[self.trainingPlanSelection snapshotDictionaryFromDirtyPropertySet]
                               forKey:@"trainingPlanSelection"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"runnersWorld"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"runnersWorld"] allObjects]];

    if ([snapshotDictionary objectForKey:@"runnersWorldGoApp"])
        [self.runnersWorldGoApp restoreDirtyPropertiesFromSnapshotDictionary:
                    [snapshotDictionary objectForKey:@"runnersWorldGoApp"]];

    if ([snapshotDictionary objectForKey:@"trainingPlanSelection"])
        [self.trainingPlanSelection restoreDirtyPropertiesFromSnapshotDictionary:
                    [snapshotDictionary objectForKey:@"trainingPlanSelection"]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"challengeExpireDate"])
        [dictionary setObject:(self.challengeExpireDate ? [self.challengeExpireDate stringFromISO8601Date] : [NSNull null]) forKey:@"challengeExpireDate"];

    if ([self.dirtyPropertySet containsObject:@"runnersWorldGo"])
        [dictionary setObject:(self.runnersWorldGo ? [NSNumber numberWithBool:[self.runnersWorldGo boolValue]] : [NSNull null]) forKey:@"runnersWorldGo"];

    if ([self.dirtyPropertySet containsObject:@"runnersWorldGoApp"])
        [dictionary setObject:(self.runnersWorldGoApp ?
                              [self.runnersWorldGoApp toUpdateDictionary] :
                              [[JRRunnersWorldGoApp runnersWorldGoApp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                       forKey:@"runnersWorldGoApp"];
    else if ([self.runnersWorldGoApp needsUpdate])
        [dictionary setObject:[self.runnersWorldGoApp toUpdateDictionary]
                       forKey:@"runnersWorldGoApp"];

    if ([self.dirtyPropertySet containsObject:@"tags"])
        [dictionary setObject:(self.tags ? self.tags : [NSNull null]) forKey:@"tags"];

    if ([self.dirtyPropertySet containsObject:@"trainingPlanSelection"])
        [dictionary setObject:(self.trainingPlanSelection ?
                              [self.trainingPlanSelection toUpdateDictionary] :
                              [[JRTrainingPlanSelection trainingPlanSelection] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                       forKey:@"trainingPlanSelection"];
    else if ([self.trainingPlanSelection needsUpdate])
        [dictionary setObject:[self.trainingPlanSelection toUpdateDictionary]
                       forKey:@"trainingPlanSelection"];

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

    [dictionary setObject:(self.challengeExpireDate ? [self.challengeExpireDate stringFromISO8601Date] : [NSNull null]) forKey:@"challengeExpireDate"];
    [dictionary setObject:(self.runnersWorldGo ? [NSNumber numberWithBool:[self.runnersWorldGo boolValue]] : [NSNull null]) forKey:@"runnersWorldGo"];

    [dictionary setObject:(self.runnersWorldGoApp ?
                          [self.runnersWorldGoApp toReplaceDictionary] :
                          [[JRRunnersWorldGoApp runnersWorldGoApp] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                   forKey:@"runnersWorldGoApp"];
    [dictionary setObject:(self.tags ? self.tags : [NSNull null]) forKey:@"tags"];

    [dictionary setObject:(self.trainingPlanSelection ?
                          [self.trainingPlanSelection toReplaceDictionary] :
                          [[JRTrainingPlanSelection trainingPlanSelection] toUpdateDictionary]) /* Use the default constructor to create an empty object */
                   forKey:@"trainingPlanSelection"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    if ([self.runnersWorldGoApp needsUpdate])
        return YES;

    if ([self.trainingPlanSelection needsUpdate])
        return YES;

    return NO;
}

- (BOOL)isEqualToRunnersWorld:(JRRunnersWorld *)otherRunnersWorld
{
    if (!self.challengeExpireDate && !otherRunnersWorld.challengeExpireDate) /* Keep going... */;
    else if ((self.challengeExpireDate == nil) ^ (otherRunnersWorld.challengeExpireDate == nil)) return NO; // xor
    else if (![self.challengeExpireDate isEqualToDate:otherRunnersWorld.challengeExpireDate]) return NO;

    if (!self.runnersWorldGo && !otherRunnersWorld.runnersWorldGo) /* Keep going... */;
    else if ((self.runnersWorldGo == nil) ^ (otherRunnersWorld.runnersWorldGo == nil)) return NO; // xor
    else if (![self.runnersWorldGo isEqualToNumber:otherRunnersWorld.runnersWorldGo]) return NO;

    if (!self.runnersWorldGoApp && !otherRunnersWorld.runnersWorldGoApp) /* Keep going... */;
    else if (!self.runnersWorldGoApp && [otherRunnersWorld.runnersWorldGoApp isEqualToRunnersWorldGoApp:[JRRunnersWorldGoApp runnersWorldGoApp]]) /* Keep going... */;
    else if (!otherRunnersWorld.runnersWorldGoApp && [self.runnersWorldGoApp isEqualToRunnersWorldGoApp:[JRRunnersWorldGoApp runnersWorldGoApp]]) /* Keep going... */;
    else if (![self.runnersWorldGoApp isEqualToRunnersWorldGoApp:otherRunnersWorld.runnersWorldGoApp]) return NO;

    if (!self.tags && !otherRunnersWorld.tags) /* Keep going... */;
    else if ((self.tags == nil) ^ (otherRunnersWorld.tags == nil)) return NO; // xor
    else if (![self.tags isEqualToString:otherRunnersWorld.tags]) return NO;

    if (!self.trainingPlanSelection && !otherRunnersWorld.trainingPlanSelection) /* Keep going... */;
    else if (!self.trainingPlanSelection && [otherRunnersWorld.trainingPlanSelection isEqualToTrainingPlanSelection:[JRTrainingPlanSelection trainingPlanSelection]]) /* Keep going... */;
    else if (!otherRunnersWorld.trainingPlanSelection && [self.trainingPlanSelection isEqualToTrainingPlanSelection:[JRTrainingPlanSelection trainingPlanSelection]]) /* Keep going... */;
    else if (![self.trainingPlanSelection isEqualToTrainingPlanSelection:otherRunnersWorld.trainingPlanSelection]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"JRDate" forKey:@"challengeExpireDate"];
    [dictionary setObject:@"JRBoolean" forKey:@"runnersWorldGo"];
    [dictionary setObject:@"JRRunnersWorldGoApp" forKey:@"runnersWorldGoApp"];
    [dictionary setObject:@"NSString" forKey:@"tags"];
    [dictionary setObject:@"JRTrainingPlanSelection" forKey:@"trainingPlanSelection"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
