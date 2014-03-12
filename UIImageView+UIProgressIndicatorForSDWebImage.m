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
    
    if ([self progressView] == nil) {
        
        //calculate the correct position
        float x = CGRectGetMidX(self.frame) - indicatorWidth/2;
        float y = CGRectGetMidY(self.frame) - indicatorHeight/2;
        
        self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(x, y, indicatorWidth, indicatorHeight)];
        
        self.progressView.autoresizingMask = UIViewAutoresizingNone;
        
//        self.progressView.hidesWhenStopped = YES;
        self.progressView.roundedCorners = YES;
        self.progressView.trackTintColor = trackTintColor;
        self.progressView.progressTintColor = progressTintColor;
//        self.progressView.thicknessRatio = 1.0f;
        [self addSubview:self.progressView];
    }
    
}

- (void)removeProgressIndicator {
    if ([self progressView]) {
        [[self progressView] setHidden:YES];
        [[self progressView] removeFromSuperview];
        self.progressView = nil;
    }
}

-(void)updateProgress:(CGFloat)progress
{
    [self.progressView setProgress:progress animated:YES];
    
    if (self.progressView.progress >= 1.0f ) {
        [self.progressView setHidden:YES];
    }
}

#pragma mark - Methods



- (void)setImageWithURL:(NSURL *)url usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:nil
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }

                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:nil
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:0
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                 }

                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeProgressIndicator];
                }
     ];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor {
    
    [self createActivityIndicatorWithProgressTintColor:progressTintColor andTrackTintColor:trackTintColor];
    
    __weak typeof(self) weakSelf = self;
    [self setImageWithURL:url
         placeholderImage:placeholder
                  options:options
                 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                     CGFloat progress = ((CGFloat)receivedSize)/((CGFloat)expectedSize);
                     [weakSelf updateProgress:progress];
                     progressBlock(receivedSize,expectedSize);
                 }
                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                    completedBlock(image, error, cacheType);
                    [weakSelf removeProgressIndicator];
                }
     ];
}


@end
