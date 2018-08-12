//
//  ViewController.h
//  Finger Paint App
//
//  Created by Nathan Wainwright on 2018-08-10.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController { //setting ivars
    CGPoint lastPoint; // stores last point drawn on the canvas ; used when a long brush stroke being drawn on canvas
    CGFloat red; // red,green,blue; for setting colours manually for the floats.
    CGFloat green;
    CGFloat blue;
    BOOL mouseSwiped; // for dectecting if mouse/finger stroke is continuous
}


@end

