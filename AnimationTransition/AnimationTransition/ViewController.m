//
//  ViewController.m
//  AnimationTransition
//
//  Created by home on 2018/2/28.
//  Copyright © 2018年 home. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    int pageCount;
}
@property (weak, nonatomic) IBOutlet UILabel *page;

@property(nonatomic,strong)UISwipeGestureRecognizer * recognizerLeft;
@property(nonatomic,strong)UISwipeGestureRecognizer * recognizerRight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageCount = 1;
    _page.text = [NSString stringWithFormat:@"%d",pageCount];
    
    _recognizerLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [_recognizerLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:_recognizerLeft];
    
    _recognizerRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [_recognizerRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:_recognizerRight];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
  

    if(recognizer == _recognizerLeft){
        pageCount++;
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        [UIView commitAnimations];
       
    }
    else{
        if(pageCount>1){
            pageCount--;
        }
        else{
            return;
        }
        [UIView beginAnimations:@"animationID" context:nil];
        [UIView setAnimationDuration:1.0f];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationRepeatAutoreverses:NO];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
        [UIView commitAnimations];
    }
    _page.text = [NSString stringWithFormat:@"%d",pageCount];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
