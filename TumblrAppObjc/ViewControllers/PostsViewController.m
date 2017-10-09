//
//  PostsViewController.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "PostsViewController.h"
#import "Masonry.h"
#import "PostsDataSource.h"
#import "TumblrAPIClient.h"
#import "PostTableViewCell.h"
#import "TextPostDetailViewController.h"
#import "PhotoPostDetailViewController.h"

@interface PostsViewController() <PostsDataSourceDelegate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) PostsDataSource *postsDataSource;
@property (nonatomic) UITextField *usernameText;
@property (nonatomic) UIButton *searchForPostsButton;
@end

@implementation PostsViewController
{
    NSInteger offset;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    offset = 0;
    [self setUpUI];
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _postsDataSource = [[PostsDataSource alloc] initWithTumblrApi: [TumblrAPIClient sharedClient] tableView: _tableView delegate: self];
    _tableView.dataSource = _postsDataSource;
    _tableView.delegate = _postsDataSource;
}

-(void)setUpUI{
    self.title = NSLocalizedString(@"Posts", nil);
    _tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStylePlain];
    [self.view addSubview: _tableView];
    
    _usernameText = [[UITextField alloc] init];
    _usernameText.placeholder = @"username";
    [self.view addSubview: _usernameText];
    
    _searchForPostsButton = [[UIButton alloc] init];
    [_searchForPostsButton setTitle: NSLocalizedString(@"Search for Posts", nil) forState: UIControlStateNormal];
    [self.view addSubview: _searchForPostsButton];
    
    [_searchForPostsButton addTarget: self action: @selector(searchForPosts) forControlEvents: UIControlEventTouchUpInside];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [_usernameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_tableView.mas_left).offset(20);
        make.right.equalTo(_tableView.mas_right).offset(-20);
        make.height.equalTo(@40);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(8);
        } else {
            make.top.equalTo(self.view.mas_top).offset(8);
        }
    }];
    
    [_searchForPostsButton setContentEdgeInsets: UIEdgeInsetsMake(8, 24, 8, 24)];
    [_searchForPostsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_usernameText.mas_centerX);
        make.top.equalTo(_usernameText.mas_bottom).offset(8);
        make.bottom.equalTo(_tableView.mas_top).offset(-8);
    }];
}


-(void)searchForPosts {
    NSString *username = _usernameText.text;
    offset = 0;
    [_postsDataSource fetchPostsForUser: username offset: offset];
}

-(void)selectedPost:(Post *)post {
    UIViewController *viewController;
    UIAlertController* alert;
    switch (post.type) {
        case PostTypeText:
            viewController = [[TextPostDetailViewController alloc] initWithPost: (TextPost *)post];
            break;
        case PostTypePhoto:
            viewController = [[PhotoPostDetailViewController alloc] initWithPost: (PhotoPost *)post];
            break;
        case PostTypeOther:
            alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Only regular and photo posts supported", nil) preferredStyle: UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
    }
    [self.navigationController pushViewController:viewController animated: true];
}



@end
