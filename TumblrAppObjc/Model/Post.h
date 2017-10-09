//
//  Post.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 06/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef enum : NSUInteger {
    PostTypeText,
    PostTypePhoto,
    PostTypeOther
} PostType;

@interface Post : NSObject

@property (nonatomic) User* user;
@property (nonatomic) NSInteger id;
@property (nonatomic) NSString* slug;
@property (nonatomic) PostType type;
@property (nonatomic) NSDate* date;
@property (nonatomic) NSArray<NSString *> *tags;

-(instancetype)initWithAttributes:(NSDictionary *)attributes;
+(NSArray<Post *> *)postsWith:(NSArray *)postDictionaries;
@end


@interface TextPost : Post

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* htmlBody;

@end

@interface PhotoPost : Post

@property (nonatomic, strong) NSString* caption;
@property (nonatomic, strong) NSArray<NSURL *> *photos;

@end
