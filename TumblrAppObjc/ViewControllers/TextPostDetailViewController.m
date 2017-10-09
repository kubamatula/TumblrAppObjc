//
//  TextPostDetailViewController.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "TextPostDetailViewController.h"
#import "Masonry.h"
#import "Post.h"

@interface TextPostDetailViewController ()

@property (nonatomic) UITextView *mainTextView;
@property (nonatomic) UILabel *titleLabel;

@end

@implementation TextPostDetailViewController

-(instancetype)initWithPost:(TextPost *)textPost {
    self = [super init];
    _textPost = textPost;
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self setUpUI];
}

-(void)setUpUI{
    _titleLabel = [[UILabel alloc] init];
    [self.view addSubview: _titleLabel];
    _titleLabel.text = [_textPost.title isEqual: [NSNull null]] ? NSLocalizedString(@"Title missing", nil) : _textPost.title;
    [_titleLabel setFont:[_titleLabel.font fontWithSize: 24]];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _mainTextView = [[UITextView alloc] init];
    [self.view addSubview: _mainTextView];
    _mainTextView.attributedText = [[NSAttributedString alloc] initWithData:[_textPost.htmlBody dataUsingEncoding:NSUTF8StringEncoding]
                                                                    options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                              NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                         documentAttributes:nil error:nil];
    _mainTextView.editable = false;
    _mainTextView.selectable = false;
    [_mainTextView setFont:[_mainTextView.font fontWithSize: 18]];
    
    [_mainTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(_titleLabel.mas_bottom);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_mainTextView.mas_left);
        make.right.equalTo(_mainTextView.mas_right);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view.mas_top);
        }
    }];
}


@end
