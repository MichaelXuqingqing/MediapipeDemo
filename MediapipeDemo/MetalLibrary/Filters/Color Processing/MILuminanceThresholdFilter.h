#import "MIFilter.h"

@interface MILuminanceThresholdFilter : MIFilter
{
    id<MTLBuffer> _thresholdBuffer;
}

@property (nonatomic) float threshold;

@end

