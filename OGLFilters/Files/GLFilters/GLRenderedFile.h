//
//  GLRenderedFile.h
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>


@interface GLRenderedFile : NSObject
@property (nonatomic,strong) NSString *filePath;
@property (nonatomic,strong) NSString *glLocationName;

@property GLuint glID;
@property GLuint glLocationID;

- (instancetype)initWithFilePath:(NSString *)filePath andLocationName:(NSString *)locationName;

@end
