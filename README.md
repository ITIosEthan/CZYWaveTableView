# 使用CADisplayLink，CAShapeLayer结合绘制

    //定时器
    self.wavesDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    
    //务必设值RunLoop模式
    关于NSRunLoopMode

    NSDefaultRunLoopModel：监听用户最基本的操作（点击，触摸等）
    NSRunLoopCommonModels：监听一些特殊操作：滚动等
    那么，为什么在NSDefaultRunLoopModel模式下发生滚动，计时器会停止？那是因为系统认为，用户不应该边滚动边操作界面，所以停止了（触碰，点击等）NSDefaultRunLoopModel模式下监听的事件
    
    [self.wavesDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    //正弦函数波浪公式
     y = waveA * sin(waveW * i+ offsetX)+currentK;
    waveA:水纹振幅
    waveW:水纹周期
    offSetX：位移
    currentK：当前博文高度
    
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
    

# 效果图
![image](https://github.com/ITIosEthan/CzyWaveTableViewDemo/blob/master/czyWaveGif.gif)
