#import "EliteJSObject.h"
#import "ChatViewController.h"
 
@implementation EliteJSObject
 
-(void)close
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ChatViewController *charViewController = [ChatViewController getInstance : nil];
       [charViewController.navigationController popViewControllerAnimated:YES];
       [charViewController dismissViewControllerAnimated:YES completion:nil];
         NSLog(@"this is ios close");
   });
    
    
}
@end
