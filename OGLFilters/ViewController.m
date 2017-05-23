//
//  ViewController.m
//  OGLFilters
//
//  Created by shubham on 23/05/17.
//  Copyright © 2017 Sort. All rights reserved.
//

#import "ViewController.h"
#import "GLFilter.h"

@interface ViewController ()
@property (nonatomic, strong) GLFilter *noFilter;
@property (nonatomic, strong) GLFilter *filter1;
@property (nonatomic, strong) GLFilter *filter2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _noFilter = [[GLFilter alloc] init];
    
    NSDictionary *filterDict_1 = @{
                                 @"name":@"Filter 1",
                                 @"shader":@"vigenette_filter_shader",
                                 @"files":@{
                                            @"Map":@"map.png"           //Location in Shader: u_Map
                                         }
                                 };
    
    NSDictionary *filterDict_2 = @{
                                    @"name":@"Filter 2",
                                    @"shader":@"noob_filter_shader",
                                    @"files":@{
                                        @"Blowout" : @"blowout.png",    //Location in Shader: u_Blowout
                                        @"Overlay" : @"overlay.png",    //Location in Shader: u_Overlay
                                        @"Map" : @"map_2.png",          //Location in Shader: u_Map
                                        }
                                    };
    
    /**
        To Add Custom Filter, follow these steps
         1. Simply create your shader file
         2. You may be using blowouts, maps, overlay, curveshift, luma, process or any name, simply add those file in resources
         3. Create a Dictionary of filter similar to above one
             Format:
                    { 
                        @"name" : @"Filter Name",   //Following Variable is not used
                        @"shader" : @"GLFilter Fragment Shader File with Extension glsl" //This is the shader of the photo filter where the main filter logic resides
                        @"files":@{
                                @"key_1" : @"filename.png", //To access the file in shader, it's location will be: u_key_1
                                @"key_2" : @"filename.png", //To access the file in shader, it's location will be: u_key_2
                                //more keys if required
                        }
                    }
     
     **/
    
    _filter1 = [[GLFilter alloc] initWithDictionary:filterDict_1];
    _filter2 = [[GLFilter alloc] initWithDictionary:filterDict_2];
    
    [self setCurrentFilter:_filter1];
}


- (IBAction)showOriginal:(id)sender {
    [self setCurrentFilter:_noFilter];
}

- (IBAction)applyFilter:(id)sender {
    [self setCurrentFilter:_filter1];
}

- (IBAction)applyFilter2:(id)sender {
    [self setCurrentFilter:_filter2];
    
//    UIImage *image = [self getFilteredImage];
//    
//    NSLog(@"Got Image");
    
}

-(UIImage *)imageToShowInView{
    return [UIImage imageNamed:@"poster.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
