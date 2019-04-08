//
//  RectController.m
//  XCCAShaperLayer
//
//  Created by xchuan on 2019/4/8.
//  Copyright © 2019年 xchuan. All rights reserved.
//

#import "RectController.h"

@interface RectController ()

@end

@implementation RectController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 500)];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maskView];
    
    for (NSInteger i = 0; i < 30; i++) {
        
        NSInteger rand = arc4random() % 60 + 10;
        CALayer *layerR = [CALayer layer];
        layerR.frame = CGRectMake(20 + i * 10, 300, 5, 20 + rand);
        layerR.borderColor = [UIColor orangeColor].CGColor;
        layerR.masksToBounds = YES;
        layerR.cornerRadius = 3.0f;
        layerR.borderWidth = 1.0f;
        layerR.backgroundColor = [UIColor orangeColor].CGColor;
        [maskView.layer addSublayer:layerR];
        
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    maskView.transform = CGAffineTransformRotate(transform, M_PI); //旋转180度
}

@end
