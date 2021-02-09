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
    frame = CGRectZero;
    image = [[NSArray alloc]initWithObjects:@"bg1.png",@"bg2.png",@"bg3.png",@"bg4.png",nil];
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    //scrollView.isPagingEnabled = true;
    scrollView.backgroundColor =  [UIColor blackColor];
    [super viewDidLoad];
    [self.view addSubview:scrollView];
    [self setupScreens];
    
}

- (void) setupScreens {
    for(int idx = 0; idx < image.count;idx++){
        frame.origin.x = scrollView.frame.size.width * idx;
        frame.size = scrollView.frame.size;
        ImageScrollView *imageScrollView = [[ImageScrollView alloc] init:frame];
        NSLog(image[idx]);
        UIImage *images = [UIImage imageNamed:image[idx]];
        [imageScrollView set:images];
        [scrollView addSubview:imageScrollView];
 
    }
    
    scrollView.contentSize = CGSizeMake((scrollView.frame.size.width * image.count), scrollView.frame.size.height);
    scrollView.delegate = self;
}

@end
