//
//  LSTabBarButton.m
//  TabBar
//
//  Created by Airy on 16/4/12.
//  Copyright © 2016年 Airy. All rights reserved.
//

#import "LSTabBarButton.h"

#import "LSBadgeButton.h"

@interface LSTabBarButton ()

@property (nonatomic, strong) LSBadgeButton  *badgeButton;

@end

@implementation LSTabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue"];
}

- (LSBadgeButton *)badgeButton
{
    if (!_badgeButton) {
        
        _badgeButton = [[LSBadgeButton alloc] init];
        [self addSubview:_badgeButton];
    }
    return _badgeButton;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:item.title forState:UIControlStateNormal];
    [self setImage:item.image forState:UIControlStateNormal];
    [self setImage:item.selectedImage forState:UIControlStateSelected];
    
    [_item addObserver:self
            forKeyPath:@"badgeValue"
               options:NSKeyValueObservingOptionNew
               context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    UITabBarItem *item = object;
    
    self.badgeButton.badgeValue = item.badgeValue;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    UIImage *image =  [self imageForState:UIControlStateNormal];
    CGFloat titleY = image.size.height + 5;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    
    return CGRectMake(0, titleY, self.bounds.size.width,  titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    UIImage *image = [self imageForState:UIControlStateNormal];
    
    return CGRectMake(0, 7, contentRect.size.width, image.size.height);
}
@end
