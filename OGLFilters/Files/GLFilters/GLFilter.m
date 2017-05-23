//
//  GLFilter.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "GLFilter.h"
#import "GLToolbox.h"

static GLfloat const GL_TEXTURE_IDS[8]={
    GL_TEXTURE1, GL_TEXTURE2, GL_TEXTURE3,
    GL_TEXTURE4, GL_TEXTURE5, GL_TEXTURE6,
    GL_TEXTURE7, GL_TEXTURE8
};

@interface GLFilter()
@property (nonatomic) NSMutableArray *allFiles;
@end

@implementation GLFilter

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"original";
        _shader = @"default_fragment_shader";
        _iconPath = [NSString stringWithFormat:@"filter_%@",_name];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _name = [dict objectForKey:@"name"];
        _shader = [dict objectForKey:@"shader"];
        _iconPath = [NSString stringWithFormat:@"filter_%@",_name];
        
        _allFiles = [NSMutableArray arrayWithCapacity:6];
        
        NSDictionary *fileDict = [dict objectForKey:@"files"];
        for(NSString *key in fileDict){
            NSString *val = [fileDict objectForKey:key];
            GLRenderedFile *file = [[GLRenderedFile alloc] initWithFilePath:val andLocationName:key];
            [_allFiles addObject:file];
        }
        
        
    }
    return self;
}

-(void)linkShadersToProgram:(GLuint)program{
    for(GLRenderedFile *file in _allFiles){
        NSString *name = [NSString stringWithFormat:@"u_%@",file.glLocationName];
        
        file.glLocationID = glGetUniformLocation(program,[name UTF8String]);
        
        //TODO: Change Image Named to
        //ImageWithContentsOfFile
        UIImage *image = [UIImage imageNamed:file.filePath];
        file.glID = [GLToolbox loadImage:image];
        
        [GLToolbox checkGLError:@"loadShaderFile"];
        //TODO: Remove image from memory
    }
}


-(void)renderFiles{
    int index = 0;
    for(GLRenderedFile *file in _allFiles){
        glActiveTexture(GL_TEXTURE_IDS[index]);
        glBindTexture(GL_TEXTURE_2D, file.glID);
        glUniform1i(file.glLocationID, (index+1));
        index += 1;
        [GLToolbox checkGLError:@"renderShaderFile"];
    }
}

@end
