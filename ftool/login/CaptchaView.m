//
//  CaptchaView.m
//  text
//
//  Created by CX－IOS on 16/1/12.
//  Copyright © 2016年 Dicky. All rights reserved.
//

#import "CaptchaView.h"

#define kRandomColor  [UIColor colorWithRed:arc4random() % 221 / 256.0 green:arc4random() % 241 / 256.0 blue:arc4random() % 248 / 256.0 alpha:1.0];
#define kLineCount 4
#define kLineWidth 1.0
#define kCharCount 5
#define kFontSize [UIFont boldSystemFontOfSize:arc4random() % 5 + 15]

@interface CaptchaView ()
@property (nonatomic, assign) NSInteger firstIndex;
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, assign) NSInteger operationIndex;
@end

@implementation CaptchaView

@synthesize changeString,changeArray;

- (instancetype)init {
    if (self = [super init]) {
        
        //self.layer.cornerRadius = 5.0; //设置layer圆角半径
        self.layer.masksToBounds = YES; //隐藏边界
        self.backgroundColor = SETCOLOR(223, 241, 248, 1.0);
        //显示一个随机验证码
        [self changeCaptcha];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        //self.layer.cornerRadius = 5.0; //设置layer圆角半径
        self.layer.masksToBounds = YES; //隐藏边界
        self.backgroundColor = SETCOLOR(223, 241, 248, 1.0);
        
        //显示一个随机验证码
        [self changeCaptcha];
        
        
    }
    
    return self;
}

- (BOOL)verifyContent:(NSString *)content {
    NSInteger fisrtNum = _firstIndex;
    NSInteger lastNum = _lastIndex;
    NSInteger result;
    switch (_operationIndex) {
        case 0:
            result = fisrtNum+lastNum;
            break;
        case 1:
            result = fisrtNum-lastNum;
            break;
        case 2:
            result = fisrtNum*lastNum;
            break;
            
        default:
            NSLog(@"验证出现错误");
            return NO;
            break;
    }
    if (content.integerValue == result) {
        return YES;
    }else {
        [self changeCaptcha];
        
        return NO;
    }
    
    return YES;
}

-(void)changeCaptcha{

    //<一>从字符数组中随机抽取相应数量的字符，组成验证码字符串
    //数组中存放的是全部可选的字符，可以是字母，也可以是中文
    self.changeArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",nil];
    self.operationArray = [[NSArray alloc] initWithObjects:@"+",@"-",@"x",nil];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"=",@"?",nil];
    
    //如果能确定最大需要的容量，使用initWithCapacity:来设置，好处是当元素个数不超过容量时，添加元素不需要重新分配内存
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:kCharCount];
    self.changeString = [[NSMutableString alloc] initWithCapacity:kCharCount];
    
    //随机从数组中选取需要个数的字符，然后拼接为一个字符串
    for(int i = 0; i < kCharCount; i++) {
        if (i == 1) {
            NSInteger operationIndex = arc4random() % ([self.operationArray count] - 0);
            getStr = [self.operationArray objectAtIndex:operationIndex];
            _operationIndex = operationIndex;
            
        }else if (i == 3) {
            getStr = [array objectAtIndex:0];
        }else if (i == 4) {
            getStr = [array objectAtIndex:1];
        }else {
            NSInteger index = arc4random() % ([self.changeArray count] - 1);
            getStr = [self.changeArray objectAtIndex:index];
            if (i == 0) {
                _firstIndex = index;
            }else if (i == 2) {
                _lastIndex = index;
            }

        }
        
        self.changeString = (NSMutableString *)[self.changeString stringByAppendingString:getStr];
        
         //NSLog(@"随机字符串:%@",getStr);
    }
    
    //结果不能为负数
    if (_operationIndex==1 && _firstIndex<_lastIndex) {
        [self changeCaptcha];
    }else {
        [self setNeedsDisplay];
    }
}

#pragma mark 点击view时调用，因为当前类自身就是UIView，点击更换验证码可以直接写到这个方法中，不用再额外添加手势

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击界面，切换验证码
    [self changeCaptcha];
    
    //setNeedsDisplay调用drawRect方法来实现view的绘制
     //[self setNeedsDisplay];
}

#pragma mark 绘制界面（1.UIView初始化后自动调用； 2.调用setNeedsDisplay方法时会自动调用）

- (void)drawRect:(CGRect)rect {
    // 重写父类方法，首先要调用父类的方法
    [super drawRect:rect];
    
    //设置随机背景颜色
  //  self.backgroundColor = kRandomColor;
    
    //获得要显示验证码字符串，根据长度，计算每个字符显示的大概位置
    NSString *text = [NSString stringWithFormat:@"%@",self.changeString];
    CGSize cSize = [@"S" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    NSInteger width = rect.size.width / 4 - cSize.width;
    NSInteger height = rect.size.height - cSize.height;
    CGPoint point;
    
    //依次绘制每一个字符,可以设置显示的每个字符的字体大小、颜色、样式等
    float pX, pY;
    for (NSInteger i = 0; i < text.length; i++)
    {
        pX = arc4random() % width + rect.size.width / text.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:kFontSize,NSForegroundColorAttributeName:KColor}];
     
    }
        //调用drawRect：之前，系统会向栈中压入一个CGContextRef，调用UIGraphicsGetCurrentContext()会取栈顶的CGContextRef
        CGContextRef context = UIGraphicsGetCurrentContext();
        //设置画线宽度
        CGContextSetLineWidth(context, kLineWidth);
    
        /*
        //绘制干扰的彩色直线
        for(NSInteger i = 0; i < kLineCount - 2; i++)
        {
            //设置线的随机颜色
           UIColor *color = kRandomColor;
            //UIColor *color = [UIColor blackColor];
            CGContextSetStrokeColorWithColor(context, [color CGColor]);
            //设置线的起点
            pX = arc4random() % (int)rect.size.width;
            pY = arc4random() % (int)rect.size.height;
            CGContextMoveToPoint(context, pX, pY);
            //设置线终点
            pX = arc4random() % (int)rect.size.width;
            pY = arc4random() % (int)rect.size.height;
            CGContextAddLineToPoint(context, pX, pY);
            //画线
            CGContextStrokePath(context);
        
         } */
    
}










@end
