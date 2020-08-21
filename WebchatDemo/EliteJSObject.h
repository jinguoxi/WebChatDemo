#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ChatViewController.h"
 
//首先创建一个实现了JSExport协议的协议
@protocol EliteJSObjectProtocol <JSExport>
 
//此处我们测试几种参数的情况
-(void)close;

@end
 
//让我们创建的类实现上边的协议
@interface EliteJSObject : NSObject<EliteJSObjectProtocol>
 
@end
