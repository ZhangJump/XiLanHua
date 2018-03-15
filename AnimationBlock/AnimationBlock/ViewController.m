//
//  ViewController.m
//  AnimationBlock
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

//CABasicAnimation是特殊的CAKeyframeAnimation
//UIBezierPath是对CGMutablePath的封装
#import "ViewController.h"
#import <CoreText/CoreText.h>
@interface ViewController ()
@property(nonatomic,strong)  CAShapeLayer * layer;

@end
@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //画线
    [self drawSomething];
    //屏幕倾斜效果
    //[self screenTilt];
   
}
- (void)screenTilt{
     [[UIApplication sharedApplication]setStatusBarHidden:YES];
    UIInterpolatingMotionEffect * motionEffict = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffict.maximumRelativeValue = @50.0;
    motionEffict.minimumRelativeValue = @-50.0;
    [self.view addMotionEffect:motionEffict];
    
}
- (void)drawSomething{
    
    _layer = [CAShapeLayer layer];
    _layer.position = CGPointMake(0, 100);
    _layer.lineWidth = 1;
    _layer.fillColor = [[UIColor whiteColor]CGColor];
    _layer.strokeColor = [[UIColor blackColor]CGColor];
    [self.view.layer addSublayer:_layer];
    
    UIBezierPath * path = [self transformToBezierPath:@"你好！张佳鹏"];
    _layer.path = path.CGPath;
    
   

    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    [_layer addAnimation:animation forKey:nil];
    
    CATransform3D turnTrans = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    _layer.transform = turnTrans;
    
}

- (UIBezierPath *)transformToBezierPath:(NSString *)string
{
    CGMutablePathRef paths = CGPathCreateMutable();
    CFStringRef fontNameRef = CFSTR("SnellRoundhand");
    CTFontRef fontRef = CTFontCreateWithName(fontNameRef, 50, nil);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:string attributes:@{(__bridge NSString *)kCTFontAttributeName: (__bridge UIFont *)fontRef}];
    CTLineRef lineRef = CTLineCreateWithAttributedString((CFAttributedStringRef)attrString);
    CFArrayRef runArrRef = CTLineGetGlyphRuns(lineRef);
    for (int runIndex = 0; runIndex < CFArrayGetCount(runArrRef); runIndex++) {
        const void *run = CFArrayGetValueAtIndex(runArrRef, runIndex);
        CTRunRef runb = (CTRunRef)run;
        const void *CTFontName = kCTFontAttributeName;
        const void *runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb), CTFontName);
        CTFontRef runFontS = (CTFontRef)runFontC;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        int temp = 0;
        CGFloat offset = .0;
        for (int i = 0; i < CTRunGetGlyphCount(runb); i++) {
            CFRange range = CFRangeMake(i, 1);   
            CGGlyph glyph = 0;
            CTRunGetGlyphs(runb, range, &glyph);
            CGPoint position = CGPointZero;
            CTRunGetPositions(runb, range, &position);
            
            CGFloat temp3 = position.x;
            int temp2 = (int)temp3/width;
            CGFloat temp1 = 0;
            
            if (temp2 > temp1) {
                temp = temp2;
                offset = position.x - (CGFloat)temp;
            }
            CGPathRef path = CTFontCreatePathForGlyph(runFontS, glyph, nil);
            CGFloat x = position.x - (CGFloat)temp*width - offset;
            CGFloat y = position.y - (CGFloat)temp * 80;
            CGAffineTransform transform = CGAffineTransformMakeTranslation(x, y);
            CGPathAddPath(paths, &transform, path);
            
            CGPathRelease(path);
        }
        CFRelease(runb);
        CFRelease(runFontS);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointZero];
    [bezierPath appendPath:[UIBezierPath bezierPathWithCGPath:paths]];
    
    CGPathRelease(paths);
    CFRelease(fontNameRef);
    CFRelease(fontRef);
    return bezierPath;
}


@end
