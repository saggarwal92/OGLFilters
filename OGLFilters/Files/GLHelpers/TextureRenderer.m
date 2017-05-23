//
//  TextureRenderer.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "TextureRenderer.h"
#import "GLToolbox.h"
#import "GLFilter.h"

static GLfloat const TEX_VERTICES[8] = {
    0.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

static GLfloat const POS_VERTICES[8] = {
    -1.0f, -1.0f, 1.0f, -1.0f, -1.0f, 1.0f, 1.0f, 1.0f
};




@interface TextureRenderer
()

// Program Handle
@property (assign, nonatomic) GLuint program;


// Attribute Handles
@property (assign, nonatomic) GLuint aPosition;
// Tex Handle
@property (assign, nonatomic) GLuint aTexCoordHandle;
// Pos Handle
@property (assign, nonatomic) GLuint aPosCoordHandle;


//Input Image Handle
@property (assign, nonatomic) GLuint mUniformTexLocationID;

//GLFilter
@property (nonatomic) GLFilter *mFilter;

//View Params
@property (assign, nonatomic) CGFloat mViewWidth;
@property (assign, nonatomic) CGFloat mViewHeight;

@property (assign, nonatomic) GLuint currentFBO;

@end

@implementation TextureRenderer


-(void)createProgramAndLinkShaders:(GLFilter *)filter{
    if(_mFilter == filter) return;
    _mFilter = filter;
    
    if(_program != 0) [self tearDown];
    
    //Create Program
    _program = [GLToolbox programWithVertexShader:@"default_vertex_shader" fragmentShader:_mFilter.shader];
    [GLToolbox checkGLError:@"glProgram"];
    
    //Attributes
    _mUniformTexLocationID = glGetUniformLocation(_program, "u_Texture");
    _aTexCoordHandle = glGetAttribLocation(_program, "a_TexCoordinate");
    _aPosCoordHandle = glGetAttribLocation(_program, "a_Position");
    
    [_mFilter linkShadersToProgram:_program];
    
}


//returns handle
-(GLuint)loadTextureFromImage:(UIImage *)image{
    
    GLuint handle;
    
    CGColorSpaceRef genericRGBColorspace = CGColorSpaceCreateDeviceRGB();
    GLubyte* imageData = malloc(image.size.width * image.size.height * 4);
    CGContextRef imageContext = CGBitmapContextCreate(imageData, image.size.width, image.size.height, 8, image.size.width * 4, genericRGBColorspace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
    
    //Release Objects
    CGContextRelease(imageContext);
    CGColorSpaceRelease(genericRGBColorspace);
    
    glGenTextures(1, &handle);
    glBindTexture(GL_TEXTURE_2D, handle);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, image.size.width, image.size.height, 0, GL_BGRA, GL_UNSIGNED_BYTE, imageData);
    
    //Initialize Tex Parameters
    [GLToolbox initTexParams];
    
    //Free Image Data
    free(imageData);
    
    return handle;
}

-(GLuint)frameBuffer{
    return self.currentFBO;
}

-(void)renderTexture:(GLuint)texId andFilter:(GLFilter *)filter{
    [self createProgramAndLinkShaders:filter];
    
    //TODO: Write Code To Use and Attach FrameBufferObject
    //    glBindFramebuffer(GL_FRAMEBUFFER, 2);
    
    glUseProgram(_program);
    [GLToolbox checkGLError:@"glUseProgram"];
    
    glViewport(0, 0, _mViewWidth, _mViewHeight);
    [GLToolbox checkGLError:@"glViewPort"];
    
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //Vertex Attributes
    glVertexAttribPointer(_aTexCoordHandle, 2, GL_FLOAT, 0, 0, TEX_VERTICES);
    glEnableVertexAttribArray(_aTexCoordHandle);
    [GLToolbox checkGLError:@"glSetTexCoordinate"];
    
    glVertexAttribPointer(_aPosCoordHandle, 2, GL_FLOAT, 0, 0, POS_VERTICES);
    glEnableVertexAttribArray(_aPosCoordHandle);
    [GLToolbox checkGLError:@"glSetPositionCoordinate"];
    
    //Set The Input Texture
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, texId);
    glUniform1i(_mUniformTexLocationID, 0);
    [GLToolbox checkGLError:@"glBindImageTexture"];
    
    [_mFilter renderFiles];
    
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}


-(void)tearDown{
    glDeleteProgram(_program);
}


-(void)updateViewSize:(CGFloat)viewWidth :(CGFloat)viewHeight{
    _mViewWidth = viewWidth;
    _mViewHeight = viewHeight;
}
@end
