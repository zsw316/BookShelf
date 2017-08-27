//
//  BookScannerViewController.m
//  BookShelf
//
//  Created by ShaoweiZhang on 24/7/2017.
//  Copyright © 2017 simpletask. All rights reserved.
//

#import "BookScannerViewController.h"
#import "BookScanView.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>

#import "BookEntity.h"
#import "BookDetailService.h"

#import "BookDetailViewController.h"

const CGFloat scanRectWidth = 230.0f;
const CGFloat scanRectHeight = 230.0f;
const CGFloat scanRectOffsetY = -43.0f;
const CGFloat tipLabelHeight = 44.0f;

@interface BookScannerViewController () <AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) BookScanView *scanView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) AVCaptureSession *captureSession;

@property (nonatomic, assign) BOOL hasViewControllerPushed;

@end

@implementation BookScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor redColor];
    self.hasViewControllerPushed = NO;
    
    [self initNavigation];
    [self initSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)initNavigation {

    // Back button
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-button"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // Flash button
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flashButton setImage:[UIImage imageNamed:@"light-off"] forState:UIControlStateNormal];
    [flashButton setImage:[UIImage imageNamed:@"light-on"] forState:UIControlStateSelected];
    [flashButton sizeToFit];
    [flashButton addTarget:self action:@selector(didTapFlashButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:flashButton];
    
    self.navigationController.delegate = self;
}

- (void)didTapBackButton:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didTapFlashButton:(UIButton *)button {
    button.selected = !button.selected;
    
    // Turn on/off flashlight
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Check if it is a Pop
    if ([viewController isKindOfClass:[self class]] && self.hasViewControllerPushed) {
        self.hasViewControllerPushed = NO;
        
        [self.captureSession startRunning];
        [self.scanView startAnimation];
    }
}

#pragma mark - initSubviews

- (void)initSubviews {
    [self initCamera];
    [self initScannerView];
    [self initTip];
}

- (void)initCamera {
    // Request authorization
    [self requestAuthorization:^(BOOL granted) {
        [self performSelectorOnMainThread:@selector(requestAuthorizationFinished:) withObject:@(granted) waitUntilDone:NO];
    }];
    
    // Init capture session
    self.captureSession = [[AVCaptureSession alloc] init];
    
    [self.captureSession beginConfiguration];
    
    // Get capture device
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Add capture input
    NSError *error = nil;
    AVCaptureDeviceInput *captureInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error == nil) {
        if ([self.captureSession canAddInput:captureInput]) {
            [self.captureSession addInput:captureInput];
        }
    } else {
        NSLog(@"Input Error: %@", error);
    }
    
    // Add capture output
    AVCaptureMetadataOutput *captureOutput = [[AVCaptureMetadataOutput alloc] init];
    [captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    if ([self.captureSession canAddOutput:captureOutput]) {
        [self.captureSession addOutput:captureOutput];
        captureOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code];
    }
    
    // Add preview layer
    CALayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:previewLayer];
    
    [self.captureSession commitConfiguration];
    
    [self.captureSession startRunning];
}

- (void)initScannerView {
    self.scanView = [[BookScanView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) rectSize:CGSizeMake(scanRectWidth, scanRectHeight) offsetY:scanRectOffsetY];
    self.scanView.backgroundColor = [UIColor clearColor];
    self.scanView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scanView];
    
    [self.scanView startAnimation];
}

- (void)initTip {
    self.tipLabel = [[UILabel alloc] init];
    self.tipLabel.bounds = CGRectMake(0, 0, scanRectWidth, tipLabelHeight);
    self.tipLabel.center = CGPointMake(self.scanView.center.x, self.scanView.center.y + scanRectOffsetY + scanRectHeight/2.0f + tipLabelHeight/2.0);
    self.tipLabel.textColor = [UIColor whiteColor];
    self.tipLabel.backgroundColor = [UIColor clearColor];
    self.tipLabel.font = [UIFont systemFontOfSize:12.0f];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.text = @"Scan barcodes to query online books";
    [self.view addSubview:self.tipLabel];
}

#pragma mark - Camera
- (void)requestAuthorization:(void (^)(BOOL granted))handler {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:handler];
    } else if (handler){
        handler(status == AVAuthorizationStatusAuthorized);
    }
}

- (void)requestAuthorizationFinished:(NSNumber *)granted {
    if ([granted boolValue]) {
        
    } else {
        // handle error
    }
}

#pragma mark - ISBN
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *ISBN = nil;
    
    for(AVMetadataObject *metadata in metadataObjects) {
        ISBN = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
        break;
    }
    
    if (ISBN) {
        NSLog(@"%@", ISBN);
        [self.captureSession stopRunning];
        [self.scanView stopAnimation];
        [self fetchBookWithISBN:ISBN];
    }
}

- (void)fetchBookWithISBN:(NSString *)ISBN {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.douban.com/v2/book/isbn/%@", ISBN]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error: %@", error);
            [self.captureSession startRunning];
            [self.scanView startAnimation];
        } else {
            NSLog(@"%@, %@", response, responseObject);
            
            NSString *title = [responseObject objectForKey:@"title"];
            NSArray *authorList = [responseObject objectForKey:@"author"];
            
            NSString *author = nil;
            if (authorList.count > 0) {
                author = [authorList firstObject];
            }
        
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Prompt" message:[NSString stringWithFormat:@"%@/n%@/n%@", title, ISBN, author] preferredStyle:UIAlertControllerStyleAlert];
            
            BookEntity *bookEntity = [[BookEntity alloc] initWithDictionary:responseObject];
            
            UIAlertAction *detailAction = [UIAlertAction actionWithTitle:@"View details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                BookDetailViewController *controller = [[BookDetailViewController alloc] init];
                [controller setBookEntity:bookEntity];
                [self.navigationController pushViewController:controller animated:YES];
                self.hasViewControllerPushed = YES;
            }];
            [alertController addAction:detailAction];
            
            BookEntity *favedBookEntity = [BookDetailService searchFavedBookWithDoubanId:bookEntity.doubanId];
            if (favedBookEntity == nil) {
                UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"Favorite and Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    long long bookId = [BookDetailService favBook:bookEntity];
                    if (!bookId) {
                        NSLog(@"favBook fail");
                    }
                    [self.captureSession startRunning];
                    [self.scanView startAnimation];
                }];
                [alertController addAction:nextAction];
            }
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
    
    [dataTask resume];
}

#pragma mark - navigation config
- (BOOL)shouldShowShadowImage {
    return NO;
}

- (UIImage *)navigationBarBackgroundImage {
    return [UIImage new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
