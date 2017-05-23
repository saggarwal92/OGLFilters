//
//  GLFilterViewController.h
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "GLFilter.h"

typedef NS_ENUM(NSUInteger, GIF_TIMER_SPEED) {
    GIF_TIMER_FAST = 300,
    GIF_TIMER_NORMAL = 600,
    GIF_TIMER_SLOW = 900,
};

@interface GLFilterViewController : GLKViewController

-(void)setCurrentFilter:(GLFilter *)filter;
-(UIImage *)imageToShowInView;

-(UIImage *)getFilteredImage;

@end
