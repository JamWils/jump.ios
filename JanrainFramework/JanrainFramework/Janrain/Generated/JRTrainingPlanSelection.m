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
#import "JRTrainingPlanSelection.h"

@interface JRTrainingPlanSelection ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRTrainingPlanSelection
{
    NSString *_goal;
    JRInteger *_runDays;
    NSString *_runnerLevel;
}
@synthesize canBeUpdatedOnCapture;

- (NSString *)goal
{
    return _goal;
}

- (void)setGoal:(NSString *)newGoal
{
    [self.dirtyPropertySet addObject:@"goal"];

    _goal = [newGoal copy];
}

- (JRInteger *)runDays
{
    return _runDays;
}

- (void)setRunDays:(JRInteger *)newRunDays
{
    [self.dirtyPropertySet addObject:@"runDays"];

    _runDays = [newRunDays copy];
}

- (NSInteger)getRunDaysIntegerValue
{
    return [_runDays integerValue];
}

- (void)setRunDaysWithInteger:(NSInteger)integerVal
{
    [self.dirtyPropertySet addObject:@"runDays"];

    _runDays = [NSNumber numberWithInteger:integerVal];
}

- (NSString *)runnerLevel
{
    return _runnerLevel;
}

- (void)setRunnerLevel:(NSString *)newRunnerLevel
{
    [self.dirtyPropertySet addObject:@"runnerLevel"];

    _runnerLevel = [newRunnerLevel copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/runnersWorld/trainingPlanSelection";
        self.canBeUpdatedOnCapture = YES;


        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)trainingPlanSelection
{
    return [[JRTrainingPlanSelection alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.goal ? self.goal : [NSNull null])
                   forKey:@"goal"];
    [dictionary setObject:(self.runDays ? [NSNumber numberWithInteger:[self.runDays integerValue]] : [NSNull null])
                   forKey:@"runDays"];
    [dictionary setObject:(self.runnerLevel ? self.runnerLevel : [NSNull null])
                   forKey:@"runnerLevel"];

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

+ (id)trainingPlanSelectionObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRTrainingPlanSelection *trainingPlanSelection = [JRTrainingPlanSelection trainingPlanSelection];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        trainingPlanSelection.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    trainingPlanSelection.goal =
        [dictionary objectForKey:@"goal"] != [NSNull null] ? 
        [dictionary objectForKey:@"goal"] : nil;

    trainingPlanSelection.runDays =
        [dictionary objectForKey:@"runDays"] != [NSNull null] ? 
        [NSNumber numberWithInteger:[(NSNumber*)[dictionary objectForKey:@"runDays"] integerValue]] : nil;

    trainingPlanSelection.runnerLevel =
        [dictionary objectForKey:@"runnerLevel"] != [NSNull null] ? 
        [dictionary objectForKey:@"runnerLevel"] : nil;

    if (fromDecoder)
        [trainingPlanSelection.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [trainingPlanSelection.dirtyPropertySet removeAllObjects];

    return trainingPlanSelection;
}

+ (id)trainingPlanSelectionObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRTrainingPlanSelection trainingPlanSelectionObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.goal =
        [dictionary objectForKey:@"goal"] != [NSNull null] ? 
        [dictionary objectForKey:@"goal"] : nil;

    self.runDays =
        [dictionary objectForKey:@"runDays"] != [NSNull null] ? 
        [NSNumber numberWithInteger:[(NSNumber*)[dictionary objectForKey:@"runDays"] integerValue]] : nil;

    self.runnerLevel =
        [dictionary objectForKey:@"runnerLevel"] != [NSNull null] ? 
        [dictionary objectForKey:@"runnerLevel"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"goal", @"runDays", @"runnerLevel", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"trainingPlanSelection"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"trainingPlanSelection"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"trainingPlanSelection"] allObjects]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"goal"])
        [dictionary setObject:(self.goal ? self.goal : [NSNull null]) forKey:@"goal"];

    if ([self.dirtyPropertySet containsObject:@"runDays"])
        [dictionary setObject:(self.runDays ? [NSNumber numberWithInteger:[self.runDays integerValue]] : [NSNull null]) forKey:@"runDays"];

    if ([self.dirtyPropertySet containsObject:@"runnerLevel"])
        [dictionary setObject:(self.runnerLevel ? self.runnerLevel : [NSNull null]) forKey:@"runnerLevel"];

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

    [dictionary setObject:(self.goal ? self.goal : [NSNull null]) forKey:@"goal"];
    [dictionary setObject:(self.runDays ? [NSNumber numberWithInteger:[self.runDays integerValue]] : [NSNull null]) forKey:@"runDays"];
    [dictionary setObject:(self.runnerLevel ? self.runnerLevel : [NSNull null]) forKey:@"runnerLevel"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToTrainingPlanSelection:(JRTrainingPlanSelection *)otherTrainingPlanSelection
{
    if (!self.goal && !otherTrainingPlanSelection.goal) /* Keep going... */;
    else if ((self.goal == nil) ^ (otherTrainingPlanSelection.goal == nil)) return NO; // xor
    else if (![self.goal isEqualToString:otherTrainingPlanSelection.goal]) return NO;

    if (!self.runDays && !otherTrainingPlanSelection.runDays) /* Keep going... */;
    else if ((self.runDays == nil) ^ (otherTrainingPlanSelection.runDays == nil)) return NO; // xor
    else if (![self.runDays isEqualToNumber:otherTrainingPlanSelection.runDays]) return NO;

    if (!self.runnerLevel && !otherTrainingPlanSelection.runnerLevel) /* Keep going... */;
    else if ((self.runnerLevel == nil) ^ (otherTrainingPlanSelection.runnerLevel == nil)) return NO; // xor
    else if (![self.runnerLevel isEqualToString:otherTrainingPlanSelection.runnerLevel]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"NSString" forKey:@"goal"];
    [dictionary setObject:@"JRInteger" forKey:@"runDays"];
    [dictionary setObject:@"NSString" forKey:@"runnerLevel"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
