//
//  ViewController.h
//  GLKViewTest
//
//  Created by waqu on 2017/8/15.
//  Copyright © 2017年 com.waqu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface ViewController : UIViewController <GLKViewDelegate>

@property (weak, nonatomic) IBOutlet GLKView *glView;

@end

