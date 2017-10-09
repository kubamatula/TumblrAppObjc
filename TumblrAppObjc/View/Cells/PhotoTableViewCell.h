//
//  PhotoTableViewCell.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoTableViewCell : UITableViewCell
@property (nonatomic) UIImageView* photo;

-(void)setPhotoImage: (UIImage *)image;
@end
