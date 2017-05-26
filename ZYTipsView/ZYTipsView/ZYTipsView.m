//
//  ZYTipsView.m
//
//
//  Created by Zhuoyu on 17/4/26.
//  Copyright © 2017年 Zhuoyu All rights reserved.
//

#import "ZYTipsView.h"

static const CGFloat radius = 3;
static const CGFloat angleWidth = 4;

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenFrame [UIScreen mainScreen].bounds

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

@interface CAShapeLayer(ViewMask)
+ (instancetype)createMaskLayerWithView:(UIView *)view arrowType:(ZYTipsArrowType)arrowType;
@end

@implementation CAShapeLayer (ViewMask)

+ (instancetype)createMaskLayerWithView:(UIView *)view arrowType:(ZYTipsArrowType)arrowType {
    CGFloat w = view.frame.size.width;
    CGFloat h = view.frame.size.height;
    
    //CGFloat radius = 3;
    //CGFloat angleWidth = 4;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 1;
    bezierPath.lineCapStyle = kCGLineCapRound;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    
    switch (arrowType) {
        case ZYTipsArrowTypeDown:
        {
            
            [bezierPath moveToPoint:CGPointMake(radius,h-angleWidth)];
            [bezierPath addArcWithCenter:CGPointMake(radius,h-radius-angleWidth) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius,radius) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius,radius) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius, h-radius-angleWidth) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
            CGFloat d =  w / 2;
            [bezierPath addLineToPoint:CGPointMake(d + angleWidth,h-angleWidth)];
            [bezierPath addLineToPoint:CGPointMake(d, h)];
            [bezierPath addLineToPoint:CGPointMake(d - angleWidth, h-angleWidth)];
            [bezierPath closePath];
        }
            break;
        case ZYTipsArrowTypeUp:
        {
            [bezierPath moveToPoint:CGPointMake(w-radius,angleWidth)];
            [bezierPath addArcWithCenter:CGPointMake(w-radius, radius+angleWidth) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius, h-radius) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius,h-radius) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius, radius+angleWidth) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            CGFloat d =  w / 2;
            [bezierPath addLineToPoint:CGPointMake(d-angleWidth,angleWidth)];
            [bezierPath addLineToPoint:CGPointMake(d, 0)];
            [bezierPath addLineToPoint:CGPointMake(d+angleWidth, angleWidth)];
            [bezierPath closePath];
        }
            break;
        case ZYTipsArrowTypeLeft:
        {
            [bezierPath moveToPoint:CGPointMake(angleWidth,radius)];
            [bezierPath addArcWithCenter:CGPointMake(radius+angleWidth, radius) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius,radius) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius,h-radius) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius+angleWidth, h-radius) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            CGFloat d =  h / 2;
            [bezierPath addLineToPoint:CGPointMake(angleWidth,d+angleWidth)];
            [bezierPath addLineToPoint:CGPointMake(0, d)];
            [bezierPath addLineToPoint:CGPointMake(angleWidth, d-angleWidth)];
            [bezierPath closePath];
        }
            break;
        case ZYTipsArrowTypeRight:
        {
            [bezierPath moveToPoint:CGPointMake(w-angleWidth,h-radius)];
            [bezierPath addArcWithCenter:CGPointMake(w-radius-angleWidth, h-radius) radius:radius startAngle:0 endAngle:M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius, h-radius) radius:radius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(radius,radius) radius:radius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            [bezierPath addArcWithCenter:CGPointMake(w-radius-angleWidth, radius) radius:radius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            CGFloat d =  h / 2;
            [bezierPath addLineToPoint:CGPointMake(w-angleWidth,d-angleWidth)];
            [bezierPath addLineToPoint:CGPointMake(w, d)];
            [bezierPath addLineToPoint:CGPointMake(w-angleWidth, d+angleWidth)];
            [bezierPath closePath];
        }
            break;
        default:
            break;
    }
    
    
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    return layer;
}

@end

@interface ZYTipsView ()
@property (nonatomic, strong) NSString *preference;
@end

@implementation ZYTipsView {
    UIView *_bgView;
    UIView *_whiteView;
    CGFloat _padding;
}


// 暂不考虑屏幕的朝向问题，固定是打竖
- (instancetype)initWithContentView:(UIView *)contentView arrowType:(ZYTipsArrowType)arrowType offset:(CGFloat)offset {
    return [self initWithContentView:contentView arrowType:arrowType offset:offset preference:nil];
}

