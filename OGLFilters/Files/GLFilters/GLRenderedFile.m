//
//  GLRenderedFile.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "GLRenderedFile.h"

@implementation GLRenderedFile

- (instancetype)initWithFilePath:(NSString *)filePath andLocationName:(NSString *)locationName
{
    self = [super init];
    if (self) {
        _filePath = filePath;
        _glLocationName = locationName;
        _glID = 0;
        _glLocationID = 0;
    }
    return self;
}


@end
