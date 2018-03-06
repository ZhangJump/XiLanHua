//
//  snapViewController.m
//  DynamicMove
//
//  Created by home on 2018/3/6.
//  Copyright © 2018年 home. All rights reserved.
//

#import "snapViewController.h"

@interface snapViewController ()
@property (nonatomic,strong) UIDynamicAnimator* animator;
@property (nonatomic,strong) UISnapBehavior *snap;
@property (weak, nonatomic) IBOutlet UIImageView *box;

@end

@implementation snapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundTile"]];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    [_animator removeBehavior:_snap];
    _snap = [[UISnapBehavior alloc] initWithItem:_box snapToPoint:point];
    [self.animator addBehavior:_snap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
