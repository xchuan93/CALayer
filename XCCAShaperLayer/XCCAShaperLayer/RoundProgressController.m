//
//  RoundProgressController.m
//  XCCAShaperLayer
//
//  Created by xchuan on 2019/4/8.
//  Copyright © 2019年 xchuan. All rights reserved.
//

#import "RoundProgressController.h"

@interface RoundProgressController ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) UIBezierPath *progressPath;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) CADisplayLink *timer;

@end

@implementation RoundProgressController


- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150/2.0f startAngle:0 endAngle:M_PI * 2 clockwise:YES];
        _trackLayer = [CAShapeLayer new];
        _trackLayer.fillColor = nil;
        _trackLayer.strokeColor = [UIColor grayColor].CGColor;
        _trackLayer.lineWidth = 2.0f;
        _trackLayer.fillRule = kCAFillRuleEvenOdd;
        _trackLayer.lineJoin = kCALineJoinBevel;
        _trackLayer.frame = CGRectMake(0, 0, 150, 150);
        _trackLayer.path = trackPath.CGPath;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer new];
        _progressLayer.strokeColor = [UIColor redColor].CGColor;
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.lineWidth = 2.0f;
        _progressLayer.frame = CGRectMake(0, 0, 150, 150);
        [self.view.layer addSublayer:_progressLayer];
    }
    return _progressLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [UILabel new];
        _progressLabel.font = [UIFont systemFontOfSize:14];
        _progressLabel.textColor = [UIColor grayColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.frame = CGRectMake(self.view.bounds.size.width / 2.0f - 75, self.view.bounds.size.height / 2.0f - 55/2.0f, 150, 55);
        [self.view addSubview:_progressLabel];
    }
    return _progressLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view.layer addSublayer:self.trackLayer];
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaytime)];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

#pragma mark 方法

- (void)displaytime {
    static CGFloat hudu = 0;
    if (!_progressPath) {
        [_progressPath removeAllPoints];
        _progressPath = nil;
    }
    _progressPath = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:150/2.0f startAngle:- M_PI_2 endAngle:(M_PI * 2)*hudu - M_PI_2 clockwise:YES];
    self.progressLayer.path = _progressPath.CGPath;
    if (hudu >= 1.0000) {
        hudu = 0;
    }
    NSLog(@"%@",[NSString stringWithFormat:@"%f",hudu]);
    self.progressLabel.text = [NSString stringWithFormat:@"%3f",hudu];
    hudu += 0.001;
}


@end
