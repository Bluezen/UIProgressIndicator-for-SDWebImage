UIProgressIndicator-for-SDWebImage
==================================

The easiest way to add a DACCircularProgress to your [SDWebImage](https://github.com/rs/SDWebImage) view

BASED ON ORIGINAL WORK => [UIActivityIndicator-for-SDWebImage](https://github.com/JJSaccolo/UIActivityIndicator-for-SDWebImage) 

Installation
-----------

Copy the class (.h and .m) into your application. 


Requirement
-----------

[DACCircularProgress](https://github.com/danielamitay/DACircularProgress)

Usage
-----------

You can use all the standard SDWebImage methods... adding the last parameters

    usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor

So all the methods available are:
 
    - (void)setImageWithURL:(NSURL *)url usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url completed:(SDWebImageCompletedBlock)completedBlock usingActivityIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;
	- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletedBlock)completedBlock usingProgressIndicatorWithProgressTintColor:(UIColor *)progressTintColor andTrackTintColor:(UIColor *)trackTintColor;


**Remove the activity indicator**

Sometimes it's useful to remove the activity indicator (for example when you call `cancelCurrentImageLoad` on the UIImageView). 
From now on the method `removeActivityIndicator` is public: fell free to use it! 


License
-------

UIProgressIndicator for SDWebImage is released under the MIT License. Please see the LICENSE file for details.