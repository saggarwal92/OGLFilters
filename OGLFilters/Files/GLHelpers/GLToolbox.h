//
//  GLToolbox.h
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface GLToolbox : NSObject
+ (GLuint)programWithVertexShader:(NSString*)vsh fragmentShader:(NSString*)fsh;
+ (GLuint)shaderWithName:(NSString*)name type:(GLenum)type;
+ (GLuint)loadImage:(UIImage *)image;
+ (void) initTexParams;
+(void)checkGLError:(NSString *)op;
@end
