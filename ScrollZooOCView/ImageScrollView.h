//
//  ImageScrollView.h
//  ScrollZooOCView
//
//  Created by yunyoung ju on 2021/02/07.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView<UIScrollViewDelegate>{
    
    UIImageView *imageZoomView;
    UITapGestureRecognizer *UITapGestureRecognizer;
    
}
-(id)init:(CGRect) frame;
-(void)set:(UIImage*) image ;
-(void)configurateFor:(CGSize) imageSize;
-(void)layoutSubviews;
-(void)setCurrentMaxandMinZoomScale;
-(void)centerImage;
-(void)handleZoomingTap:(UITapGestureRecognizer *)sender;
-(void)zoom:(CGPoint)point animated:(bool) animated;
-(CGRect)zoomRect:(CGFloat)scale centers:(CGPoint)center ;
-(UIView*)viewForZooming;
-(void)scrollViewDidZoom;
-(UIView *) viewForZoomingInScrollView:(UIScrollView *)inScroll ;
@end /* ImageScrollView_h */
