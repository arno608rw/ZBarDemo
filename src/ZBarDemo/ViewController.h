//
//  ViewController.h
//  ZBarDemo
//
//  Created by Isaac Overacker on 6/26/13.
//
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ViewController : UIViewController <ZBarReaderDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) IBOutlet UILabel* upcLabel;

- (IBAction)scanButtonTapped:(id)sender;

@end
