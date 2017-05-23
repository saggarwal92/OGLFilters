# OGLFilters

Simple GLFilterViewController allows you to easily add Photo Filters in your application.

# TO ADD INTO YOUR PROJECT 
JUST COPY THE FOLDER NAMED "Files"
Simply extend your current viewcontroller like this

@interface YourViewController : GLFilterViewController
@end

and override the function returning the image you would like to use to apply filter
-(UIImage * )imageToShowInView;

Depending on your requirements, you may also add your *YourViewController* in a container and set it's custom size(default is screen size)


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
     


# SAMPLE FILTER INCLUDED IN THE APPLICATION
NSDictionary * filterDict = @{
                                    @"name":@"Filter 2",
                                    @"shader":@"noob_filter_shader",
                                    @"files":@{
                                        @"Blowout" : @"blowout.png",    //Location in Shader: u_Blowout
                                        @"Overlay" : @"overlay.png",    //Location in Shader: u_Overlay
                                        @"Map" : @"map_2.png",          //Location in Shader: u_Map
                                        }
                                    };
GLFilter * filter = [[GLFilter alloc] initWithDictionary:filterDict];
[YourViewController setCurrentFilter:filter]; 
and you are done.

Happy Coding!
