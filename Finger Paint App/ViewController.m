//
//  ViewController.m
//  Finger Paint App
//
//  Created by Nathan Wainwright on 2018-08-10.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *drawAreaForUser; //main image

@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage; // temp area for drawing, once drawing done, merged into main image area

@end

@implementation ViewController

- (void)viewDidLoad
{
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
//    brush = 10.0;
//    opacity = 1.0;

    
    
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:1.0];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
//        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.drawAreaForUser.frame.size);
    [self.drawAreaForUser.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.drawAreaForUser.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

- (IBAction)redColourChosen:(UIButton *)sender {
    // set pointer colour to red
}

- (IBAction)blueColourChosen:(id)sender {
    // set pointer colour to blue
}

- (IBAction)greenColourChosen:(id)sender {
    // set pointer colour to green
    
}

- (IBAction)eraserButtonChosen:(id)sender {
    // set pointer colour to white
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
