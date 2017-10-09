//
//  PostsDataSource.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class TumblrAPIClient;
@class Post;

@protocol PostsDataSourceDelegate <NSObject>
@required
-(void)selectedPost: (Post *)post;
@end

@interface PostsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, readonly) TumblrAPIClient *tumblrApi;
@property (nonatomic, weak) id<PostsDataSourceDelegate> delegate;

-(instancetype)initWithTumblrApi: (TumblrAPIClient *) tumblrApi tableView: (UITableView *) tableView delegate: (id<PostsDataSourceDelegate>) delegate;
-(void)fetchPostsForUser:(NSString *)username offset:(NSInteger) offset;
@end
