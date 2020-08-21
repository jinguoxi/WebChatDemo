//
//  ViewController.m
//  WebchatDemo
//
//  Created by EliteCRM on 2020/8/19.
//  Copyright © 2020 EliteCRM. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *url;
@property (strong, nonatomic) ChatViewController *chatViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (ChatViewController *)chatViewController {
    if (!_chatViewController) {
//        _chatViewController = [[ChatViewController alloc] init];
        _chatViewController = [[ChatViewController alloc] initWithNibName:@"EliteWebChat" bundle:nil];
    }
    return _chatViewController;
}


- (IBAction)webChatPressed:(id)sender {
     [self switchChatViewController: @"32132"];
     
}

- (void)switchChatViewController: (NSString *)title {
    //删除会话页面
    if (_chatViewController) {
        [self.chatViewController.view removeFromSuperview];
        self.chatViewController = nil;
    }
    
    self.chatViewController.title = title;
    
    [self.navigationController pushViewController: self.chatViewController animated:true];
    [self dismissModalViewControllerAnimated:YES];

    // [MAMessageUtils sendTxtMessage:@"txtmessage"];
    
    //显示聊天会话界面
//    [self.navigationController pushViewController:self.chatViewController animated:YES];
    
}

@end
