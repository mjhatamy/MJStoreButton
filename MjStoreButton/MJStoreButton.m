//
//  StoreButton.m
//  StoreButton
//
//  Created by Majid Hatami Aghdam on 1/31/17.
//  Copyright © 2017 Majid Hatami Aghdam. All rights reserved.
//

#import "MJStoreButton.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)

@implementation MJStoreButton

@synthesize storeState = m_storeState;
@synthesize progress = m_progress;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

-(void)setupDefaults{
    self.storeState = UIMJStoreButtonStateGet;
    self.borderWidth = 1.0f;
    self.getText = @"GET";
    self.buyText = @"BUY BOOK";
    self.openText = @"OPEN";
    self.progress = 0.0f;
    self.progressArcWidth = 2.0f;
    [self.titleLabel setText:@"---"];
    self.titleEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8);
    
    NSAssert( (self.buttonType == UIButtonTypeCustom), @"Button Type must be UIButtonTypeCustom. Please check interface builder button type and set it to custom. while it is");
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.backgroundColor = [UIColor clearColor];
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    if(mainLayer==nil){
        mainLayer = [CALayer new];
        [mainLayer setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.layer insertSublayer:mainLayer atIndex:0];
    }
    
    [self setupLayers];
    [self updateLayers];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //[self updateLayers];
}

-(void)prepareForInterfaceBuilder{
    isInterfaceBuilder = YES;
    [self setupDefaults];
    [super prepareForInterfaceBuilder];
}

-(void)setProgress:(CGFloat)progress{
    if(progress==m_progress) return;
    m_progress = progress;
    [self updateLayers];
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    [self updateLayers];
}

-(void)setStoreState:(UIMJStoreButtonState)storeState{
    m_storeState = storeState;
    [self setupLayers];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    hasTouch = YES;
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    if([self pointInside:locationPoint withEvent:event]){
        isTouchInside = YES;
    }else{
        isTouchInside = NO;
    }
    
    [self updateLayers];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    hasTouch = YES;
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    if([self pointInside:locationPoint withEvent:event]){
        isTouchInside = YES;
    }else{
        isTouchInside = NO;
    }
    
    [self updateLayers];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    hasTouch = NO;
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    if([self pointInside:locationPoint withEvent:event]){
        isTouchInside = YES;
    }else{
        isTouchInside = NO;
    }
    
    [self updateLayers];
}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    hasTouch = NO;
    CGPoint locationPoint = [[touches anyObject] locationInView:self];
    if([self pointInside:locationPoint withEvent:event]){
        isTouchInside = YES;
    }else{
        isTouchInside = NO;
    }
    
    [self updateLayers];
}

-(void)setupLayers{
    [mainLayer removeAllAnimations];
    [shapeLayer removeAllAnimations];
    [shapeLayer removeFromSuperlayer];
    shapeLayer = nil;
    
    switch (self.storeState) {
        case UIMJStoreButtonStateGet:{
            
        }
            break;
        case UIMJStoreButtonStateBuy:{
            
        }
            break;
        case UIMJStoreButtonStatePrepareDownload:{
            shapeLayer = [CAShapeLayer new];
            
            shapeLayer.borderWidth = 0;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.strokeColor = self.borderColor.CGColor;
            shapeLayer.lineWidth = self.borderWidth;
            
        }
            break;
        case UIMJStoreButtonStateDownload:{
            shapeLayer = [CAShapeLayer new];
            
            shapeLayer.borderWidth = self.borderWidth;
            shapeLayer.borderColor = self.borderColor.CGColor;
            shapeLayer.fillColor = [UIColor clearColor].CGColor;
            shapeLayer.lineWidth = self.progressArcWidth;
            shapeLayer.strokeColor = self.borderColor.CGColor;
            shapeLayer.lineJoin = kCALineJoinBevel;
            shapeLayer.speed = 1.0f;
            
            lastProgress = 0;
            
            //Add Box in the middle
            boxLayer = [CAShapeLayer new];
            boxLayer.fillColor = self.borderColor.CGColor;
            boxLayer.backgroundColor = self.borderColor.CGColor;
            boxLayer.borderWidth = 1.0f;
            boxLayer.borderColor = self.borderColor.CGColor;
            [shapeLayer addSublayer:boxLayer];
            
        }
            break;
        case UIMJStoreButtonStateOpen:{
            
        }
            break;
        default:
            break;
    }
    
    if( [shapeLayer superlayer] ==nil ){
        [mainLayer addSublayer:shapeLayer];
    }
}

