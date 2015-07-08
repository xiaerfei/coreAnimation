//
//  ViewController.m
//  coreAnimation
//
//  Created by xiaerfei on 15/6/26.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) CALayer *layer;
- (IBAction)btnMove:(id)sender;
- (IBAction)Group:(id)sender;
- (IBAction)transation:(id)sender;
- (IBAction)keyAnimation:(id)sender;
- (IBAction)caDisplay:(id)sender;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = [[CALayer alloc] init];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.position = CGPointMake(50, 50);
    layer.bounds = CGRectMake(0, 0, 50,50);
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMove:(id)sender {
    //平移
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    baseAnimation.delegate = self;
    baseAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 450)];
    baseAnimation.duration = 5.0f;//它设定开始值到结束值花费的时间。期间会被速度的属性所影响。
    /*
     这个属性默认为 YES,那意味着,在指定的时间段完成后,动画就自动的从层上移除了。这个一般不用。
     假如你想要再次用这个动画时,你需要设定这个属性为 NO。这样的话,下次你在通过-set 方法设定动画的属 
     性时,它将再次使用你的动画,而非默认的动画。
     */
    
    baseAnimation.removedOnCompletion = NO;
    /*
     默认的值为 1.0.这意味着动画播放按照默认的速度。如果你改变这个值为 2.0,动画会用 2 倍的速度播放。 
     这样的影响就是使持续时间减半。如果你指定的持续时间为 6 秒,速度为 2.0,动画就会播放 3 秒钟---一半的 持续时间。
     */
    baseAnimation.speed = 2.0f;
    //当你设定这个属性为 YES 时,在它到达目的地之后,再原路返回开始值。
//    baseAnimation.autoreverses = YES;
    //动画从偏移的地方开始动画，但结束的地方是偏移的地方
//    baseAnimation.timeOffset   = 4;
    //默认的是 0,意味着动画只会播放一次。如果指定一个无限大的重复次数,使用 1e100f。这个不应该和 repeatDration 属性一块使用。
//    baseAnimation.repeatCount = 2;
    //这个属性指定了动画应该被重复多久。动画会一直重复,直到设定的时间流逝完。它不应该和 repeatCount 一起使用。 
//    baseAnimation.repeatDuration = 10;
    baseAnimation.beginTime = CACurrentMediaTime() + 1;
    /*
     fillMode
     fillMode的作用就是决定当前对象过了非active时间段的行为. 比如动画开始之前,动画结束之后。如果是一个动画CAAnimation,则需要将其removedOnCompletion设置为NO,要不然fillMode不起作用. 下面来讲各个fillMode的意义
     kCAFillModeRemoved 这个是默认值,也就是说当动画开始前和动画结束后,动画对layer都没有影响,动画结束后,layer会恢复到之前的状态
     kCAFillModeForwards 当动画结束后,layer会一直保持着动画最后的状态
     kCAFillModeBackwards 这个和kCAFillModeForwards是相对的,就是在动画开始前,你只要将动画加入了一个layer,layer便立即进入动画的初始状态并等待动画开始.你可以这样设定测试代码,将一个动画加入一个layer的时候延迟5秒执行.然后就会发现在动画没有开始的时候,只要动画被加入了layer,layer便处于动画初始状态
     kCAFillModeBoth 理解了上面两个,这个就很好理解了,这个其实就是上面两个的合成.动画加入后开始之前,layer便处于动画初始状态,动画结束后layer保持动画最后的状态.
     */
    baseAnimation.fillMode = kCAFillModeForwards;
    baseAnimation.autoreverses = YES;
    /*
     timingFunction可选的值有：
     kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
     kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
     kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
     kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。
     */
    baseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.layer addAnimation:baseAnimation forKey:@"haha"];
    
    //animationWithKeyPath键值 通过Xcode 帮助文档搜索 animatable properties
}

- (IBAction)Group:(id)sender {
    //缩放动画
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scale.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)];

    //平移
//    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
//    position.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 450)];
    //贝塞尔曲线
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(0, 0)];
    [bezier addQuadCurveToPoint:CGPointMake(100, 300) controlPoint:CGPointMake(300, 100)];
    
    CAKeyframeAnimation *keyanim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyanim.path = bezier.CGPath;
    
    //旋转
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = [NSNumber numberWithFloat:M_PI_2];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 5;
    group.speed    = 1;
//    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    group.animations = @[scale,rotation,keyanim];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:group forKey:@"group"];
}

- (IBAction)transation:(id)sender {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    /* 过渡效果
     fade     //交叉淡化过渡(不支持过渡方向) kCATransitionFade
     push     //新视图把旧视图推出去  kCATransitionPush
     moveIn   //新视图移到旧视图上面   kCATransitionMoveIn
     reveal   //将旧视图移开,显示下面的新视图  kCATransitionReveal
     cube     //立方体翻滚效果
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水效果(不支持过渡方向)
     pageCurl     //向上翻页效果
     pageUnCurl   //向下翻页效果
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     参考：http://www.cnblogs.com/pengyingh/articles/2339420.html
     */
    transition.type = @"cube";
    /* 过渡方向
     kCATransitionFromRight
     kCATransitionFromLeft
     kCATransitionFromBottom
     kCATransitionFromTop 
     */
    transition.subtype = kCATransitionFromRight;
    UIView *cubeView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    cubeView.backgroundColor = [UIColor cyanColor];
    [self.view.layer addAnimation:transition forKey:@"cubeView"];
    [self.view addSubview:cubeView];
}

