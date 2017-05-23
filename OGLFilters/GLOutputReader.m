//
//  GLOutputReader.m
//  OGLFilters
//
//  Created by shubham on 24/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "GLOutputReader.h"


@implementation GLOutputReader

-(id)initWithEAGLContext:(EAGLContext *)context{
    self = [super init];
    if(self){
        [EAGLContext setCurrentContext:context];
    }
    return self;
}

-(UIImage *)glOutputFromFrameBuffer:(GLuint)glFrameBuffer forSize:(CGSize)size andOrientation:(UIImageOrientation)orientation{
    
    size_t sz = size.width * size.height * 4;
    GLvoid *pixels = malloc(sz);
    glBindFramebuffer(GL_FRAMEBUFFER, glFrameBuffer);
    glReadPixels(0, 0, size.width, size.height, GL_RGBA, GL_UNSIGNED_BYTE, pixels);
    
    return [self imageWithGLData:pixels forSize:size orientation:orientation];
}

-(UIImage *)imageWithGLData:(GLvoid *)data forSize:(CGSize)size orientation:(UIImageOrientation)orientation{
    
    size_t sz = size.width * size.height * 4;
    size_t bitsPerColor = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = (size.width * bitsPerPixel)/bitsPerColor;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;

    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, data, sz, NULL);
    CGImageRef cgImage = CGImageCreate(size.width, size.height, bitsPerColor, bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo, provider, NULL, FALSE, kCGRenderingIntentDefault);
    
    CGDataProviderRelease(provider);
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    CGColorSpaceRelease(colorSpace);
    
    free(data);
    
    return image;
    
}






@end
