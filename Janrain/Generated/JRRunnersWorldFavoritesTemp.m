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
#import "JRRunnersWorldFavoritesTemp.h"

@interface JRRunnersWorldFavoritesTemp ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRRunnersWorldFavoritesTemp
{
    NSString *_favorite_id;
    NSString *_nid;
    NSString *_url;
    NSString *_vid;
}
@synthesize canBeUpdatedOnCapture;

- (NSString *)favorite_id
{
    return _favorite_id;
}

- (void)setFavorite_id:(NSString *)newFavorite_id
{
    [self.dirtyPropertySet addObject:@"favorite_id"];

    _favorite_id = [newFavorite_id copy];
}

- (NSString *)nid
{
    return _nid;
}

- (void)setNid:(NSString *)newNid
{
    [self.dirtyPropertySet addObject:@"nid"];

    _nid = [newNid copy];
}

- (NSString *)url
{
    return _url;
}

- (void)setUrl:(NSString *)newUrl
{
    [self.dirtyPropertySet addObject:@"url"];

    _url = [newUrl copy];
}

- (NSString *)vid
{
    return _vid;
}

- (void)setVid:(NSString *)newVid
{
    [self.dirtyPropertySet addObject:@"vid"];

    _vid = [newVid copy];
}

- (id)init
{
    if ((self = [super init]))
    {
        self.captureObjectPath = @"/temporaryData/runnersWorldFavoritesTemp";
        self.canBeUpdatedOnCapture = YES;


        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)runnersWorldFavoritesTemp
{
    return [[JRRunnersWorldFavoritesTemp alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.favorite_id ? self.favorite_id : [NSNull null])
                   forKey:@"favorite_id"];
    [dictionary setObject:(self.nid ? self.nid : [NSNull null])
                   forKey:@"nid"];
    [dictionary setObject:(self.url ? self.url : [NSNull null])
                   forKey:@"url"];
    [dictionary setObject:(self.vid ? self.vid : [NSNull null])
                   forKey:@"vid"];

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

+ (id)runnersWorldFavoritesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRRunnersWorldFavoritesTemp *runnersWorldFavoritesTemp = [JRRunnersWorldFavoritesTemp runnersWorldFavoritesTemp];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        runnersWorldFavoritesTemp.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
    }

    runnersWorldFavoritesTemp.favorite_id =
        [dictionary objectForKey:@"favorite_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"favorite_id"] : nil;

    runnersWorldFavoritesTemp.nid =
        [dictionary objectForKey:@"nid"] != [NSNull null] ? 
        [dictionary objectForKey:@"nid"] : nil;

    runnersWorldFavoritesTemp.url =
        [dictionary objectForKey:@"url"] != [NSNull null] ? 
        [dictionary objectForKey:@"url"] : nil;

    runnersWorldFavoritesTemp.vid =
        [dictionary objectForKey:@"vid"] != [NSNull null] ? 
        [dictionary objectForKey:@"vid"] : nil;

    if (fromDecoder)
        [runnersWorldFavoritesTemp.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [runnersWorldFavoritesTemp.dirtyPropertySet removeAllObjects];

    return runnersWorldFavoritesTemp;
}

+ (id)runnersWorldFavoritesTempObjectFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRRunnersWorldFavoritesTemp runnersWorldFavoritesTempObjectFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;

    self.favorite_id =
        [dictionary objectForKey:@"favorite_id"] != [NSNull null] ? 
        [dictionary objectForKey:@"favorite_id"] : nil;

    self.nid =
        [dictionary objectForKey:@"nid"] != [NSNull null] ? 
        [dictionary objectForKey:@"nid"] : nil;

    self.url =
        [dictionary objectForKey:@"url"] != [NSNull null] ? 
        [dictionary objectForKey:@"url"] : nil;

    self.vid =
        [dictionary objectForKey:@"vid"] != [NSNull null] ? 
        [dictionary objectForKey:@"vid"] : nil;

    [self.dirtyPropertySet setSet:dirtyPropertySetCopy];
}

- (NSSet *)updatablePropertySet
{
    return [NSSet setWithObjects:@"favorite_id", @"nid", @"url", @"vid", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"runnersWorldFavoritesTemp"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"runnersWorldFavoritesTemp"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"runnersWorldFavoritesTemp"] allObjects]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"favorite_id"])
        [dictionary setObject:(self.favorite_id ? self.favorite_id : [NSNull null]) forKey:@"favorite_id"];

    if ([self.dirtyPropertySet containsObject:@"nid"])
        [dictionary setObject:(self.nid ? self.nid : [NSNull null]) forKey:@"nid"];

    if ([self.dirtyPropertySet containsObject:@"url"])
        [dictionary setObject:(self.url ? self.url : [NSNull null]) forKey:@"url"];

    if ([self.dirtyPropertySet containsObject:@"vid"])
        [dictionary setObject:(self.vid ? self.vid : [NSNull null]) forKey:@"vid"];

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

    [dictionary setObject:(self.favorite_id ? self.favorite_id : [NSNull null]) forKey:@"favorite_id"];
    [dictionary setObject:(self.nid ? self.nid : [NSNull null]) forKey:@"nid"];
    [dictionary setObject:(self.url ? self.url : [NSNull null]) forKey:@"url"];
    [dictionary setObject:(self.vid ? self.vid : [NSNull null]) forKey:@"vid"];

    [self.dirtyPropertySet removeAllObjects];
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (BOOL)needsUpdate
{
    if ([self.dirtyPropertySet count])
         return YES;

    return NO;
}

- (BOOL)isEqualToRunnersWorldFavoritesTemp:(JRRunnersWorldFavoritesTemp *)otherRunnersWorldFavoritesTemp
{
    if (!self.favorite_id && !otherRunnersWorldFavoritesTemp.favorite_id) /* Keep going... */;
    else if ((self.favorite_id == nil) ^ (otherRunnersWorldFavoritesTemp.favorite_id == nil)) return NO; // xor
    else if (![self.favorite_id isEqualToString:otherRunnersWorldFavoritesTemp.favorite_id]) return NO;

    if (!self.nid && !otherRunnersWorldFavoritesTemp.nid) /* Keep going... */;
    else if ((self.nid == nil) ^ (otherRunnersWorldFavoritesTemp.nid == nil)) return NO; // xor
    else if (![self.nid isEqualToString:otherRunnersWorldFavoritesTemp.nid]) return NO;

    if (!self.url && !otherRunnersWorldFavoritesTemp.url) /* Keep going... */;
    else if ((self.url == nil) ^ (otherRunnersWorldFavoritesTemp.url == nil)) return NO; // xor
    else if (![self.url isEqualToString:otherRunnersWorldFavoritesTemp.url]) return NO;

    if (!self.vid && !otherRunnersWorldFavoritesTemp.vid) /* Keep going... */;
    else if ((self.vid == nil) ^ (otherRunnersWorldFavoritesTemp.vid == nil)) return NO; // xor
    else if (![self.vid isEqualToString:otherRunnersWorldFavoritesTemp.vid]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"NSString" forKey:@"favorite_id"];
    [dictionary setObject:@"NSString" forKey:@"nid"];
    [dictionary setObject:@"NSString" forKey:@"url"];
    [dictionary setObject:@"NSString" forKey:@"vid"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