- (IBAction)keyAnimation:(id)sender {
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
#if 1
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(300, 220)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
    
    NSArray *values = @[key1,key2,key3,key4];
    
    keyAnimation.values = values;
#else
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    
    keyAnimation.path=path;//设置path属性
    CGPathRelease(path);//释放路径对象
#endif
    
    
    keyAnimation.duration = 5.0f;
    /*
     keyTimes：各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
     */
    keyAnimation.keyTimes = @[@(0),@(0.3),@(0.8),@(1)];
    /*
     kCAAnimationLinear calculationMode的默认值,表示当关键帧为座标点的时候,关键帧之间直接直线相连进行插值计算;
     kCAAnimationDiscrete 离散的,就是不进行插值计算,所有关键帧直接逐个进行显示;
     kCAAnimationPaced 使得动画均匀进行,而不是按keyTimes设置的或者按关键帧平分时间,此时keyTimes和timingFunctions无效;
     kCAAnimationCubic 对关键帧为座标点的关键帧进行圆滑曲线相连后插值计算,对于曲线的形状还可以通过tensionValues,continuityValues,biasValues来进行调整自定义,这里的数学原理是Kochanek–Bartels spline,这里的主要目的是使得运行的轨迹变得圆滑;
     kCAAnimationCubicPaced 看这个名字就知道和kCAAnimationCubic有一定联系,其实就是在kCAAnimationCubic的基础上使得动画运行变得均匀,就是系统时间内运动的距离相同,此时keyTimes以及timingFunctions也是无效的.
     ----------------------------------------------------
     keyTimes：各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
     
     caculationMode：动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）；而如果指定了动画模式为kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡。其他动画模式还有：kCAAnimationPaced（均匀执行，会忽略keyTimes）、kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑）、kCAAnimationCubicPaced（平滑均匀执行）。
     
     
     */
    keyAnimation.calculationMode = kCAAnimationCubic;
    
    
    [self.layer addAnimation:keyAnimation forKey:@"key"];
}

- (IBAction)caDisplay:(id)sender {
    /*
     逐帧动画
     
     前面介绍了核心动画中大部分动画类型，但是做过动画处理的朋友都知道，在动画制作中还有一种动画类型“逐帧动画”。说到逐帧动画相信很多朋友第一个想到的就是UIImageView，通过设置UIImageView的animationImages属性，然后调用它的startAnimating方法去播放这组图片。当然这种方法在某些场景下是可以达到逐帧的动画效果，但是它也存在着很大的性能问题，并且这种方法一旦设置完图片中间的过程就无法控制了。当然，也许有朋友会想到利用iOS的定时器NSTimer定时更新图片来达到逐帧动画的效果。这种方式确实可以解决UIImageView一次性加载大量图片的问题，而且让播放过程可控，唯一的缺点就是定时器方法调用有时可能会因为当前系统执行某种比较占用时间的任务造成动画连续性出现问题。
     
     虽然在核心动画没有直接提供逐帧动画类型，但是却提供了用于完成逐帧动画的相关对象CADisplayLink。CADisplayLink是一个计时器，但是同NSTimer不同的是，CADisplayLink的刷新周期同屏幕完全一致。例如在iOS中屏幕刷新周期是60次/秒，CADisplayLink刷新周期同屏幕刷新一致也是60次/秒，这样一来使用它完成的逐帧动画（又称为“时钟动画”）完全感觉不到动画的停滞情况。
     
     在iOS开篇“IOS开发系列--IOS程序开发概览”中就曾说过：iOS程序在运行后就进入一个消息循环中（这个消息循环称为“主运行循环”），整个程序相当于进入一个死循环中，始终等待用户输入。将CADisplayLink加入到主运行循环队列后，它的时钟周期就和主运行循环保持一致，而主运行循环周期就是屏幕刷新周期。在CADisplayLink加入到主运行循环队列后就会循环调用目标方法，在这个方法中更新视图内容就可以完成逐帧动画。
     
     当然这里不得不强调的是逐帧动画性能势必较低，但是对于一些事物的运动又不得不选择使用逐帧动画，例如人的运动，这是一个高度复杂的运动，基本动画、关键帧动画是不可能解决的。所大家一定要注意在循环方法中尽可能的降低算法复杂度，同时保证循环过程中内存峰值尽可能低。下面以一个鱼的运动为例为大家演示一下逐帧动画。
     
     */

    
}


#pragma mark - AnimationDelegate
// 动画开始执行的时候触发这个方法
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"动画开始执行了");
}

// 动画执行完毕的时候触发这个方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束了---%@",flag?@"YES":@"NO");
}

@end
