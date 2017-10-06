//
//  Post.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 06/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Post : NSObject

@property (strong, nonatomic) User* user;
@property (nonatomic) int id;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* body;
@property (strong, nonatomic) NSString* type;
@property (strong, nonatomic) NSDate* date;
@property (strong, nonatomic) NSArray<NSString *> *tags;

@end
