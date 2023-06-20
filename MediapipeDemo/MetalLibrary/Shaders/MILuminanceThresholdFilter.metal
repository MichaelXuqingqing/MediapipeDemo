#include "MIMetalShaderHeader.h"

fragment half4 MILuminanceThresholdFragmentShader(MIDefaultVertexData in [[stage_in]],
                                                   texture2d<half> colorTexture [[texture(0)]],
                                                   constant float *thresholds [[buffer(0)]])
{
    constexpr sampler sourceImage (mag_filter::linear, min_filter::linear);
    
    half threshold = thresholds[0];
    
    half4 textureColor = colorTexture.sample (sourceImage, in.textureCoordinate);
    
    half luminance = dot(textureColor.rgb, luminanceWeighting);
    float thresholdResult = step(threshold, luminance);

    textureColor = half4(half3(thresholdResult), textureColor.w);
    return textureColor;
}
