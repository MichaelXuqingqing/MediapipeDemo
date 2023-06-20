#import "MICameraViewController.h"
#import "MIVideoCaptor.h"
#import "MIView.h"
#import "MIFilter.h"
#import "MIHueFilter.h"
#import "MISaturationFilter.h"
#import <FaceMeshIOSLibFramework/FaceMeshIOSLib.h>


@interface MICameraViewController ()<MIVideoCaptorDelegate, FaceMeshIOSLibDelegate>

@property (nonatomic,strong)MIVideoCaptor *videoCaptor;
@property (nonatomic,strong)MIFilter *defaultFilter;
@property (nonatomic,strong)MIView *displayView;
@property (nonatomic,strong)FaceMeshIOSLib *faceMesh;
@property (nonatomic,strong)UIView *pointView;

@end

@implementation MICameraViewController

- (void)dealloc
{
    [_videoCaptor stopRunning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    //Display
    CGFloat width = ScreenBound.width;
    CGFloat height = ScreenBound.height;
    _displayView = [[MIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [self.view addSubview:_displayView];
    _displayView.backgroundColor = [UIColor whiteColor];
    
    //FaceMesh
    self.faceMesh = [[FaceMeshIOSLib alloc] init];
    self.faceMesh.delegate = self;
    [self.faceMesh startGraph];
    
    
    //VideoCamera
    _videoCaptor = [[MIVideoCaptor alloc] initWithCameraPosition:AVCaptureDevicePositionFront sessionPreset:AVCaptureSessionPreset1920x1080];
    _videoCaptor.delegate = self;
    
    _defaultFilter = [[MIFilter alloc] init];
    
    NSInteger displayViewWidth = _displayView.contentSize.width;
//    NSInteger displayViewHeight = _displayView.contentSize.height;
    _defaultFilter.outputFrame = CGRectMake(0,
                                            0,
                                            displayViewWidth,
                                            (int)(displayViewWidth * 16/9.0));
    
    [_videoCaptor addConsumer:_defaultFilter];
    [_defaultFilter addConsumer:_displayView];
    [_videoCaptor startRunning];
    
    self.pointView = [[UIView alloc] init];
    self.pointView.backgroundColor = [UIColor redColor];
    self.pointView.layer.cornerRadius = 2;
    [_displayView addSubview:self.pointView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_videoCaptor removeAllConsumers];
    [_videoCaptor stopRunning];
}

#pragma mark - Video Delegate

-(void)videoCaptor:(MIVideoCaptor *)videoCaptor willOutputVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    CVPixelBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self.faceMesh processVideoFrame:imageBuffer];
}

- (void)didReceiveFaces:(NSArray <NSArray<FaceMeshIOSLibFaceLandmarkPoint *>*>*)faces {
    /*
    // Mediapipe Facepoint map: https://github.com/google/mediapipe/blob/a908d668c730da128dfa8d9f6bd25d519d006692/mediapipe/modules/face_geometry/data/canonical_face_model_uv_visualization.png
    NSDictionary *mapDic = @{@"159": @"3.2",
                             @"159": @"3.2",
                             @"145": @"3.4",
                             @"155": @"3.8",
                             @"130": @"3.12",
                             @"386": @"3.1",
                             @"374": @"3.3",
                             @"263": @"3.7",
                             @"362": @"3.11",
                             @"4": @"9.3",
                             @"98": @"9.2",
                             @"455": @"9.1",
                             @"0": @"8.1",
                             @"17": @"8.2",
                             @"57": @"8.4",
                             @"287": @"8.3"
    };
    */
    
    dispatch_async(dispatch_get_main_queue(), ^{
        FaceMeshIOSLibFaceLandmarkPoint *point = faces[0][4];
        NSLog(@"nose point: x:%f, y:%f", point.x, point.y);
        CGFloat scale = [UIScreen mainScreen].nativeScale;
        self.pointView.frame = CGRectMake(point.y * self.defaultFilter.outputFrame.size.width / scale, point.x * self.defaultFilter.outputFrame.size.height / scale, 4, 4);
    });
}
@end
