//
//  TextureRenderer.h
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLFilter.h"

@interface TextureRenderer : NSObject

-(GLuint)frameBuffer;

-(void)updateViewSize:(CGFloat)viewWidth :(CGFloat)viewHeight;
-(GLuint)loadTextureFromImage:(UIImage *)image;
-(void)renderTexture:(GLuint)texId andFilter:(GLFilter *)filter;

@end
