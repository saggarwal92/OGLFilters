//
//  GLFilterViewController.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "GLFilterViewController.h"
#import "TextureRenderer.h"
#import "GLToolbox.h"
#import "GLOutputReader.h"

@interface GLFilterViewController ()<GLKViewControllerDelegate>
@property (nonatomic, strong) TextureRenderer *textureRenderer;
@property (nonatomic, strong) GLFilter *glFilter;
@property (nonatomic, strong) EAGLContext *context;
@end

@implementation GLFilterViewController
{
    GLuint handle;
    BOOL mTextureIsInitialized;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _glFilter = [[GLFilter alloc] init];
    
    //Setup GL Context
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:self.context];
    
    
    GLKView *glkView = (GLKView *)self.view;
    glkView.context = self.context;
    glClearColor(1.0f,1.0f,1.0f,1.0f);  //Clear With White Background
    
    self.textureRenderer = [[TextureRenderer alloc] init];
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCurrentFilter:(GLFilter *)filter{
    _glFilter = filter;
}

-(UIImage *)imageToShowInView{
    return nil;
}

//Pre-Rendering Loading Textures
-(void)glkViewControllerUpdate:(GLKViewController *)controller{
    [self loadTexture];
}


-(void)glkViewController:(GLKViewController *)controller willPause:(BOOL)pause{
    if(pause){
        //Pause Other Things
    }
}

//Final Rendering Done In This Method
-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    //View Size
    [self.textureRenderer updateViewSize:view.drawableWidth :view.drawableHeight];
    //Render Texture for the Filter
    [_textureRenderer renderTexture:handle andFilter:_glFilter];
}


//Load Texture At Index
-(void)loadTexture{
    if(mTextureIsInitialized) return;
    UIImage *image = [self imageToShowInView];
    if(image){
        handle = [self.textureRenderer loadTextureFromImage:image];
        mTextureIsInitialized = YES;
    }
}

-(UIImage *)getFilteredImage{
    //Method Not Working Properly
    NSLog(@"Warning at %s : Method Not Working Properly",__func__);
    GLOutputReader *outputReader = [[GLOutputReader alloc] initWithEAGLContext:self.context];
    return [outputReader glOutputFromFrameBuffer:[self.textureRenderer frameBuffer] forSize:self.view.frame.size andOrientation:UIImageOrientationUp];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
