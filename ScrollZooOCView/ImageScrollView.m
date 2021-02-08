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

 
UITapGestureRecognizer *zoomingTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleZoomingTap)];
zoomingTap.numberOfTapsRequired = 2;
     


override init:(CGRect)frame {
    [super init:(CGRect)frame];
    
    self.delegate = self
    self.showsVerticalScrollIndicator = false
    self.showsHorizontalScrollIndicator = false
    self.decelerationRate = UIScrollView.DecelerationRate.fast
}
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
// gesture
-(void) handleZoomingTap:(UITapGestureRecognizer *)sender{
    CGPoint location = [sender location: sender.view];
    [self zoom:location, animated: true];
}
-(void)  set:UIImage image {
    
    imageZoomView?.removeFromSuperview()
    imageZoomView = nil
    imageZoomView = UIImageView(image: image)
    self.addSubview(imageZoomView)
    
    configurateFor(imageSize: image.size)
}

-(void)  configurateFor:(CGSize) imageSize {
    self.contentSize = imageSize;
    
    [self setCurrentMaxandMinZoomScal]
    self.zoomScale = self.minimumZoomScale;
    
    self.imageZoomView.addGestureRecognizer(self.zoomingTap)
    self.imageZoomView.isUserInteractionEnabled = Yes

}

override func layoutSubview {
    [super layoutSubview]
    [self centerImag];
}

-(void)  setCurrentMaxandMinZoomScale {
    let boundsSize = self.bounds.size
    let imageSize = imageZoomView.bounds.size
    
    let xScale = boundsSize.width / imageSize.width
    let yScale = boundsSize.height / imageSize.height
    let minScale = min(xScale, yScale)
    
    var maxScale: CGFloat = 1.0
    if minScale < 0.1 {
        maxScale = 0.3
    }
    if minScale >= 0.1 && minScale < 0.5 {
        maxScale = 0.7
    }
    if minScale >= 0.5 {
        maxScale = max(1.0, minScale)
    }
    
    self.minimumZoomScale = minScale
    self.maximumZoomScale = maxScale
}

-(void)  centerImage {
    let boundsSize = self.bounds.size
    var frameToCenter = imageZoomView.frame
    
    if frameToCenter.size.width < boundsSize.width {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
    } else {
        frameToCenter.origin.x = 0
    }
    
    if frameToCenter.size.height < boundsSize.height {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
    } else {
        frameToCenter.origin.y = 0
    }
    
    imageZoomView.frame = frameToCenter
}



-(void) zoom(point: CGPoint, animated: Bool) {
    let currectScale = self.zoomScale
    let minScale = self.minimumZoomScale
    let maxScale = self.maximumZoomScale
    
    if (minScale == maxScale && minScale > 1) {
        return
    }
    
    let toScale = maxScale
    let finalScale = (currectScale == minScale) ? toScale : minScale
    let zoomRect = self.zoomRect(scale: finalScale, center: point)
    self.zoom(to: zoomRect, animated: animated)
}

-(void) zoomRect:(CGFloat)scale: var:(CGPoint)center  {
    var zoomRect = CGRect.zero;
    let bounds = self.bounds;
    
    zoomRect.size.width = bounds.size.width / scale;
    zoomRect.size.height = bounds.size.height / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2);
    return zoomRect;
}

-(UIView) viewForZooming(in scrollView: UIScrollView) {
    return self.imageZoomView;
}

-(void) scrollViewDidZoom(_ scrollView: UIScrollView) {
    [self centerImage ];
}

@end
