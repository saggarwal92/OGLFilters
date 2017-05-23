//
//  GLOutputReader.h
//  OGLFilters
//
//  Created by shubham on 24/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface GLOutputReader : NSObject

-(id)initWithEAGLContext:(EAGLContext *)context;

-(UIImage *)glOutputFromFrameBuffer:(GLuint)glFrameBuffer forSize:(CGSize)size andOrientation:(UIImageOrientation)orientation;

@end