- (instancetype)initWithContentView:(UIView *)contentView arrowType:(ZYTipsArrowType)arrowType offset:(CGFloat)offset preference:(NSString *)preference {
    CGSize screenSize = CGSizeMake(kScreenWidth, kScreenHeight);
    self = [super initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    if (self) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
        _bgView.backgroundColor = HexRGBAlpha(0x000000, 0.5);
        [self addSubview:_bgView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickOutside:)];
        [_bgView addGestureRecognizer:tapGesture];
        
        _padding = 15;
        
        
        if (arrowType == ZYTipsArrowTypeDown) {
            CGSize contentSize = contentView.frame.size;
            CGRect rect = CGRectInset(CGRectMake(0, 0, contentSize.width, contentSize.height + angleWidth), -_padding, -_padding);
            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
            _whiteView.backgroundColor = [UIColor whiteColor];
            [_bgView addSubview:_whiteView];
            _whiteView.center = CGPointMake(CGRectGetWidth(_bgView.frame) / 2, CGRectGetHeight(_bgView.frame) - offset - CGRectGetHeight(rect)/2 );
            
            [_whiteView addSubview:contentView];
            contentView.frame = CGRectMake(_padding, _padding, contentView.frame.size.width, contentView.frame.size.height);
            
        } else if (arrowType == ZYTipsArrowTypeUp) {
            CGSize contentSize = contentView.frame.size;
            CGRect rect = CGRectInset(CGRectMake(0, 0, contentSize.width, contentSize.height + angleWidth), -_padding, -_padding);
            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
            _whiteView.backgroundColor = [UIColor whiteColor];
            [_bgView addSubview:_whiteView];
            _whiteView.center = CGPointMake(CGRectGetWidth(_bgView.frame) / 2, offset + CGRectGetHeight(rect)/2 );
            
            [_whiteView addSubview:contentView];
            contentView.frame = CGRectMake(_padding, _padding + angleWidth, contentView.frame.size.width, contentView.frame.size.height);
            
        } else if (arrowType == ZYTipsArrowTypeLeft) {
            CGSize contentSize = contentView.frame.size;
            CGRect rect = CGRectInset(CGRectMake(0, 0, contentSize.width + angleWidth, contentSize.height), -_padding, -_padding);
            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
            _whiteView.backgroundColor = [UIColor whiteColor];
            [_bgView addSubview:_whiteView];
            _whiteView.center = CGPointMake(offset + CGRectGetWidth(rect)/2, CGRectGetHeight(_bgView.frame)/2 );
            
            [_whiteView addSubview:contentView];
            contentView.frame = CGRectMake(_padding + angleWidth, _padding, contentView.frame.size.width, contentView.frame.size.height);
            
        } else if (arrowType == ZYTipsArrowTypeRight) {
            CGSize contentSize = contentView.frame.size;
            CGRect rect = CGRectInset(CGRectMake(0, 0, contentSize.width + angleWidth, contentSize.height), -_padding, -_padding);
            _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))];
            _whiteView.backgroundColor = [UIColor whiteColor];
            [_bgView addSubview:_whiteView];
            _whiteView.center = CGPointMake(CGRectGetWidth(_bgView.frame)- offset- CGRectGetWidth(rect)/2, CGRectGetHeight(_bgView.frame)/2 );
            
            [_whiteView addSubview:contentView];
            contentView.frame = CGRectMake(_padding, _padding, contentView.frame.size.width, contentView.frame.size.height);
        }
        
        CAShapeLayer *layer = [CAShapeLayer createMaskLayerWithView:_whiteView arrowType:arrowType];
        _whiteView.layer.mask = layer;
        
        self.preference = preference;
        
    }
    
    return self;
    
}
- (void)show {
    [self showInView:nil];
}

- (void)showInView:(UIView *)view {
    if (view == nil) {
        UIView *parentView = [[UIApplication sharedApplication] keyWindow];
        [parentView addSubview:self];
    } else {
        [view addSubview:self];
    }
}


- (void)onClickOutside:(UIGestureRecognizer *)gestureRecognizer {
    [UIView animateWithDuration:0.3 animations:^{
        //self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        if ([self.preference length]) {
            [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:self.preference];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
    
}

@end
