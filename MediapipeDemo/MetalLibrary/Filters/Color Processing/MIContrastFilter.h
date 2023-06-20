#import "MIFilter.h"

@interface MIContrastFilter : MIFilter

{
    id<MTLBuffer> _contrastBuffer;
}

/** Contrast ranges from 0.0 to 4.0 (max contrast), with 1.0 as the normal level
 */
@property (nonatomic) float contrast;

@end
