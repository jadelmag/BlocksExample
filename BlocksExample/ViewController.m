//
//  ViewController.m
//  BlocksExample
//
//  Created by Javier Delgado on 09/08/13.
//  Copyright (c) 2013 Javier Delgado. All rights reserved.
//

#import "ViewController.h"
#import "Download.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadArrays];
    
    [self downloadImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadArrays
{
    NSLog(@"Loading info...");
    array1 = [NSArray arrayWithObjects:@"Blue Blocks",@"http://fc05.deviantart.net/fs70/i/2012/168/9/d/blue_blocks_wallpaper_1920_x_1200_by_ryanr08-d53vdxh.png", nil];
    array2 = [NSArray arrayWithObjects:@"Extruded blocks",@"http://fc00.deviantart.net/fs71/f/2011/029/3/6/extruded_blocks_wallpaper_by_spin86-d38bcxl.png", nil];
    array3 = [NSArray arrayWithObjects:@"3D Blocks",@"http://www.thewallpapers.org/photo/26105/3d-blocks.jpg", nil];
    array4 = [NSArray arrayWithObjects:@"Ubuntu Cubes",@"http://wallpapersus.com/wp-content/uploads/2012/05/3D-blocks-Linux-Ubuntu-cubes.jpg", nil];
    array5 = [NSArray arrayWithObjects:@"Dizzy Blocks",@"http://www.scenicreflections.com/files/Dizzy_Blocks_Wallpaper_uq2zg.jpg", nil];
    array6 = [NSArray arrayWithObjects:@"Green Blocks",@"http://m.flikie.com/ImageData/WallPapers/db0ccd211ee84e45863369aede8422d5.jpg", nil];
    
    arrayImages = [NSArray arrayWithObjects:array1,array2,array3,array4,array5,array6, nil];
    NSLog(@"Info Loaded!!");
}

- (void)downloadImages
{
    __weak ViewController *weakController = self;

    for (NSArray *array in arrayImages)
    {
        [Download downloadWithURL:[array objectAtIndex:1] completionBlock:^(NSData *data) {
            // Success
            [weakController saveImageWithData:data withName:[array objectAtIndex:0]];
            NSLog(@"Image \"%@\" saved in App Folder.",[array objectAtIndex:0]);
        } errorBlock:^(NSError *error) {
            // Fail
            NSLog(@"Image \"%@\" not downloaded", [array objectAtIndex:0]);
        }];
    }
}

- (void)saveImageWithData:(NSData *)data withName:(NSString *)name
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.jpg",name]];
    [data writeToFile:path atomically:YES];
}

@end
