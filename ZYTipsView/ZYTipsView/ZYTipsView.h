//
//  ZYTipsView.h
//  photo
//
//  Created by admin on 17/4/26.
//  Copyright © 2017年 poco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZYTipsArrowType) {
    ZYTipsArrowTypeUp,
    ZYTipsArrowTypeDown,
    ZYTipsArrowTypeLeft,
    ZYTipsArrowTypeRight
};

@interface ZYTipsView : UIView

/**
 软件新功能点提示(黑色半透明背景，白色带圆角和箭头的显示区域)
 @param contentView 要显示的view
 @param arrowType 箭头的方向
 @param offset 水平或垂直方向的偏移值
 */
- (instancetype)initWithContentView:(UIView *)contentView arrowType:(ZYTipsArrowType)arrowType offset:(CGFloat)offset;


/**
 
 软件新功能点提示(黑色半透明背景，白色带圆角和箭头的显示区域)
 @param contentView 要显示的view
 @param arrowType 箭头的方向
 @param offset 水平或垂直方向的偏移值
 @param preference 配置项(布尔值，用于不再提示)
 */
- (instancetype)initWithContentView:(UIView *)contentView arrowType:(ZYTipsArrowType)arrowType offset:(CGFloat)offset preference:(NSString *)preference;

- (void)show;

- (void)showInView:(UIView *)view;

@end
