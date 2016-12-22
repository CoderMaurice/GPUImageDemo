//
//  rootController.m
//  GPUImageDemo
//
//  Created by Maurice on 2016/10/28.
//  Copyright © 2016年 Maurice. All rights reserved.
//

#import "rootController.h"
#import "firstViewController.h"

@interface rootController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation rootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self choosePhoto];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (IBAction)choose:(id)sender
{
    [self choosePhoto];
}

- (void)choosePhoto
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册",nil];
    [sheet showInView:self.view];
}

#pragma mark - actionSheet代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self selectForCameraButtonClick];
            break;
        case 1:
            [self selectForAlbumButtonClick];
            break;
        default:
            return;
    }
}

//拍照
- (void)selectForCameraButtonClick
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [self setupImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else {
        [self showErrorWithTitle:@"不能使用拍照功能"];
    }
}

//相册
- (void)selectForAlbumButtonClick
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        [self setupImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else {
        [self showErrorWithTitle:@"访问图片库错误"];
    }
}

- (void)setupImagePickerControllerWithSourceType:(NSUInteger)source
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = source;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)showErrorWithTitle:(NSString *)title
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:title
                          message:@""
                          delegate:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - imagePickerController代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //移除图片选取器
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",NSStringFromCGSize(image.size));
    UIStoryboard * mainStoryBoard =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    firstViewController * first = [mainStoryBoard instantiateViewControllerWithIdentifier:@"image"];
    first.image = image;
    [self.navigationController pushViewController:first  animated:YES];
    
}


@end
