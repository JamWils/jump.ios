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
#import "JRFavoritesElement.h"

@interface JRFavoritesElement ()
@property BOOL canBeUpdatedOnCapture;
@end

@implementation JRFavoritesElement
{
    NSString *_nid;
    NSString *_site;
    NSString *_url;
    NSString *_vid;
}
@synthesize canBeUpdatedOnCapture;

- (NSString *)nid
{
    return _nid;
}

- (void)setNid:(NSString *)newNid
{
    [self.dirtyPropertySet addObject:@"nid"];

    _nid = [newNid copy];
}

- (NSString *)site
{
    return _site;
}

- (void)setSite:(NSString *)newSite
{
    [self.dirtyPropertySet addObject:@"site"];

    _site = [newSite copy];
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
        self.captureObjectPath      = @"";
        self.canBeUpdatedOnCapture  = NO;


        [self.dirtyPropertySet setSet:[self updatablePropertySet]];
    }
    return self;
}

+ (id)favoritesElement
{
    return [[JRFavoritesElement alloc] init];
}

- (NSDictionary*)newDictionaryForEncoder:(BOOL)forEncoder
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:(self.nid ? self.nid : [NSNull null])
                   forKey:@"nid"];
    [dictionary setObject:(self.site ? self.site : [NSNull null])
                   forKey:@"site"];
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

+ (id)favoritesElementFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath fromDecoder:(BOOL)fromDecoder
{
    if (!dictionary)
        return nil;

    JRFavoritesElement *favoritesElement = [JRFavoritesElement favoritesElement];

    NSSet *dirtyPropertySetCopy = nil;
    if (fromDecoder)
    {
        dirtyPropertySetCopy = [NSSet setWithArray:[dictionary objectForKey:@"dirtyPropertiesSet"]];
        favoritesElement.captureObjectPath = ([dictionary objectForKey:@"captureObjectPath"] == [NSNull null] ?
                                                              nil : [dictionary objectForKey:@"captureObjectPath"]);
        favoritesElement.canBeUpdatedOnCapture = [(NSNumber *)[dictionary objectForKey:@"canBeUpdatedOnCapture"] boolValue];
    }
    else
    {
        favoritesElement.captureObjectPath      = [NSString stringWithFormat:@"%@/%@#%ld", capturePath, @"favorites", (long)[(NSNumber*)[dictionary objectForKey:@"id"] integerValue]];
        favoritesElement.canBeUpdatedOnCapture = YES;
    }

    favoritesElement.nid =
        [dictionary objectForKey:@"nid"] != [NSNull null] ? 
        [dictionary objectForKey:@"nid"] : nil;

    favoritesElement.site =
        [dictionary objectForKey:@"site"] != [NSNull null] ? 
        [dictionary objectForKey:@"site"] : nil;

    favoritesElement.url =
        [dictionary objectForKey:@"url"] != [NSNull null] ? 
        [dictionary objectForKey:@"url"] : nil;

    favoritesElement.vid =
        [dictionary objectForKey:@"vid"] != [NSNull null] ? 
        [dictionary objectForKey:@"vid"] : nil;

    if (fromDecoder)
        [favoritesElement.dirtyPropertySet setSet:dirtyPropertySetCopy];
    else
        [favoritesElement.dirtyPropertySet removeAllObjects];

    return favoritesElement;
}

+ (id)favoritesElementFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    return [JRFavoritesElement favoritesElementFromDictionary:dictionary withPath:capturePath fromDecoder:NO];
}

- (void)replaceFromDictionary:(NSDictionary*)dictionary withPath:(NSString *)capturePath
{
    DLog(@"%@ %@", capturePath, [dictionary description]);

    NSSet *dirtyPropertySetCopy = [self.dirtyPropertySet copy];

    self.canBeUpdatedOnCapture = YES;
    self.captureObjectPath = [NSString stringWithFormat:@"%@/%@#%ld", capturePath, @"favorites", (long)[(NSNumber*)[dictionary objectForKey:@"id"] integerValue]];

    self.nid =
        [dictionary objectForKey:@"nid"] != [NSNull null] ? 
        [dictionary objectForKey:@"nid"] : nil;

    self.site =
        [dictionary objectForKey:@"site"] != [NSNull null] ? 
        [dictionary objectForKey:@"site"] : nil;

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
    return [NSSet setWithObjects:@"nid", @"site", @"url", @"vid", nil];
}

- (void)setAllPropertiesToDirty
{
    [self.dirtyPropertySet addObjectsFromArray:[[self updatablePropertySet] allObjects]];

}

- (NSDictionary *)snapshotDictionaryFromDirtyPropertySet
{
    NSMutableDictionary *snapshotDictionary =
             [NSMutableDictionary dictionaryWithCapacity:10];

    [snapshotDictionary setObject:[self.dirtyPropertySet copy] forKey:@"favoritesElement"];

    return [NSDictionary dictionaryWithDictionary:snapshotDictionary];
}

- (void)restoreDirtyPropertiesFromSnapshotDictionary:(NSDictionary *)snapshotDictionary
{
    if ([snapshotDictionary objectForKey:@"favoritesElement"])
        [self.dirtyPropertySet addObjectsFromArray:[[snapshotDictionary objectForKey:@"favoritesElement"] allObjects]];

}

- (NSDictionary *)toUpdateDictionary
{
    NSMutableDictionary *dictionary =
         [NSMutableDictionary dictionaryWithCapacity:10];

    if ([self.dirtyPropertySet containsObject:@"nid"])
        [dictionary setObject:(self.nid ? self.nid : [NSNull null]) forKey:@"nid"];

    if ([self.dirtyPropertySet containsObject:@"site"])
        [dictionary setObject:(self.site ? self.site : [NSNull null]) forKey:@"site"];

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

    [dictionary setObject:(self.nid ? self.nid : [NSNull null]) forKey:@"nid"];
    [dictionary setObject:(self.site ? self.site : [NSNull null]) forKey:@"site"];
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

- (BOOL)isEqualToFavoritesElement:(JRFavoritesElement *)otherFavoritesElement
{
    if (!self.nid && !otherFavoritesElement.nid) /* Keep going... */;
    else if ((self.nid == nil) ^ (otherFavoritesElement.nid == nil)) return NO; // xor
    else if (![self.nid isEqualToString:otherFavoritesElement.nid]) return NO;

    if (!self.site && !otherFavoritesElement.site) /* Keep going... */;
    else if ((self.site == nil) ^ (otherFavoritesElement.site == nil)) return NO; // xor
    else if (![self.site isEqualToString:otherFavoritesElement.site]) return NO;

    if (!self.url && !otherFavoritesElement.url) /* Keep going... */;
    else if ((self.url == nil) ^ (otherFavoritesElement.url == nil)) return NO; // xor
    else if (![self.url isEqualToString:otherFavoritesElement.url]) return NO;

    if (!self.vid && !otherFavoritesElement.vid) /* Keep going... */;
    else if ((self.vid == nil) ^ (otherFavoritesElement.vid == nil)) return NO; // xor
    else if (![self.vid isEqualToString:otherFavoritesElement.vid]) return NO;

    return YES;
}

- (NSDictionary*)objectProperties
{
    NSMutableDictionary *dictionary =
        [NSMutableDictionary dictionaryWithCapacity:10];

    [dictionary setObject:@"NSString" forKey:@"nid"];
    [dictionary setObject:@"NSString" forKey:@"site"];
    [dictionary setObject:@"NSString" forKey:@"url"];
    [dictionary setObject:@"NSString" forKey:@"vid"];

    return [NSDictionary dictionaryWithDictionary:dictionary];
}

@end
