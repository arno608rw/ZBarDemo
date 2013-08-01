//
//  ViewController.m
//  ZBarDemo
//
//  Created by Isaac Overacker on 6/26/13.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ZBarReaderViewController* readerViewController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.readerViewController = [ZBarReaderViewController new];
    self.readerViewController.readerDelegate = self;
    self.readerViewController.supportedOrientationsMask = ZBarOrientationMask(UIInterfaceOrientationPortrait);

    ZBarImageScanner *scanner = self.readerViewController.scanner;

    // Disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];

    self.upcLabel.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanButtonTapped:(id)sender
{    
    [self presentViewController:self.readerViewController
                       animated:YES
                     completion:^{}];
}

#pragma mark - ZBarReaderControllerDelegate

- (void)readerControllerDidFailToRead:(ZBarReaderController*)reader withRetry:(BOOL)retry
{
    NSLog(@"ZBarReaderController failed to read. retry = %c", retry);
    self.upcLabel.text = @"Failed";
}

#pragma mark - UIImagePickerControllerDelegate
// ZBarReaderControllerDelegate sends UIImagePickerController messages to its delegate as well.

- (void)imagePickerController:(UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    // Grab first symbol
    for (symbol in results)
        break;

    self.upcLabel.text = symbol.data;

    [reader dismissViewControllerAnimated:YES completion:^{}];
}

@end
