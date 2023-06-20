#import "MIFilter.h"

@interface MIHueFilter : MIFilter
{
    id<MTLBuffer> _hueAdjustBuffer;
}

@property (nonatomic) float hue;

@end
