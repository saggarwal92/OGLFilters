//
//  GLFilter.h
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLRenderedFile.h"
#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@interface GLFilter : NSObject

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *shader;
@property (nonatomic,readonly) NSString *iconPath;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

-(void)linkShadersToProgram:(GLuint)program;
-(void)renderFiles;

@end
