#import "MIFilter.h"

@interface MIExposureFilter : MIFilter
{
    id<MTLBuffer> _exposureBuffer;
}

// Exposure ranges from -10.0 to 10.0, with 0.0 as the normal level
@property (nonatomic) float exposure;

@end
