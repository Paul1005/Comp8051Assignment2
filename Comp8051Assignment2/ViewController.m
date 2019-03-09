//
//  ViewController.m
//  Comp8051Assignment2
//
//  Created by Paul on 2019-02-12.
//  Copyright © 2019 Paul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    BridgeFile *bridgeFile;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLKView *view = (GLKView *)self.view;
    [bridgeFile setup:view];
}

- (void)update
{
    [bridgeFile update]; 
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [bridgeFile draw:rect]; // ###
}
@end
