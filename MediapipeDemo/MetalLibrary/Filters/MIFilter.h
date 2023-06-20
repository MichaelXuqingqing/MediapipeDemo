#import "MIProducer.h"
#import "MIConsumer.h"
#import "MIContext.h"
#import "MITexture.h"

@interface MIFilter : MIProducer <MIConsumer>{
    MITexture *_inputTexture;
    id<MTLRenderPipelineState> _renderPipelineState;
    MTLRenderPassDescriptor *_renderPassDescriptor;
    CGSize _contentSize;
    
    id<MTLBuffer> _positionBuffer;
    CGRect _preRenderRect;
}

@property (nonatomic, readwrite) CGSize contentSize;
@property (nonatomic, readwrite) MTLClearColor clearColor;

- (instancetype)initWithContentSize:(CGSize)contentSize;

//子类设置Buffer参数
- (void)setVertexFragmentBufferOrTexture:(id<MTLRenderCommandEncoder>)commandEncoder;
+ (NSString *)vertexShaderFunction;
+ (NSString *)fragmentShaderFunction;

@end
