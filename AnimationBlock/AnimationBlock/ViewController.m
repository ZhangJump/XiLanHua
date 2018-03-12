//
//  ViewController.m
//  AnimationBlock
//
//  Created by tonyguan on 14-1-5.
//  Copyright (c) 2014年 tonyguan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CALayerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@property (weak, nonatomic) IBOutlet UIImageView *ball;
@property (nonatomic,assign)CGMutablePathRef path;
@property (nonatomic,strong)CALayer * rectLayer;
@property (nonatomic,strong)CALayer * drawLayer;
@property (nonatomic,assign)UIColor * color;
@property (nonatomic,strong)NSMutableArray * paths;
- (IBAction)clickColor:(id)sender;

@end

@implementation ViewController
//球随着轨迹移动
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //layer大小是整个view要定义position
    _drawLayer = [[CALayer alloc]init];
    _drawLayer.bounds = self.view.bounds;
    _drawLayer.position = self.view.layer.position;
   
    //画线代理 就是下面的drawLayer方法
    self.drawLayer.delegate = self;
    
    
    [self.view.layer addSublayer:_drawLayer];
    
    self.rectLayer = _showImage.layer;
   
    
    _path = CGPathCreateMutable();
    
    
    _color = [UIColor redColor];
    _showImage.backgroundColor = _color;
    
    _paths = [NSMutableArray new];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    CGPathMoveToPoint(_path, nil, location.x, location.y);

}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:self.view];
    
        //添加线
        CGPathAddLineToPoint(_path, nil, location.x, location.y);
    
        //move之后开始绘制 显示内容 所以是在这里刷新了
        [self.drawLayer setNeedsDisplay];
   
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  
    
    //添加关键帧动画
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrame.duration = 6.0f;
    keyFrame.path = self.path;
    
    //留在动画后的位置上
    keyFrame.removedOnCompletion = NO;
    keyFrame.fillMode = kCAFillModeForwards;
    
    //相应的添加动画
    [self.rectLayer addAnimation:keyFrame forKey:nil];
}


#pragma mark-实现caLayer的代理方法
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
  
    //最主要的方法 在layer上绘制path。
    //按path绘制
    CGContextAddPath(ctx, _path);
    //设置画笔的颜色
    CGContextSetStrokeColorWithColor(ctx, [_color CGColor]);
    //设置值描边不填充
    CGContextDrawPath(ctx, kCGPathStroke);
                 
}


- (IBAction)clickColor:(id)sender {
    UIButton * btn = (UIButton*)sender;
    NSInteger tag = btn.tag;
    switch (tag) {
        case 0:
            _color = [UIColor redColor];
            break;
        case 1:
           _color = [UIColor greenColor];
            break;
        case 2:
            _color = [UIColor orangeColor];
            break;
        default:
            break;
    }
    
}
@end
