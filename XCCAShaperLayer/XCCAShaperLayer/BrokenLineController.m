//
//  BrokenLineController.m
//  XCCAShaperLayer
//
//  Created by xchuan on 2019/4/8.
//  Copyright © 2019年 xchuan. All rights reserved.
//

#import "BrokenLineController.h"


#define Height self.view.bounds.size.height / 2.0f

@interface BrokenLineController ()

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *midLineLayer;

@end

@implementation BrokenLineController


- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineWidth = 1.0f;
        _lineLayer.fillColor = nil;
        _lineLayer.strokeColor = [UIColor orangeColor].CGColor;
        [self.view.layer addSublayer:_lineLayer];
    }
    return _lineLayer;
}

- (CAShapeLayer *)midLineLayer {
    if (!_midLineLayer) {
        _midLineLayer = [CAShapeLayer layer];
        _midLineLayer.lineWidth = 1.0f;
        _midLineLayer.fillColor = nil;
        _midLineLayer.strokeColor = [UIColor redColor].CGColor;
        [self.view.layer addSublayer:_midLineLayer];
    }
    return _midLineLayer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(20, Height)];
    for (NSInteger i = 0; i < 40; i++) {
        NSInteger rand = arc4random() % 100;
        if (i % 2 == 0) {
            [path addLineToPoint:CGPointMake(20 + 10 * i, Height + rand)];
        }else{
            [path addLineToPoint:CGPointMake(20 + 10 * i, Height - rand)];
        }
    }
    self.lineLayer.path = path.CGPath;
    
    UIBezierPath *midPath = [UIBezierPath bezierPath];
    [midPath moveToPoint:CGPointMake(20, Height )];
    [midPath addLineToPoint:CGPointMake(self.view.bounds.size.width - 20, Height)];
    self.midLineLayer.path = midPath.CGPath;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
