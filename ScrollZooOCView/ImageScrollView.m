//
//  ImageScrollView.m
//  ScrollZooOCView
//
//  Created by yunyoung ju on 2021/02/07.
//

#import "ImageScrollView.h"
@interface ImageScrollView ()
    
@end

@implementation ImageScrollView

 
-(UITapGestureRecognizer*) zoomingTap {
    UITapGestureRecognizer *zoomingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleZoomingTap)];
    zoomingTap.numberOfTapsRequired = 2;
    return zoomingTap;
}


-(id)init:(CGRect) frame {
    self = [super init];
    self.frame = frame;
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor blackColor];
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    return self;
}

-(UIView*) viewForZooming:(UIScrollView *) scrollView {
    return imageZoomView;
}
-(void) scrollViewDidZoom:(UIScrollView *) scrollView{
    [self centerImage ];
}

-(void) layoutSubview {
    NSLog(@"layoutSubview");
    [super layoutIfNeeded];
    [self centerImage];
}

-(void)  set:(UIImage *) image {
    
    [imageZoomView removeFromSuperview];
    imageZoomView = nil;
    imageZoomView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageZoomView];
    
    [self configurateFor:image.size];
}

-(void)  centerImage {
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = imageZoomView.frame;
    
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }
    
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }
    
    imageZoomView.frame = frameToCenter;
}
-(void)  setCurrentMaxandMinZoomScale {
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = imageZoomView.bounds.size;
    CGFloat xScale = boundsSize.width / imageSize.width;
    CGFloat yScale = boundsSize.height / imageSize.height;
    CGFloat minScale = MIN(xScale, yScale);
    
    CGFloat maxScale = 1.0;
    if (minScale < 0.1) {
        maxScale = 0.3;
    }
    if (minScale >= 0.1 && minScale < 0.5) {
        maxScale = 0.7;
    }
    if (minScale >= 0.5) {
        maxScale = MAX(1.0, minScale);
    }
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = maxScale;
}
-(CGRect) zoomRect:(CGFloat)scale centers:(CGPoint)center  {
    CGRect zoomrect = CGRectZero;
    CGRect bounds = self.bounds;
    
    zoomrect.size.width = bounds.size.width / scale;
    zoomrect.size.height = bounds.size.height / scale;
    
    zoomrect.origin.x = center.x - (zoomrect.size.width / 2);
    zoomrect.origin.y = center.y - (zoomrect.size.height / 2);
    return zoomrect;
}

-(void) zoom:(CGPoint)point animated:(bool) animated{
    CGFloat currectScale = self.zoomScale;
    CGFloat minScale = self.minimumZoomScale;
    CGFloat maxScale = self.maximumZoomScale;
    
    if (minScale == maxScale && minScale > 1) {
        return;
    }
    
    CGFloat toScale = maxScale;
    CGFloat finalScale = (currectScale == minScale) ? toScale : minScale;
    CGRect zoomrect = [self zoomRect:finalScale centers:point];
    [super zoomToRect:zoomrect animated:animated];
}

// gesture
-(void) handleZoomingTap:(UITapGestureRecognizer *)sender{
    
    CGPoint location =   [sender locationInView: sender.view];
    [self zoom:location animated: YES];
}



-(void)  configurateFor:(CGSize) imageSize {
    self.contentSize = imageSize;
    
    [self setCurrentMaxandMinZoomScale];    
    self.zoomScale = self.minimumZoomScale;

    [imageZoomView addGestureRecognizer:self.zoomingTap];
    [imageZoomView setUserInteractionEnabled:YES];

}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)inScroll {
  return imageZoomView;
}















@end
