#import <UIKit/UIKit.h>
#import "MIContext.h"
#import "MIConsumer.h"
#import "MITexture.h"

#define ScreenBound CGSizeMake(390, 844)

@interface MIView : UIView <MIConsumer>
{
    MITexture *_inputTexture;
    id<MTLRenderPipelineState> _renderPipelineState;
    MTLRenderPassDescriptor *_renderPassDescriptor;
    id<MTLBuffer> _positionBuffer;
    CGRect _preRenderRect;
    BOOL _layerSizeDidUpdate;
    
#if !TARGET_IPHONE_SIMULATOR
    CAMetalLayer *_metalLayer;
#endif
}

@property (nonatomic, readwrite, assign) CGSize contentSize;
@property (nonatomic, readwrite, getter=isEnabled) BOOL enabled;
@property (nonatomic, readwrite) MTLClearColor clearColor;


@end
