//
//  ViewController.m
//  TXVImageProgressView
//
//  Created by Tran Viet on 7/10/15.
//  Copyright (c) 2015 Viettranx. All rights reserved.
//

#import "ViewController.h"
#import "VTXImageProgressView.h"

@interface ViewController ()
{
    CGFloat progress;
}

@property (weak, nonatomic) IBOutlet VTXImageProgressView *imgProgressView;
@property (weak, nonatomic) IBOutlet VTXImageProgressView *imgProgressView2;
@property (weak, nonatomic) IBOutlet VTXImageProgressView *imgProgressView3;
@property (weak, nonatomic) IBOutlet VTXImageProgressView *imgProgressView4;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startProgress:(id)sender {
    progress = 0;
    [self increaseProgess];
    //[self.imgProgressView setProgress:40];
}

-(void)increaseProgess
{
    [self.imgProgressView setProgress:progress];
    [self.imgProgressView2 setProgress:progress];
    [self.imgProgressView3 setProgress:progress];
    [self.imgProgressView4 setProgress:progress];
    
    if (progress<100)
    {
        [self performSelector:@selector(increaseProgess) withObject:nil afterDelay: 0.02];
        progress++;
    }
    
}

@end
