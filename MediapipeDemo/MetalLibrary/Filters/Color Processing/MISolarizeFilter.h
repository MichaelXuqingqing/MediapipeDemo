#import "MIFilter.h"

@interface MISolarizeFilter : MIFilter

{
    id<MTLBuffer> _thresholdBuffer;
}

@property (nonatomic) float threshold;

@end
