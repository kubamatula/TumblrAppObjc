//
//  PhotoTableViewCell.m
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import "PhotoTableViewCell.h"
#import "Masonry.h"

@interface PhotoTableViewCell ()

@property (nonatomic) UIActivityIndicatorView* spinner;
@property (nonatomic) MASViewConstraint *photoHeightConstraint;
@property (nonatomic) MASViewConstraint *spinnerHeightConstraint;
@end

@implementation PhotoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _photo = [[UIImageView alloc] init];
    _photo.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview: _photo];
    _spinner = [[UIActivityIndicatorView alloc] init];
    _spinner.hidesWhenStopped = true;
    [self addSubview: _spinner];
    [_spinner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_spinner startAnimating];
    [_spinner setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge];
    [_spinner setColor: [UIColor redColor]];
    return self;
}

-(void)setPhotoImage: (UIImage *)image{
    _photo.image = image;
    CGFloat heightToWidth = image.size.height/image.size.width;
    [_spinner stopAnimating];
    [_spinner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_photo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.height.equalTo(_photo.mas_width).multipliedBy(heightToWidth);
    }];
    [self setNeedsLayout];
    [self setNeedsUpdateConstraints];
}

-(void)prepareForReuse{
    [super prepareForReuse];
    _photo.image = nil;
    [_spinner startAnimating];
}

@end
