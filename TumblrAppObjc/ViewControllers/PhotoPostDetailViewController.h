//
//  PhotoPostsDetailViewController.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoPost;

@interface PhotoPostDetailViewController : UITableViewController
@property (nonatomic) PhotoPost *post;

-(instancetype)initWithPost:(PhotoPost *)photoPost;

@end
