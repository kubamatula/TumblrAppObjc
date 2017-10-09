//
//  PhotoPostsDetailViewController.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "PhotoPostDetailViewController.h"
#import "Post.h"
#import "Masonry.h"
#import "PhotoTableViewCell.h"

static NSString * const photoCellIdentifier = @"PhotoCell";

@implementation PhotoPostDetailViewController
{
    BOOL loaded[100];
}
-(instancetype)initWithPost:(PhotoPost *)photoPost {
    self = [super init];
    _post = photoPost;
    for (int i = 0; i < 100; i++){
        loaded[i] = false;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableView registerClass: [PhotoTableViewCell class] forCellReuseIdentifier: photoCellIdentifier];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.estimatedRowHeight = 40;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    PhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: photoCellIdentifier forIndexPath: indexPath];
    NSURL *imgUrl = _post.photos[indexPath.row];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL: imgUrl];
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell setPhotoImage:[UIImage imageWithData:data scale:1]];
            if (!loaded[indexPath.row]) {
                loaded[indexPath.row] = true;
                [tableView reloadRowsAtIndexPaths: @[indexPath] withRowAnimation: UITableViewRowAnimationAutomatic];
            }
        });
    });
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return _post.photos.count;
}

@end
