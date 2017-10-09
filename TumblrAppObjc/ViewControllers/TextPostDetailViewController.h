//
//  TextPostDetailViewController.h
//  TumblrAppObjc
//
//  Created by Jakub Matuła on 08/10/2017.
//  Copyright © 2017 Jakub Matuła. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextPost;

@interface TextPostDetailViewController : UIViewController
@property (nonatomic) TextPost *textPost;

-(instancetype)initWithPost:(TextPost *)textPost;

@end
