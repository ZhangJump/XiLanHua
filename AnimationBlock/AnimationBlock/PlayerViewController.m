//
//  PlayerViewController.m
//  AnimationBlock
//
//  Created by home on 2018/3/15.
//  Copyright © 2018年 tonyguan. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayerViewController ()

{
    id timeObserver;
    BOOL isPlaying;
    
}
@property (nonatomic,weak) AVPlayer *avPlayer;
@property (nonatomic,weak) AVPlayerLayer *layer;
@property (nonatomic,strong) AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
- (IBAction)play:(id)sender;
- (IBAction)seek:(id)sender;

@end

@implementation PlayerViewController


- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
   
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    //获取路径 生成一个playerItem
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"YY" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    //avPlayer播放playerItem
    self.avPlayer = [AVPlayer playerWithPlayerItem: self.playerItem];
    self.avPlayer.allowsExternalPlayback = YES;
    
    //播放的幕布
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    self.layer.frame = CGRectMake(0, 20,
                                  self.view.frame.size.width,
                                  180);
    [self.view.layer addSublayer:self.layer];
   
    double duration = CMTimeGetSeconds(asset.duration);
    self.slider.maximumValue =  duration;
    self.slider.minimumValue  = 0.0;
    
    isPlaying = NO;

}


- (IBAction)play:(id)sender {
    
    UIBarButtonItem *item1;
    
    if (!isPlaying) {
        
        [self addObserver];
        [self.avPlayer seekToTime:kCMTimeZero];
        [self.avPlayer play];
        
        isPlaying = YES;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause
                                                              target:self
                                                              action:@selector(play:)];
        
        
    } else  {
        isPlaying = NO;
        item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                              target:self
                                                              action:@selector(play:)];
        
        [self.avPlayer pause];
    }
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolBar items]];
    [items replaceObjectAtIndex:0 withObject:item1];
    
    if ([items count] == 2) {
        
        MPVolumeView* airplayButtonView = [[MPVolumeView alloc] init];
        [airplayButtonView sizeToFit];
        airplayButtonView.showsVolumeSlider = NO;
        
        UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithCustomView:airplayButtonView];
        [items addObject: item3];
    }
    [self.toolBar setItems:items];
    
}

- (IBAction)seek:(id)sender {
    float value = [self.slider value];
    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(value, 10)];
}


-(void)addObserver{
    
    if (timeObserver == nil) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:self.playerItem];
        
        timeObserver = [self.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10)
                                                                   queue:dispatch_get_main_queue()
                                                              usingBlock:^(CMTime time) {
                                                                  float duration = CMTimeGetSeconds(self.avPlayer.currentTime);
                                                                  NSLog(@"duration = %f",duration);
                                                                  self.slider.value = duration;
                                                              }
                        ];
        
    }
    
}


- (void) playerItemDidReachEnd:(NSNotification*) aNotification
{
    NSLog(@"播放完成");
    if (timeObserver) {
        [self.avPlayer removeTimeObserver:timeObserver];
        
        timeObserver = nil;
        self.slider.value = 0.0;
        isPlaying = NO;
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:nil];
        
        
        UIBarButtonItem* item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
                                                                               target:self
                                                                               action:@selector(play:)];
        
        
        
        
        
        
        NSMutableArray *items = [[NSMutableArray alloc] initWithArray:[self.toolBar items]];
        [items replaceObjectAtIndex:0 withObject:item1];
        
        [self.toolBar setItems:items];
    }
    
}


@end
