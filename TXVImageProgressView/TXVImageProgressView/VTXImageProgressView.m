//
//  VTXProgressView.m
//  Test
//
//  Created by Tran Viet on 7/9/15.
//  Copyright (c) 2015 Viettranx. All rights reserved.
//

#import "VTXImageProgressView.h"

// Use IBInspectable to enable render from storyboard
#if TARGET_INTERFACE_BUILDER
IB_DESIGNABLE
@interface VTXImageProgressView (IBDesign)
@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic) IBInspectable UIColor *tintColor;
@property (nonatomic) IBInspectable UIColor *progressColor;
@property (nonatomic) IBInspectable UIImage *sourceImage;
@property (nonatomic, setter=setPdirection:) IBInspectable NSInteger pdirection;
@end
#endif

@interface VTXImageProgressView ()
{
    UIImageView *imageView; // Core view
}
@end

@implementation VTXImageProgressView

- (void)setUp {
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [imageView setClipsToBounds:NO];
    [self addSubview:imageView];
    [self setUpConstraints];
}

- (void)setProgress:(CGFloat)progress
{
    if(progress < 0) progress = 0;
    else if(progress > 100) progress = 100;
    
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setDirection:(TXVProgressDirection)direction {
    _direction = direction;
    [self setNeedsDisplay];
}

- (void) setPdirection:(NSInteger)value {
    _direction = (TXVProgressDirection)(value % 4);
    [self setNeedsDisplay];
}


#pragma mark - Layout methods
- (void)setUpConstraints {
    // Set image view full size of container view (self)
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(imageView);
    NSArray *posV_constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary];
    
    NSArray *posH_constraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:viewsDictionary];
    
    [self addConstraints:posV_constraint];
    [self addConstraints:posH_constraint];
}

- (void)layoutSubviews {
    
    if (!imageView) {
        [self setUp];
    }
    
    [super layoutSubviews];
}

#pragma mark - Graphic methods
- (void)drawRect:(CGRect)rect {
    _tintColor = _tintColor ? _tintColor : [UIColor clearColor];
    _progressColor = _progressColor ? _progressColor : [UIColor blueColor];
    _sourceImage = _sourceImage ? _sourceImage : [self defaultImageForSize:self.bounds.size];
    _direction = _direction ? _direction : kVTXImageProgressTop2Bottom;
    
    UIImage *maskImage = [self maskImageForSize:imageView.bounds.size progressValue:_progress];
    imageView.image = [self maskImage:_sourceImage withMask:maskImage];
}

// IF user not set UIImage, create a gray image
- (UIImage *)defaultImageForSize:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.tintColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *returnImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImg;
}

- (UIImage *)maskImageForSize:(CGSize)size progressValue:(CGFloat)progress {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Fill origin color
    CGContextSetFillColorWithColor(context, _tintColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // Fill progress color appropriate to the progress value
    CGContextSetFillColorWithColor(context, _progressColor.CGColor);
    CGContextFillRect(context, [self rectForProgress:progress direction:_direction]);
    
    CGContextRestoreGState(context);
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (UIImage*) maskImage:(UIImage *)mask withMask:(UIImage *) image{
    
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // clip image inside imageView and then set it back
    [self flipVerticalContext:context];
    CGContextClipToMask(context, imageView.bounds, mask.CGImage);
    [self flipVerticalContext:context];
    
    CGContextDrawImage(context, imageView.bounds , image.CGImage);
    
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(context);
    
    // convert the finished resized image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(mainViewContentBitmapContext);
    
    // return the image
    return theImage;
}

- (void)flipVerticalContext:(CGContextRef) context{
    CGContextTranslateCTM(context, 0.0, imageView.frame.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
}


- (CGRect)rectForProgress:(CGFloat)progress direction:(TXVProgressDirection)direction {
    CGFloat offsetX, offsetY, width, height;
    CGSize imgSize = imageView.bounds.size;
    CGRect rectForProgress;
    
    switch (direction) {
        case kVTXImageProgressTop2Bottom:
            height = (progress * imageView.bounds.size.height) / 100;
            offsetY = imgSize.height - height;
            rectForProgress = CGRectMake(0, offsetY, imgSize.width, height);
            break;
       
        case kVTXImageProgressBottom2Top:
            height = (progress * imgSize.height) / 100;
            rectForProgress = CGRectMake(0, 0, imgSize.width, height);
            break;
            
        case kVTXImageProgressLeft2Right:
            width = (progress * imgSize.width) / 100;
            rectForProgress = CGRectMake(0, 0, width, imgSize.height);
            break;
            
        case kVTXImageProgressRight2Left:
            width = (progress * imgSize.width) / 100;
            offsetX = imgSize.width - width;
            rectForProgress = CGRectMake(offsetX, 0, width, imgSize.height);
            break;
        default:
            rectForProgress = CGRectZero;
            break;
    }
    
    return rectForProgress;
}
@end
