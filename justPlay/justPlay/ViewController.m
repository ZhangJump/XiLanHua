//
//  ViewController.m
//  justPlay
//
//  Created by home on 2018/3/8.
//  Copyright © 2018年 home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIGravityBehavior * gravity;
@property (weak, nonatomic) IBOutlet UIView *rectView;
- (IBAction)moveRectView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //小方块上下晃动效果
    UIInterpolatingMotionEffect * effct = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    effct.maximumRelativeValue = @50.0;
    effct.minimumRelativeValue = @-50.0;
    [_rectView addMotionEffect:effct];
    
    
   
   
   
   
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)moveRectView:(id)sender {
   
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_rectView]];
    //y方向0.1倍重力
    CGVector gravityDirection = {0.0,0.1};
    [_gravity setGravityDirection:gravityDirection];
    [_animator addBehavior:_gravity];
}
@end
