//
//  ViewController.h
//  ScrollZooOCView
//
//  Created by yunyoung ju on 2021/02/06.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    CGRect frame;
    NSArray *image;
    UIScrollView *scrollView;
}
- (void) setupScreens;
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
@end

