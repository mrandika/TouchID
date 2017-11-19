//
//  ViewController.m
//  Touch ID
//
//  Created by Andika on 19/11/17.
//  Copyright © 2017 Andika. All rights reserved.
//

#import "ViewController.h"
#import "LocalAuthentication/LocalAuthentication.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidAppear:(BOOL)animated {
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"Verifikasi diri.";
    
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self performSegueWithIdentifier:@"sukses" sender:nil];
                                    });
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Kesalahan!" message:@"Gagal mengautentikasi. \n\nAlasan: \nDibatalkan atau tidak ada kecocokan data yang diberikan oleh pengguna." preferredStyle:UIAlertControllerStyleAlert];
                                        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                                        [self presentViewController:alertController animated:YES completion:nil];
                                    });
                                }
                            }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Kesalahan!" message:@"Gagal mengautentikasi. \n\nAlasan: \nAda kesalahan menghubungi sensor." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