-(void) updateLayers{
    
    mainLayer.borderWidth = self.borderWidth;
    mainLayer.cornerRadius = ( (self.borderWidth > 0) ? self.borderRadius : 1.0f);
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentCenter:
        {
            self.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case UIControlContentHorizontalAlignmentLeft:{
            self.textAlignment = NSTextAlignmentLeft;
        }
            break;
        case UIControlContentHorizontalAlignmentRight:{
            self.textAlignment = NSTextAlignmentRight;
        }
            break;
        case UIControlContentHorizontalAlignmentFill:{
            self.textAlignment = NSTextAlignmentLeft;
        }
        default:{
            self.textAlignment = NSTextAlignmentCenter;
        }
            break;
    }
    
    switch (self.storeState) {
        case UIMJStoreButtonStateGet:
        {
            [self setTitle:self.getText forState:UIControlStateNormal];
            [self setTitle:self.getText forState:UIControlStateHighlighted];
            [self setTitle:self.getText forState:UIControlStateSelected];
        }
            break;
        case UIMJStoreButtonStateBuy:{
            [self setTitle:self.buyText forState:UIControlStateNormal];
            [self setTitle:self.buyText forState:UIControlStateHighlighted];
            [self setTitle:self.buyText forState:UIControlStateSelected];
        }
            break;
        case UIMJStoreButtonStateOpen:{
            [self setTitle:self.openText forState:UIControlStateNormal];
            [self setTitle:self.openText forState:UIControlStateHighlighted];
            [self setTitle:self.openText forState:UIControlStateSelected];
            
        }
            break;
        case UIMJStoreButtonStatePrepareDownload:{
            
        }
       //     break;
        case UIMJStoreButtonStateDownload:{
            
        }
       //     break;
        default:{
            [self setTitle:@"" forState:UIControlStateNormal];
            [self setTitle:@"" forState:UIControlStateHighlighted];
            [self setTitle:@"" forState:UIControlStateSelected];
        }
            break;
    }
    
    CGRect layerFrame = [self getLayerFrameFromTitle];
    if( !CGRectEqualToRect(layerFrame, mainLayer.frame) ){
        [self.titleLabel setAlpha:isInterfaceBuilder ? 1.0f : 0.0f];
        [UIView animateWithDuration:0.3f animations:^{
            [mainLayer setFrame:layerFrame];
        } completion:^(BOOL finished) {
            [self.titleLabel setAlpha:1.0f];
        }];
    }
    
    
    if(self.storeState == UIMJStoreButtonStateGet || self.storeState == UIMJStoreButtonStateOpen){
        
        if(self.highlighted){
            mainLayer.backgroundColor = self.borderHighlitedColor.CGColor;
            mainLayer.borderColor = self.borderHighlitedColor.CGColor;
            [self.titleLabel setAlpha:1.0f];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }else{
            mainLayer.backgroundColor = self.bgColor.CGColor;
            mainLayer.borderColor = self.borderColor.CGColor;
            [self.titleLabel setAlpha:1.0f];
            [self setTitleColor:self.borderColor forState:UIControlStateNormal];
        }
        
    }
    else if(self.storeState ==  UIMJStoreButtonStateBuy){
        if(self.highlighted){
            mainLayer.backgroundColor = self.buyBorderHighlitedColor.CGColor;
            mainLayer.borderColor = self.buyBorderHighlitedColor.CGColor;
            [self.titleLabel setAlpha:1.0f];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        }else{
            mainLayer.backgroundColor = self.bgColor.CGColor;
            mainLayer.borderColor = self.buyBorderColor.CGColor;
            [self.titleLabel setAlpha:1.0f];
            [self setTitleColor:self.buyBorderColor forState:UIControlStateNormal];
            
        }
    }
    else{
        mainLayer.backgroundColor = self.bgColor.CGColor;
        mainLayer.borderColor = self.borderColor.CGColor;
        mainLayer.borderWidth = 0;
        mainLayer.cornerRadius = layerFrame.size.height/2;
        
        if(self.storeState == UIMJStoreButtonStatePrepareDownload){
            UIBezierPath *outerCircle;
            
            shapeLayer.frame = CGRectMake(0, 0, layerFrame.size.width, layerFrame.size.height);
            outerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(layerFrame.size.height/2.0f,layerFrame.size.height/2.0f) radius:(layerFrame.size.height-2)/2 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(340) clockwise:YES];
            shapeLayer.path = outerCircle.CGPath;
            
            CAAnimation *spinningAnimation = [self animationForSpinning];
            [mainLayer addAnimation:spinningAnimation forKey:@"animationOpacity"];
        }else if(self.storeState == UIMJStoreButtonStateDownload){
            // Offset
            CGFloat startAngle = - M_PI_2;
            
            // EndAngle
            CGFloat endAngle =  self.progress * 2 * M_PI + startAngle;
            // Center
            CGRect rect = layerFrame;
            CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            
            // Radius
            CGFloat radius = MIN(center.x, center.y) - self.progressArcWidth / 2 -1 ;
            UIBezierPath *outerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(layerFrame.size.height/2.0f,layerFrame.size.height/2.0f) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];

            shapeLayer.frame = CGRectMake(0, 0, layerFrame.size.width, layerFrame.size.height);
            shapeLayer.cornerRadius = layerFrame.size.height/2.0f;
            shapeLayer.path = outerCircle.CGPath;

            CGFloat boxSizeRatio = 3.2f;
            CGFloat boxW = layerFrame.size.width/boxSizeRatio;
            CGFloat boxH = (layerFrame.size.height/boxSizeRatio);
            boxLayer.frame = CGRectMake( (layerFrame.size.width-boxW)/2.0f, (layerFrame.size.height-boxH)/2.0f, boxW, boxH);
            
            shapeLayer.path = outerCircle.CGPath;
            
            CGFloat fromValue = (1 * lastProgress) / self.progress;
            if(self.progress != lastProgress){
                [self animationForStartAngle:fromValue];
            }
            lastProgress = self.progress;
        }
        
    }
}

