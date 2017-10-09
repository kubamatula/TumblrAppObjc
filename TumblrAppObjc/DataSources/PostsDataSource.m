//
//  PostsDataSource.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "PostsDataSource.h"
#import "TumblrAPIClient.h"
#import "PostTableViewCell.h"

static NSString * const postCellIdentifier = @"PostCell";

@interface PostsDataSource ()
@property (readwrite, nonatomic) NSArray<Post *> *posts;
@property (readonly, nonatomic) UITableView *tableView;
@end

@implementation PostsDataSource

-(instancetype)initWithTumblrApi: (TumblrAPIClient *) tumblrApi tableView: (UITableView *) tableView delegate: (id<PostsDataSourceDelegate>) delegate {
    self = [super init];
    _tumblrApi = tumblrApi;
    _tableView = tableView;
    _delegate = delegate;
    [_tableView registerClass: [PostTableViewCell class] forCellReuseIdentifier: postCellIdentifier];
    return self;
}

-(void)fetchPostsForUser:(NSString *)username offset:(NSInteger) offset {
    [_tumblrApi fetchPostsForUser: username offset: offset withBlock: ^(NSArray<Post *> *posts, NSError *error) {
        self.posts = posts;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: postCellIdentifier
                                                            forIndexPath:indexPath];
    Post *post = _posts[indexPath.row];
    NSString *title = post.slug.length > 0 ? post.slug : [NSString stringWithFormat: @"Post with id: %ld", (long)post.id];
    cell.textLabel.text = title;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _posts.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_delegate selectedPost: _posts[indexPath.row]];
}

@end


