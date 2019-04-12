//
//  DottedLineViewController.m
//  XCCAShaperLayer
//
//  Created by xchuan on 2019/4/10.
//  Copyright © 2019年 xchuan. All rights reserved.
//

#import "DottedLineViewController.h"

@interface DottedLineViewController ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation DottedLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startCAEmitterLayer];
}

- (void)dottedLine{
    CAShapeLayer* dashLineShapeLayer = [CAShapeLayer layer];
    UIBezierPath* dashLinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 200, 200, 100) cornerRadius:20];
    
    dashLineShapeLayer.path = dashLinePath.CGPath;
    dashLineShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dashLineShapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    dashLineShapeLayer.lineWidth = 3;
    dashLineShapeLayer.lineDashPattern = @[@(3)];
    [self.view.layer addSublayer:dashLineShapeLayer];
    
    NSTimeInterval delayTime = 0.3f;
    NSTimeInterval timeInterval = 0.1f;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGFloat _add = 5;
            dashLineShapeLayer.lineDashPhase -= _add;
        });
    });
    dispatch_resume(_timer);
}

- (void)startCAEmitterLayer {
    // EmitterLayer
    
    CGRect showRect = self.view.bounds;
    UIView *view = [[UIView alloc] initWithFrame:showRect];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    self.emitterLayer = [CAEmitterLayer layer];
    self.emitterLayer.frame = view.bounds;
    self.emitterLayer.masksToBounds = YES;
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize = showRect.size;
    self.emitterLayer.emitterPosition = CGPointMake(showRect.size.width / 2.f, - 20);
    [self setEmitterCell];
    [view.layer addSublayer:self.emitterLayer];
}

- (void)setEmitterCell {
    CAEmitterCell *rainflake  = [CAEmitterCell  emitterCell];
    rainflake.birthRate       = 5.f;
    rainflake.speed = 10.f;
    rainflake.velocity        = 10.f;
    rainflake.velocityRange   = 10.f;
    rainflake.yAcceleration   = 1000.f;
    rainflake.contents        = (__bridge id)([UIImage imageNamed:@"changtiao-4.png"].CGImage);
    rainflake.color           = [UIColor whiteColor].CGColor;
    rainflake.lifetime        = 160.f;
    rainflake.scale           = 0.2f;
    rainflake.scaleRange      = 0.f;
    
    
    CAEmitterCell *snowflake  = [CAEmitterCell emitterCell];
    snowflake.birthRate       = 1.f;
    snowflake.speed           = 10.f;
    snowflake.velocity        = 2.f;
    snowflake.velocityRange   = 10.f;
    snowflake.yAcceleration   = 10.f;
    snowflake.emissionRange   = 0.5 * M_PI;
    snowflake.spinRange       = 0.25 * M_PI;
    snowflake.contents        = (__bridge id)([UIImage imageNamed:@"yuanxing.png"].CGImage);
    snowflake.color           = [UIColor whiteColor].CGColor;
    snowflake.lifetime        = 160.f;
    snowflake.scale           = 0.5;
    snowflake.scaleRange      = 0.3;
    
    self.emitterLayer.emitterCells = @[snowflake,rainflake];
}


@end
