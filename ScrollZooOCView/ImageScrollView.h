//
//  ImageScrollView.h
//  ScrollZooOCView
//
//  Created by yunyoung ju on 2021/02/07.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIViewController<UIScrollViewDelegate>{
    
    UIImageView *imageZoomView;
    UITapGestureRecognizer *UITapGestureRecognizer;
    
}
-(void)init;
-(void)set;
-(void)configurateFor;
-(void)layoutSubviews;
-(void)setCurrentMaxandMinZoomScale;
-(void)centerImage;
-(void)handleZoomingTap;
-(void)zoom;
-(void)zoomRect;
-(void)viewForZooming;
-(void)scrollViewDidZoom;
@end /* ImageScrollView_h */