-(CGRect)getLayerFrameFromTitle{
    NSString *text = self.titleLabel.text;
    if(text.length <= 0){
        return CGRectMake(self.frame.size.width-self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    }
    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};

    CGSize size = [text sizeWithAttributes:attributes];
    size.width += (self.titleEdgeInsets.left+self.titleEdgeInsets.right);
    size.height = self.frame.size.height;
    
    CGPoint origin = CGPointZero;
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:{
            origin.y = 0;
            size.height = size.height;
        }
            break;
        case UIControlContentVerticalAlignmentBottom:{
            origin.y = (self.frame.size.height - size.height);
            size.height = size.height;
        }
            break;
        case UIControlContentVerticalAlignmentCenter:{
            origin.y =  (self.frame.size.height - size.height)/2.0f;
        }
            break;
        case UIControlContentVerticalAlignmentFill:{
            origin.y = 0;
            size.height = self.frame.size.height;
        }
            break;
        default:{
            origin.y = 0;
            size.height = self.frame.size.height;
        }
            break;
    }

    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentCenter:
        {
            origin.x = (self.frame.size.width - size.width)/2.0f;
            if(self.storeState==UIMJStoreButtonStatePrepareDownload || self.storeState==UIMJStoreButtonStateDownload){
                size.width = self.frame.size.height;
                origin.x = (self.frame.size.width/2.0f)-(size.width/2.0f);
            }
            
        }
            break;
        case UIControlContentHorizontalAlignmentLeft:{
            size.width = size.width;
            if(self.storeState==UIMJStoreButtonStatePrepareDownload || self.storeState==UIMJStoreButtonStateDownload){
                size.width = size.height;
            }
            origin.x = 0;
        }
            break;
        case UIControlContentHorizontalAlignmentRight:{
            size.width = size.width;
            if(self.storeState==UIMJStoreButtonStatePrepareDownload || self.storeState==UIMJStoreButtonStateDownload){
                size.width = size.height;
            }
            origin.x = (self.frame.size.width - size.width);
            
        }
            break;
        case UIControlContentHorizontalAlignmentFill:{
            size.width = self.frame.size.width;
            if(self.storeState==UIMJStoreButtonStatePrepareDownload || self.storeState==UIMJStoreButtonStateDownload){
                size.width = size.height;
            }
            origin.x = 0;
        }
            break;
        default:{
            origin.x = (self.frame.size.width - size.width)/2.0f;
        }
            break;
    }
    
    if(self.storeState==UIMJStoreButtonStateDownload || self.storeState ==  UIMJStoreButtonStatePrepareDownload){
        size.height = self.frame.size.height;
        origin.y = 0;
    }
    
    
    return CGRectMake(origin.x, origin.y, size.width, size.height);
}

- (CAAnimation *)animationForSpinning
{
    // Create a transform to rotate in the z-axis
    float radians = DEGREES_TO_RADIANS(90);
    CATransform3D transform;
    transform = CATransform3DMakeRotation(radians, 0, 0, 1.0);
    
    // Create a basic animation to animate the layer's transform
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = .5;
    animation.cumulative = YES;
    animation.repeatCount = INFINITY;
    return animation;
}

- (void)animationForStartAngle:(CGFloat)startAngle {
    CABasicAnimation* downloadingAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    downloadingAnimation.duration = 0.3f;
    downloadingAnimation.fromValue = @(startAngle);
    downloadingAnimation.toValue = @(1.0f);
    [shapeLayer addAnimation:downloadingAnimation forKey:downloadingAnimation.keyPath];
}

@end
