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
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *url = [ user objectForKey:@"url"];
    self.url.text = url ? url : @"https://test.elitecrm.com/webchat/interfacePools.do?queue=213&from=mobile&device=mobile";
//    self.url.text = @"https://test.elitecrm.com/webchat/interfacePools.do?queue=213&from=mobile&device=mobile";
}

//- (ChatViewController *)chatViewController {
//    if (!_chatViewController) {
////        _chatViewController = [[ChatViewController alloc] init];
//        _chatViewController = [[ChatViewController alloc] initWithNibName:@"EliteWebChat" bundle:nil];
//    }
//    return _chatViewController;
//}


- (IBAction)webChatPressed:(id)sender {
     [self switchChatViewController: @"32132"];
     
}

- (void)switchChatViewController: (NSString *)title {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.url.text forKey:@"url"];
    //删除会话页面
    if (_chatViewController) {
        [self.chatViewController.view removeFromSuperview];
        self.chatViewController = nil;
    }
    ChatViewController *charViewController = [ChatViewController getInstance:self.url.text force:1];

    [self.navigationController pushViewController:charViewController animated:nil];
    
}

@end
