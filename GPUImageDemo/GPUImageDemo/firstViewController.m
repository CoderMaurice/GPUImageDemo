//
//  firstViewController.m
//  GPUImageDemo
//
//  Created by Maurice on 2016/10/27.
//  Copyright © 2016年 Maurice. All rights reserved.
//

#import "firstViewController.h"
#import "GPUImage.h"


@interface firstViewController ()

@property (weak, nonatomic) IBOutlet GPUImageView *GPUImgView;

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *contrastSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *sharpenSlider;
@property (weak, nonatomic) IBOutlet UISlider *ExposureSlider;
@property (weak, nonatomic) IBOutlet UISlider *GammaSlider;
@property (weak, nonatomic) IBOutlet UISlider *HighlightShadow1Slider;
@property (weak, nonatomic) IBOutlet UISlider *HighlightShadow2Slider;

@property (nonatomic, strong) GPUImageBrightnessFilter *brightnessFilter;
@property (nonatomic, strong) GPUImageContrastFilter *ContrastFilter;
@property (nonatomic, strong) GPUImageSaturationFilter * SaturationFilter;
@property (nonatomic, strong) GPUImageSharpenFilter *SharpenFilter;
@property (nonatomic, strong) GPUImageExposureFilter *ExposureFilter;
@property (nonatomic, strong) GPUImageGammaFilter *GammaFilter;
@property (nonatomic, strong) GPUImageHighlightShadowFilter *HighlightShadowFilter;

@property (nonatomic, strong) GPUImagePicture *stillImageSource;
@property (nonatomic, strong) GPUImageFilterPipeline *pipeline ;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContrastLabel;
@property (weak, nonatomic) IBOutlet UILabel *SaturationLabel;
@property (weak, nonatomic) IBOutlet UILabel *SharpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *ExposureLabel;
@property (weak, nonatomic) IBOutlet UILabel *GammaLabel;
@property (weak, nonatomic) IBOutlet UILabel *HighlightShadow1Label;
@property (weak, nonatomic) IBOutlet UILabel *HighlightShadow2Label;

//@property (strong, nonatomic) UIImage *source;
@property (nonatomic, strong)  NSMutableArray *filterArr;

@end

@implementation firstViewController

- (NSMutableArray *)filterArr
{
    if (!_filterArr) {
        _filterArr = [NSMutableArray array];
    }
    return _filterArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self handleImage];
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    if (!_image) return;
    
    switch (sender.tag) {
        case 1:
            _brightnessFilter.brightness = sender.value;
            _brightnessLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            [_stillImageSource processImage];
            break;
        case 2:
            _ContrastFilter.contrast = sender.value;
            [_stillImageSource processImage];
            _ContrastLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 3:
            _SaturationFilter.saturation = sender.value;
            [_stillImageSource processImage];
            _SaturationLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 4:
            _SharpenFilter.sharpness = sender.value;
            [_stillImageSource processImage];
            _SharpenLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 5:
            _ExposureFilter.exposure = sender.value;
            [_stillImageSource processImage];
            _ExposureLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 6:
            _GammaFilter.gamma = sender.value;
            [_stillImageSource processImage];
            _GammaLabel.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 7:
            _HighlightShadowFilter.shadows = sender.value;
            [_stillImageSource processImage];
            _HighlightShadow1Label.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 8:
            _HighlightShadowFilter.highlights = sender.value;
            [_stillImageSource processImage];
            _HighlightShadow2Label.text = [NSString stringWithFormat:@"%.2f",sender.value];
            break;
        case 9:

            break;
    }
}

- (void)handleImage
{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:_image];
    _stillImageSource = stillImageSource;
    
    // 亮度
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [brightnessFilter forceProcessingAtSize:_image.size];
    brightnessFilter.brightness = 0;
    _brightnessFilter = brightnessFilter;
    [self.filterArr addObject:brightnessFilter];
    
    //饱和度
    GPUImageSaturationFilter * SaturationFilter = [[GPUImageSaturationFilter alloc]init];
    [SaturationFilter forceProcessingAtSize:_image.size];
    SaturationFilter.saturation = 1.f;
    _SaturationFilter = SaturationFilter;
    [self.filterArr addObject:SaturationFilter];
    //对比度
    GPUImageContrastFilter *ContrastFilter = [[GPUImageContrastFilter alloc]init];
    [ContrastFilter forceProcessingAtSize:_image.size];
    ContrastFilter.contrast = 1.f;
    _ContrastFilter = ContrastFilter;
    [self.filterArr addObject:ContrastFilter];
    //锐化
    GPUImageSharpenFilter *SharpenFilter = [[GPUImageSharpenFilter alloc]init];
    [SharpenFilter forceProcessingAtSize:_image.size];
    SharpenFilter.sharpness = 0;
    _SharpenFilter = SharpenFilter;
    [self.filterArr addObject:SharpenFilter];
    
    // 曝光
    GPUImageExposureFilter *ExposureFilter = [[GPUImageExposureFilter alloc]init];
    [ExposureFilter forceProcessingAtSize:_image.size];
    ExposureFilter.exposure = 0;
    _ExposureFilter = ExposureFilter;
    [self.filterArr addObject:ExposureFilter];
    
    // 伽马线
    GPUImageGammaFilter *GammaFilter = [[GPUImageGammaFilter alloc]init];
    [GammaFilter forceProcessingAtSize:_image.size];
    GammaFilter.gamma = 1;
    _GammaFilter = GammaFilter;
    [self.filterArr addObject:GammaFilter];
    
    // 提亮阴影
    GPUImageHighlightShadowFilter *HighlightShadowFilter = [[GPUImageHighlightShadowFilter alloc]init];
    [HighlightShadowFilter forceProcessingAtSize:_image.size];
    HighlightShadowFilter.shadows = 0.f;
    HighlightShadowFilter.highlights = 1.f;
    _HighlightShadowFilter = HighlightShadowFilter;
    [self.filterArr addObject:HighlightShadowFilter];
    
    
    //组合，把所有滤镜效果放进数组
    for (id obj in self.filterArr) {
        [stillImageSource addTarget:obj];
    }
    
    _pipeline = [[GPUImageFilterPipeline alloc]initWithOrderedFilters: self.filterArr input:stillImageSource output:self.GPUImgView];
    
    [stillImageSource processImage];
}

- (IBAction)resetSetting:(id)sender
{
    [self handleImage];
}

- (IBAction)saveImage:(id)sender
{
    [_pipeline removeAllFilters];
    [_pipeline replaceAllFilters:self.filterArr];
    [_stillImageSource processImage];
    [_HighlightShadowFilter useNextFrameForImageCapture];
    UIImage *img = [_pipeline currentFilteredFrame];
    if (img) {
        UIImageWriteToSavedPhotosAlbum(img, self, nil, NULL);
    }
}

- (IBAction)lookFullImage:(id)sender
{
    [_pipeline removeAllFilters];
    [_pipeline replaceAllFilters:self.filterArr];
    [_stillImageSource processImage];
    [_SaturationFilter useNextFrameForImageCapture];
    UIImage *img = [_pipeline currentFilteredFrame];
        NSLog(@"%@",img);
    if (img) {
        UIViewController *vc = [[UIViewController alloc]init];
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        imgView.backgroundColor = [UIColor whiteColor];
        [vc.view addSubview:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.image =img;
        [self.navigationController pushViewController:vc animated:YES];
    }
    

}

- (IBAction)selectNewImage:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
