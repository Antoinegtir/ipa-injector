//
//  ViewController.m
//  ipa-injector
//
//  Created by Antoine Gonthier on 11/02/22.
//  Copyright © 2021 ipa-app. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSURL *selectedFileURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *appBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    appBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:appBarView];
    
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    selectButton.frame = CGRectMake((self.view.frame.size.width - 200) / 2, (self.view.frame.size.height - 100) / 2, 200, 50);
    [selectButton setTitle:@"Select .ipa file" forState:UIControlStateNormal];
    [selectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    selectButton.backgroundColor = [UIColor whiteColor];
    selectButton.layer.cornerRadius = 25.0;
    [selectButton addTarget:self action:@selector(selectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    

    UIButton *installButton = [UIButton buttonWithType:UIButtonTypeSystem];
    installButton.frame = CGRectMake((self.view.frame.size.width - 200) / 2, (self.view.frame.size.height - 100) / 2 + 80, 200, 50);

    NSString *buttonTitle = @"Install";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                 NSFontAttributeName: [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
    [installButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];

    installButton.backgroundColor = [UIColor blackColor];
    installButton.layer.cornerRadius = 25.0;
    [installButton addTarget:self action:@selector(installButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:installButton];

}

- (void)selectButtonPressed {
    UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.item"] inMode:UIDocumentPickerModeOpen];
    documentPicker.delegate = self;
    documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:documentPicker animated:YES completion:nil];
}

- (void)installButtonPressed {
    if (self.selectedFileURL) {
        if ([[UIApplication sharedApplication] canOpenURL:self.selectedFileURL]) {
            [[UIApplication sharedApplication] openURL:self.selectedFileURL options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"L'application a été installée avec succès !");
                } else {
                    NSLog(@"Erreur lors de l'installation de l'application.");
                }
            }];
        } else {
            NSLog(@"Le fichier .ipa n'a pas été trouvé.");
        }
    } else {
        NSLog(@"Aucun fichier .ipa sélectionné.");
    }
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    self.selectedFileURL = [urls firstObject];
    NSLog(@"Fichier .ipa sélectionné : %@", self.selectedFileURL);
}

@end

