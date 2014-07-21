//
//  UIImageView+UIActivityIndicatorForSDWebImage.m
//  UIActivityIndicator for SDWebImage
//
//  Created by Giacomo Saccardo.
//  Modified by Adrien Long.
//  Copyright (c) 2013 Giacomo Saccardo. All rights reserved.
//  Copywrong (°_-) 2013 Adrien Long. All wrongs rejected.
//

#import "UIImageView+UIProgressIndicatorForSDWebImage.h"
#import <objc/runtime.h>

static char TAG_PROGRESS_INDICATOR;

static const CGFloat indicatorWidth = 40.0f;
static const CGFloat indicatorHeight = 40.0f;

@interface UIImageView (DACircularProgressIndicatorForSDWebImagePrivate)

- (void)createActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;

@end

@implementation UIImageView (DACircularProgressIndicatorForSDWebImage)

@dynamic progressView;

- (DACircularProgressView *)progressView {
    return (DACircularProgressView *)objc_getAssociatedObject(self, &TAG_PROGRESS_INDICATOR);
}

- (void)setProgressView:(DACircularProgressView *)progressView {
    objc_setAssociatedObject(self, &TAG_PROGRESS_INDICATOR, progressView, OBJC_ASSOCIATION_RETAIN);
}

- (void)createActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    if ( ! self.progressView ) {
        
        self.progressView = [DACircularProgressView new];

        [self updateProgressViewFrame];
        
        self.progressView.autoresizingMask =  (UIViewAutoresizingFlexibleLeftMargin   |
                                               UIViewAutoresizingFlexibleRightMargin  |
                                               UIViewAutoresizingFlexibleTopMargin    |
                                               UIViewAutoresizingFlexibleBottomMargin);
        
//        self.progressView.hidesWhenStopped = YES;
        self.progressView.roundedCorners = YES;
        self.progressView.trackTintColor = trackTintColor;
        self.progressView.progressTintColor = progressTintColor;
//        self.progressView.thicknessRatio = 1.0f;
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self addSubview:self.progressView];
        });
    }
    
}

-(void)updateProgressViewFrame
{    
    //calculate the correct position
    float x = CGRectGetMidX(self.bounds) - (indicatorWidth / 2.0f);
    float y = CGRectGetMidY(self.bounds) - (indicatorHeight / 2.0f);
    
    CGRect progressViewFrame = CGRectMake(x, y, indicatorWidth, indicatorHeight);
    
    self.progressView.frame = progressViewFrame;
}

- (void)removeProgressIndicator {
    if (self.progressView) {
        [self.progressView removeFromSuperview];
        self.progressView = nil;
    }
}

-(void)updateProgress:(CGFloat)progress
{
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        //
        // Yeah... we should observe change of layout on UIImageView
        // instead of redrawing here... but that will do for now. (don't spit on me)
        [self updateProgressViewFrame];
        
        [self.progressView setProgress:progress animated:YES];
        
        if (self.progressView.progress >= 1.0f ) {
            [self.progressView setHidden:YES];
        }
    });
}

#pragma mark - Methods



- (void)setImageWithURL:(NSURL *)url usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
         placeholderImage:nil
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
         placeholderImage:placeholder
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    
    [self sd_setImageWithURL:url
         placeholderImage:nil
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (completedBlock != nil) {
                        completedBlock(image, error, cacheType, imageURL);
                    }
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
         placeholderImage:placeholder
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (completedBlock != nil) {
                        completedBlock(image, error, cacheType, imageURL);
                    }
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:options
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                        [weakSelf updateProgress:progress];
                    }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (completedBlock != nil) {
                           completedBlock(image, error, cacheType, imageURL);
                       }
                       [weakSelf removeProgressIndicator];
                   }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:options
                    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                        [weakSelf updateProgress:progress];
                        progressBlock(receivedSize,expectedSize);
                    }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                       if (completedBlock != nil) {
                           completedBlock(image, error, cacheType, imageURL);
                       }
                       [weakSelf removeProgressIndicator];
                   }
     ];
}

-(void)downloadImageWithURL:(NSURL *)url
           placeholderImage:(UIImage *)placeholder
                  completed:(SDWebImageCompletionBlock)completedBlock
usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor
          andTrackTintColor:(UIColor *)trackTintColor
{
    self.image = placeholder;
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    
    [SDWebImageManager.sharedManager
     downloadImageWithURL:url
     options:SDWebImageContinueInBackground
     progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
         [weakSelf updateProgress:progress];
         
     }
     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
     {
         completedBlock(image, error, cacheType, imageURL);
         
         [weakSelf removeProgressIndicator];
         
     }];

}



@end
