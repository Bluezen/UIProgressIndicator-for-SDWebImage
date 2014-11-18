//
//  UIImageView+UIActivityIndicatorForSDWebImage.h
//  UIActivityIndicator for SDWebImage
//
//  Created by Adrien Long.
//  Copyright (c) 2014 Adrien Long. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

#import <DACircularProgress/DACircularProgressView.h>

@interface UIImageView (DACircularProgressIndicatorForSDWebImage)

@property (nonatomic, strong) DACircularProgressView *progressView;

- (void)setImageWithURL:(NSURL *)url usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock usingActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;

/// The image is NOT SET for you on completion of the image download, you can perform checks in completedBlock before asigning it to the imageView
-(void)downloadImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;

- (void)removeProgressIndicator;

@end
