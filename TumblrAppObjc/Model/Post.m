//
//  Post.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 06/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "Post.h"

//self.postID = (NSUInteger)[[attributes valueForKeyPath:@"id"] integerValue];
//self.text = [attributes valueForKeyPath:@"text"];

@implementation Post

-(instancetype) initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    self.id = [[attributes valueForKeyPath:@"id"] integerValue];
    self.slug = [attributes valueForKeyPath:@"slug"];
    NSString *type = [attributes valueForKeyPath:@"type"];
    if ([type isEqualToString:@"regular"]){
        self.type = PostTypeText;
    } else if ([type isEqualToString:@"photo"]){
        self.type = PostTypePhoto;
    } else {
        self.type = PostTypeOther;
    }
    NSInteger epochTime = [[attributes valueForKeyPath:@"unix-timestamp"] integerValue];
    self.date = [NSDate dateWithTimeIntervalSince1970: epochTime];
    NSArray *tags = [attributes valueForKey:@"tags"];
    self.tags = tags;
    return self;
}

+(NSArray<Post *> *)postsWith:(NSArray *)postDictionaries {
    NSMutableArray<Post *> *posts = [@[] mutableCopy];
    for (NSDictionary *postDictionary in postDictionaries) {
        NSString *type = [postDictionary valueForKeyPath:@"type"];
        if ([type isEqualToString: @"regular"]) {
            [posts addObject: [[TextPost alloc] initWithAttributes: postDictionary]];
        } else if ([type isEqualToString: @"photo"]) {
            [posts addObject: [[PhotoPost alloc] initWithAttributes: postDictionary]];
        } else {
            [posts addObject: [[Post alloc] initWithAttributes: postDictionary]];
        }
    }
    return posts;
}



@end

@implementation TextPost

-(instancetype) initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes: attributes];
    self.title = [attributes valueForKey:@"regular-title"];
    self.htmlBody = [attributes valueForKey:@"regular-body"];
    return self;
}

@end

@implementation PhotoPost

-(instancetype) initWithAttributes:(NSDictionary *)attributes {
    self = [super initWithAttributes: attributes];
    self.caption = [attributes valueForKey:@"photo-caption"];
    NSArray *photoArray = [attributes valueForKey:@"photos"];
    NSMutableArray *photos = [@[] mutableCopy];
    for (NSDictionary *photo in photoArray) {
        [photos addObject: [NSURL URLWithString: [photo valueForKey: @"photo-url-500"]]];
    }
    NSURL *photoUrl = [NSURL URLWithString: [attributes valueForKey: @"photo-url-500"]];
    if (![photos containsObject: photoUrl]){
        [photos addObject: photoUrl];
    }
    self.photos = photos;
    return self;
}

@end
