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
-(CGRect) frame{
  return  CGRectZero;
}
-(NSArray*) image{
    return [[NSArray alloc]initWithObjects:@"bg1.png",@"bg2.png",@"bg3.png",@"bg4.png",nil];
}
-(UIPageControl*) pageControl{
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.currentPage = 0;
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    return pageControl;
}
-(UIScrollView*) scrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    //scrollView.isPagingEnabled = true;
    scrollView.backgroundColor =  [UIColor blackColor];


    return scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:scrollView];
    pageControl.numberOfPages = image.count;
    [self setupScreens];
    [self.view addSubview:pageControl];
}

- (void) setupScreens {
    [image enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        frame.origin.x = scrollView.frame.size.width * idx;
        frame.size = scrollView.frame.size;
        ImageScrollView *imageScrollView = [[ImageScrollView alloc] init:frame];
        [imageScrollView set:[[UIImage]imageNamed:@image[idx]]];
        [self.scrollView addSubview:imageScrollView];
 
    }];

    
 /*   for index in 0..<image.count {
        frame.origin.x = scrollView.frame.size.width * CGFloat(index)
        frame.size = scrollView.frame.size
        let imageScrollView = ImageScrollView(frame: frame)
        imageScrollView.set(image: UIImage(named: image[index])!)
        self.scrollView.addSubview(imageScrollView)
    }
  */
    scrollView.contentSize = CGSizeMake((scrollView.frame.size.width * image.count), scrollView.frame.size.height);
    scrollView.delegate = self;
}
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    double pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width;
    pageControl.currentPage = pageNumber;
}
@end
