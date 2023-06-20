#import "MIProducer.h"
#import <UIKit/UIKit.h>


@interface MIImage : MIProducer

- (instancetype)initWithUIImage:(UIImage *)image;

@property (nonatomic, strong) UIImage *sourceImage;

- (void)processingImage;

@end


