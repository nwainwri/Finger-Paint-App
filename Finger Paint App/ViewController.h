//
//  ViewController.h
//  Finger Paint App
//
//  Created by Nathan Wainwright on 2018-08-10.
//  Copyright © 2018 Nathan Wainwright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
//    CGFloat brush;
//    CGFloat opacity;
    BOOL mouseSwiped;
}


@end

