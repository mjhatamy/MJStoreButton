//
//  StoreButton.h
//  StoreButton
//
//  Created by Majid Hatami Aghdam on 1/31/17.
//  Copyright © 2017 Majid Hatami Aghdam. All rights reserved.
//

/*
  Button Type must be Custom
 */

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, UIMJStoreButtonState){
    UIMJStoreButtonStateGet =             0,
    UIMJStoreButtonStateBuy =             1 << 0,
    UIMJStoreButtonStatePrepareDownload = 1 << 1,
    UIMJStoreButtonStateDownload        = 1 << 2,
    UIMJStoreButtonStateOpen            = 1 << 3
};

IB_DESIGNABLE
@interface MJStoreButton : UIButton{
    CALayer *mainLayer;
    CAShapeLayer *shapeLayer;
    CAShapeLayer *boxLayer;
    BOOL hasTouch;
    BOOL isTouchInside;
    
    UIMJStoreButtonState m_storeState;
    CGFloat m_progress;
    CGFloat lastProgress;
    
    BOOL isInterfaceBuilder;
}

@property (nonatomic, copy) IBInspectable UIColor* bgColor;
@property (nonatomic, copy) IBInspectable UIColor* borderColor;
@property (nonatomic, copy) IBInspectable UIColor* borderHighlitedColor;

@property (nonatomic, copy) IBInspectable UIColor* buyBorderColor;
@property (nonatomic, copy) IBInspectable UIColor* buyBorderHighlitedColor;

@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat borderRadius;

@property (nonatomic, copy) IBInspectable NSString* getText;
@property (nonatomic, copy) IBInspectable NSString* buyText;
@property (nonatomic, copy) IBInspectable NSString* openText;

@property (nonatomic) IBInspectable UIMJStoreButtonState storeState;
@property (nonatomic) IBInspectable NSTextAlignment textAlignment;
@property (nonatomic) IBInspectable CGFloat progress;
@property (nonatomic) IBInspectable CGFloat progressArcWidth;
@end
