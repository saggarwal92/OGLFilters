//
//  GLToolbox.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "GLToolbox.h"

@implementation GLToolbox

#pragma mark - Compile & Link
+ (GLuint)programWithVertexShader:(NSString*)vsh fragmentShader:(NSString*)fsh {
    // Build shaders
    GLuint vertexShader = [GLToolbox shaderWithName:vsh type:GL_VERTEX_SHADER];
    GLuint fragmentShader = [GLToolbox shaderWithName:fsh type:GL_FRAGMENT_SHADER];
    
    // Create program
    GLuint programHandle = glCreateProgram();
    
    // Attach shaders
    glAttachShader(programHandle, vertexShader);
    [GLToolbox checkGLError:@"glAttachShader"];
    glAttachShader(programHandle, fragmentShader);
    [GLToolbox checkGLError:@"glAttachShader"];
    
    // Link program
    glLinkProgram(programHandle);
    
    // Check for errors
    GLint linkSuccess;
    glGetProgramiv(programHandle, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[1024];
        glGetProgramInfoLog(programHandle, sizeof(messages), 0, &messages[0]);
        NSLog(@"%@:- GLSL Program Error: %s", [self class], messages);
    }
    
    // Delete shaders
    //    glDeleteShader(vertexShader);
    //    glDeleteShader(fragmentShader);
    
    return programHandle;
}

+ (GLuint)shaderWithName:(NSString*)name type:(GLenum)type {
    // Load the shader file
    NSString* file;
    if (type == GL_VERTEX_SHADER) {
        file = [[NSBundle mainBundle] pathForResource:name ofType:@"vsh"];
    } else if (type == GL_FRAGMENT_SHADER) {
        file = [[NSBundle mainBundle] pathForResource:name ofType:@"glsl"];
    }
    
    // Create the shader source
    const GLchar* source = (GLchar*)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    //    printf("%s",source);
    
    // Create the shader object
    GLuint shaderHandle = glCreateShader(type);
    // Load the shader source
    glShaderSource(shaderHandle, 1, &source, 0);
    // Compile the shader
    glCompileShader(shaderHandle);
    
    // Check for errors
    GLint compileSuccess;
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[1024];
        glGetShaderInfoLog(shaderHandle, sizeof(messages), 0, &messages[0]);
        NSLog(@"%@:- GLSL Shader Error: %s", [self class], messages);
        glDeleteShader(shaderHandle);
    }
    
    
    return shaderHandle;
}


+ (GLuint)loadImage:(UIImage *)image{
    //Convert Image to Data
    GLubyte* imageData = malloc(image.size.width * image.size.height * 4);
    CGColorSpaceRef genericRGBColorspace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef imageContext = CGBitmapContextCreate(imageData, image.size.width, image.size.height, 8, image.size.width * 4, genericRGBColorspace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(imageContext, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
    
    //Release Objects
    CGContextRelease(imageContext);
    CGColorSpaceRelease(genericRGBColorspace);
    
    //load into texture
    GLuint textureHandle;
    glGenTextures(1, &textureHandle);
    glBindTexture(GL_TEXTURE_2D, textureHandle);
    [GLToolbox checkGLError:@"glTextureHandle"];
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, image.size.width, image.size.height, 0, GL_BGRA, GL_UNSIGNED_BYTE, imageData);
    [GLToolbox checkGLError:@"glTexImage2D"];
    
    [GLToolbox initTexParams];
    
    //Free Image Data
    free(imageData);
    
    return textureHandle;
}

+(void)checkGLError:(NSString *)op{
    int error;
    while((error = glGetError()) != GL_NO_ERROR){
        [NSException raise:@"GLError" format:@"%@ error: %d",op,error];
    }
}


+ (void) initTexParams{
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
}

@end
