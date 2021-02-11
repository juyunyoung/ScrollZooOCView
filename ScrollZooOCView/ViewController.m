//
//  ViewController.m
//  ScrollZooOCView
//
//  Created by yunyoung ju on 2021/02/06.
//

#import "ViewController.h"
#import "ImageScrollView.h"
@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    frame = CGRectZero;
    beforePage= 1;
    image = [[NSArray alloc]initWithObjects:@"bg1.png",@"bg2.png",@"bg3.png",@"bg4.png",nil];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [scrollView setPagingEnabled:YES];
    
    self.view.backgroundColor =  [UIColor blackColor];
    
    [self.view addSubview:scrollView];
    [self setupScreens];
    
}

- (void) setupScreens {
    for(int idx = 0; idx < image.count;idx++){
        frame.origin.x = scrollView.frame.size.width * idx;
        frame.size = scrollView.frame.size;
        ImageScrollView *imageScrollView = [[ImageScrollView alloc] init:frame];
        imageScrollView.tag = idx+1;
        UIImage *images = [UIImage imageNamed:image[idx]];
        [imageScrollView set:images];
        [scrollView addSubview:imageScrollView];
 
    }
    
    scrollView.contentSize = CGSizeMake((scrollView.frame.size.width * image.count), scrollView.frame.size.height);
    scrollView.delegate = self;
}
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger pageNumber = (scrollView.contentOffset.x / scrollView.frame.size.width)+1;
    ImageScrollView *srollview = [self.view viewWithTag:beforePage];
    if((beforePage != (NSInteger) pageNumber) && (srollview.zoomScale != srollview.minimumZoomScale)){
        srollview.zoomScale = srollview.minimumZoomScale;
    }
    beforePage = pageNumber;
}
@end
