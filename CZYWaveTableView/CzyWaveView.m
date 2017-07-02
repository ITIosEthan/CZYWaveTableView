//
//  CzyWaveView.m
//  CZYWaveTableView
//
//  Created by macOfEthan on 16/12/20.
//  Copyright © 2016年 macOfEthan. All rights reserved.
//

#import "CzyWaveView.h"

@interface CzyWaveView ()
{
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat wavesSpeed;//水纹速度
    CGFloat WavesWidth; //水纹宽度
}

@property (nonatomic,strong)CADisplayLink *wavesDisplayLink;

@property (nonatomic,strong)CAShapeLayer *firstWavesLayer;

@property (nonatomic,strong)UIColor *firstWavesColor;

@end

@implementation CzyWaveView

#pragma mark - 生命周期
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self czyInitWave];
    }
    return self;
}


#pragma mark - 创建波浪
- (void)czyInitWave
{
    //设置波浪的宽度
    WavesWidth = self.frame.size.width;
    
    //波浪颜色
    self.firstWavesColor = kCzyBrownColor;
    
    //设置波浪的速度
    wavesSpeed = 1/M_PI;
    
    //初始化layer
    if (self.firstWavesLayer == nil) {
        
        //初始化
        self.firstWavesLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        self.firstWavesLayer.fillColor = self.firstWavesColor.CGColor;
        //设置边缘线的颜色
        self.firstWavesLayer.strokeColor = kCzyBrownColor.CGColor;
        //设置边缘线的宽度
        self.firstWavesLayer.lineWidth = 1.0;
        self.firstWavesLayer.strokeStart = 0.0;
        self.firstWavesLayer.strokeEnd = 0.8;
        
        [self.layer addSublayer:self.firstWavesLayer];
    }
    
    
    //设置波浪流动速度
    wavesSpeed = 0.02;
    //设置振幅
    waveA = 12;
    //设置周期
    waveW = 0.5/30.0;
    
    //设置波浪纵向位置
    currentK = self.frame.size.height/2;//屏幕居中
    
    //启动定时器
    self.wavesDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    
    [self.wavesDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink{
    
    //实时的位移
    //实时的位移
    offsetX += wavesSpeed;
    
    [self setCurrentFirstWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath{
    
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (NSInteger i =0.0f; i<=WavesWidth; i++) {
        
        //正弦函数波浪公式
        y = waveA * sin(waveW * i+ offsetX)+currentK;
        
        //将点连成线
        CGPathAddLineToPoint(path, nil, i, y);
    }
    
    CGPathAddLineToPoint(path, nil, WavesWidth, 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    self.firstWavesLayer.path = path;
    
    //使用layer 而没用CurrentContext
    CGPathRelease(path);
    
}


-(void)dealloc
{
    [self.wavesDisplayLink invalidate];
}



@end
