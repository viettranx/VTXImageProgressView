//
//  VTXProgressView.h
//  Test
//
//  Created by Tran Viet on 7/9/15.
//  Copyright (c) 2015 Viettranx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, TXVProgressDirection) {
    kVTXImageProgressTop2Bottom = 0,
    kVTXImageProgressBottom2Top,
    kVTXImageProgressLeft2Right,
    kVTXImageProgressRight2Left
};

@interface VTXImageProgressView : UIView

@property (nonatomic) CGFloat progress;
@property (nonatomic) UIColor *tintColor;
@property (nonatomic) UIColor *progressColor;
@property (nonatomic) UIImage *sourceImage;
@property (nonatomic) TXVProgressDirection direction;

@end
