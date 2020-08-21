#import "ChatViewController.h"
//#import <AVFoundation/AVFoundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
//#import "EliteJSObject.h"
#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ChatViewController ()<WKScriptMessageHandler>
{
    WKWebView  *_webView;
    UIButton   *_backButton;
}

@property (strong, nonatomic, readwrite) NSString *url;
@property (assign, nonatomic) int initFlag;//判断是否初始化

@end

@implementation ChatViewController
static ChatViewController *chatViewController;


+ (instancetype)getInstance : (NSString *) url force : (int) force {
    if (force == 1) {
        chatViewController = [[ChatViewController alloc] init];
        chatViewController.url = url;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            complete(chatViewController);
//        });
    } else {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            chatViewController = [[ChatViewController alloc] init];
            chatViewController.url = url;
        });
        
    }
     return chatViewController;
}

+ (instancetype)getInstance : (NSString *) url{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        chatViewController = [[ChatViewController alloc] init];
        chatViewController.url = url;
    });
    return chatViewController;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //这里把原生back隐藏
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    //! 为userContentController添加ScriptMessageHandler，并指明name
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //! 使用添加了ScriptMessageHandler的userContentController配置configuration
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    //! 使用configuration对象初始化webView
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//         // 实例化对象
//     configuration.userContentController = [WKUserContentController new];
//     // 调用原生的方法
//     [configuration.userContentController addScriptMessageHandler:self name:@"getMessage"];
////        window.webkit.messageHandlers.uploadPersonImage.postMessage({body: 'goodsId=1212'}); js调用
//     // 进行偏好设置
//     WKPreferences *preferences = [WKPreferences new];
//     preferences.javaScriptEnabled = YES;
//     preferences.javaScriptCanOpenWindowsAutomatically = YES;
//     preferences.minimumFontSize = 12.0;
//     configuration.preferences = preferences;
//
//        //webView
////    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
//    //! 使用configuration对象初始化webView
//    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) configuration:configuration];
    //设置背景色
    _webView.opaque = NO;
//    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor whiteColor];

    //1.去掉H5的水平及竖直方向的滑动条
    for (UIView * views in [_webView subviews])
    {
        if ([views isKindOfClass:[UIScrollView class]])
        {
            //去掉水平方向的滑动条
            [(UIScrollView *)views setShowsHorizontalScrollIndicator:NO];
            //去掉垂直方向的滑动条
            [(UIScrollView *)views setShowsVerticalScrollIndicator:NO];
        }
    }
    _webView.navigationDelegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: self.url]]];
    [self.view addSubview:_webView];
    //设置addScriptMessageHandler与JS对应方法名.并且设置<WKScriptMessageHandler>协议与协议方法
    

  
}
//WKScriptMessageHandler协议方法
  - (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
      //code
      NSLog(@"name = %@, body = %@", message.name, message.body);
      [self.navigationController popViewControllerAnimated:YES];
      [self dismissViewControllerAnimated:YES completion:nil];
  }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    _webView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_webView.configuration.userContentController addScriptMessageHandler:self name:@"goBack"];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"goBack"];
}

#pragma mark - Actions

//3.点击左上角的返回按钮,可以按照H5的层级返回
- (void)back:(UIBarButtonItem *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

//pragma mark - UIWebViewDelegate
// 加载完成
//- (void)webViewDidFinishLoad:(WKWebView *)webView {
////    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
////    self.navigationItem.title = title;
//    // JSContext就为其提供着运行环境 H5上下文
//    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    // 监听JS调用OC单个方法
////    jsContext[@"goBack"] = ^() {
////         NSLog(@"来了");
////        if (![NSThread isMainThread]) {
////            dispatch_async(dispatch_get_main_queue(), ^{
////               [self.navigationController popViewControllerAnimated:YES];
////            });
////            return;
////        }
////      [self.navigationController popViewControllerAnimated:YES];
////    };
//     // 监听JS调用OC对象方法
//    EliteJSObject *eliteJO = [EliteJSObject new];
//    jsContext[@"__EliteJSSDK__"] = eliteJO;
//     //模拟一下js调用方法
//    ////        NSString *jsStr1=@"eliteObject.close()";
//    ////        [jsContext evaluateScript:jsStr1];
//
//}


@end
