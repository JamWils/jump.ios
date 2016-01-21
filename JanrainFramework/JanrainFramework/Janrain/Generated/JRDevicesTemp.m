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
#import "JRDevicesTemp.h"

@interface JRDevicesTemp ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRDevicesTemp
{
    NSString *_apns_device_token;
    NSString *_device_id;
    NSString *_ua_channel_id;
}
@synthesize canBeUpdatedOnCapture;

- (NSString *)apns_device_token
{
    return _apns_device_token;
}

- (void)setApns_device_token:(NSString *)newApns_device_token
{
    [self.dirtyPropertySet addObject:@"apns_device_token"];

    _apns_device_token = [newApns_device_token copy];
}

- (NSString *)device_id
{
    return _device_id;
}

- (void)setDevice_id:(NSString *)newDevice_id
{
    [self.dirtyPropertySet addObject:@"device_id"];

    _device_id = [newDevice_id copy];
}

- (NSString *)ua_channel_id
{
    return _ua_channel_id;
}

- (void)setUa_channel_id:(NSString *)newUa_channel_id
{
    [self.dirtyPropertySet addObject:@"ua_channel_id"];

    _ua_channel_id = [newUa_channel_id copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/temporaryData/devicesTemp";
        self.canBeUpdatedOnCapture = YES;


        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)devicesTemp
{
    return [[JRDevicesTemp alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.apns_device_token ? self.apns_device_token : [NSNull null])
                   forKey:@"apns_device_token"];
    [dictionary setObject:(self.device_id ? self.device_id : [NSNull null])
                   forKey:@"device_id"];
    [dictionary setObject:(self.ua_channel_id ? self.ua_channel_id : [NSNull null])
                   forKey:@"ua_channel_id"];

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

+ (id)devicesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRDevicesTemp *devicesTemp = [JRDevicesTemp devicesTemp];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        devicesTemp.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    devicesTemp.apns_device_token =
        [dictionary objectForKey:@"apns_device_token"] != [NSNull null] ? 
        [dictionary objectForKey:@"apns_device_token"] : nil;

    devicesTemp.device_id =
        [dictionary objectForKey:@"device_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"device_id"] : nil;

    devicesTemp.ua_channel_id =
        [dictionary objectForKey:@"ua_channel_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"ua_channel_id"] : nil;

    if (fromDecoder)
        [devicesTemp.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [devicesTemp.dirtyPropertySet removeAllObjects];

    return devicesTemp;
}

+ (id)devicesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRDevicesTemp devicesTempObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.apns_device_token =
        [dictionary objectForKey:@"apns_device_token"] != [NSNull null] ? 
        [dictionary objectForKey:@"apns_device_token"] : nil;

    self.device_id =
        [dictionary objectForKey:@"device_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"device_id"] : nil;

    self.ua_channel_id =
        [dictionary objectForKey:@"ua_channel_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"ua_channel_id"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"apns_device_token", @"device_id", @"ua_channel_id", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"devicesTemp"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"devicesTemp"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"devicesTemp"] allObjects]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"apns_device_token"])
        [dictionary setObject:(self.apns_device_token ? self.apns_device_token : [NSNull null]) forKey:@"apns_device_token"];

    if ([self.dirtyPropertySet containsObject:@"device_id"])
        [dictionary setObject:(self.device_id ? self.device_id : [NSNull null]) forKey:@"device_id"];

    if ([self.dirtyPropertySet containsObject:@"ua_channel_id"])
        [dictionary setObject:(self.ua_channel_id ? self.ua_channel_id : [NSNull null]) forKey:@"ua_channel_id"];

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

    [dictionary setObject:(self.apns_device_token ? self.apns_device_token : [NSNull null]) forKey:@"apns_device_token"];
    [dictionary setObject:(self.device_id ? self.device_id : [NSNull null]) forKey:@"device_id"];
    [dictionary setObject:(self.ua_channel_id ? self.ua_channel_id : [NSNull null]) forKey:@"ua_channel_id"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToDevicesTemp:(JRDevicesTemp *)otherDevicesTemp
{
    if (!self.apns_device_token && !otherDevicesTemp.apns_device_token) /* Keep going... */;
    else if ((self.apns_device_token == nil) ^ (otherDevicesTemp.apns_device_token == nil)) return NO; // xor
    else if (![self.apns_device_token isEqualToString:otherDevicesTemp.apns_device_token]) return NO;

    if (!self.device_id && !otherDevicesTemp.device_id) /* Keep going... */;
    else if ((self.device_id == nil) ^ (otherDevicesTemp.device_id == nil)) return NO; // xor
    else if (![self.device_id isEqualToString:otherDevicesTemp.device_id]) return NO;

    if (!self.ua_channel_id && !otherDevicesTemp.ua_channel_id) /* Keep going... */;
    else if ((self.ua_channel_id == nil) ^ (otherDevicesTemp.ua_channel_id == nil)) return NO; // xor
    else if (![self.ua_channel_id isEqualToString:otherDevicesTemp.ua_channel_id]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"NSString" forKey:@"apns_device_token"];
    [dictionary setObject:@"NSString" forKey:@"device_id"];
    [dictionary setObject:@"NSString" forKey:@"ua_channel_id"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
