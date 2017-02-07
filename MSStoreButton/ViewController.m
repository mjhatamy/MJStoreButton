//
//  ViewController.m
//  MSStoreButton
//
//  Created by Jid Hatami on 2/7/17.
//  Copyright © 2017 Jid Hatami. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnPressed:(id)sender {
    MJStoreButton *btn = (MJStoreButton *)sender;
    if(btn.storeState == UIMJStoreButtonStateGet){
        btn.storeState = UIMJStoreButtonStateBuy;
    }
    else if(btn.storeState == UIMJStoreButtonStateBuy){
        btn.storeState = UIMJStoreButtonStatePrepareDownload;
    }
    else if(btn.storeState == UIMJStoreButtonStatePrepareDownload){
        btn.progress = 0.0f;
        btn.storeState = UIMJStoreButtonStateDownload;
    }
    else if(btn.storeState == UIMJStoreButtonStateDownload){
        btn.progress += 0.1f;
        if(btn.progress >1.0f){
            btn.storeState = UIMJStoreButtonStateOpen;
            btn.progress = 0.0;
        }
    }
    else if(btn.storeState == UIMJStoreButtonStateOpen){
        btn.storeState = UIMJStoreButtonStateGet;
    }
}

@end
