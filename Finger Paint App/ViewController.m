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

// USED THIS TUTORIAL :: https://www.raywenderlich.com/2862-how-to-make-a-simple-drawing-app-with-uikit


//READINGS FOR ASSIGNMENT
//https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/HandlingImages/Images.html#//apple_ref/doc/uid/TP40010156-CH13-SW8
//https://developer.apple.com/documentation/uikit/uiresponder#//apple_ref/occ/cl/UIResponder
//https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_paths/dq_paths.html
//https://developer.apple.com/documentation/uikit/uibezierpath




@implementation ViewController

- (void)viewDidLoad
{
        // initializes colour to black at start
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;

    [super viewDidLoad];
}

// below methods come from UIResponder; used in response to touches involved with finger/mouse movements; used for drawing logic/implementing the 'drawing' of lines.



// below ensures lastpoint float is 'saved' to current touch point; ie when pen touches paper.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}


// returns current finger/mouse touch spot; then draws line from the last point float to the current touch float; colour is initially black; BUT if different colour picked from
// the colour buttons, colour changes.
// lines made are short enough to look "smooth"


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    
    UIGraphicsBeginImageContext(self.tempDrawImage.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height)];
    
    // drawing line here
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    //sets up line width/colour; would also use this are to set opacity and width if you wanted smaller/bigger brushes.
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    // this finalizes the path and "draws" it,
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // sets the temp image to the main image.
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:1.0];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}



// this will check if the mouse was swiped; if so; draw a line; if not detects just a tap, and draws a single point
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);

        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // merges the tmep drawing imageview, into the main image view; useful if you had a brush that did opacity
    UIGraphicsBeginImageContext(self.drawAreaForUser.frame.size);
    [self.drawAreaForUser.image drawInRect:CGRectMake(0, 0, self.drawAreaForUser.frame.size.width, self.drawAreaForUser.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.tempDrawImage.frame.size.width, self.tempDrawImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.drawAreaForUser.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

// handy spot for finding RGB values to set different colours; https://www.rapidtables.com/web/color/RGB_Color.html




// below manually set the float values for RGB, making new colours
- (IBAction)redColourChosen:(UIButton *)sender {
//     set pointer colour to red
    red = 255.0/0.0;
    green = 0.0/0.0;
    blue = 0.0/0.0;
    
}

- (IBAction)blueColourChosen:(id)sender {
//     set pointer colour to blue
    red = 0.0/0.0;
    green = 0.0/0.0;
    blue = 255.0/0.0;
}

- (IBAction)greenColourChosen:(id)sender {
//     set pointer colour to green
    red = 0.0/0.0;
    green = 255.0/0.0;
    blue = 0.0/0.0;
}

- (IBAction)blackColourChosen:(id)sender {
//        set colour to black
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
}


// just sets the pointer colour to white
// unsure at this time how to 'delete' each line by line.

// would probably need to save all lines into an array, then go thru it and delete them

- (IBAction)eraserButtonChosen:(id)sender {
//     set pointer colour to white
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    
}


// resets the main image area to "nil" effetively clearing the area for a fresh one.
- (IBAction)clearDrawingArea:(id)sender {
    self.drawAreaForUser.image = nil;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
