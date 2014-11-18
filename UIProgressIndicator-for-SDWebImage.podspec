#
# Be sure to run `pod lib lint UIProgressIndicator-for-SDWebImage.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UIProgressIndicator-for-SDWebImage"
  s.version          = "0.1.0"
  s.summary          = "The easiest way to add a DACCircularProgress to your SDWebImage"
  s.homepage         = "https://github.com/Bluezen/UIProgressIndicator-for-SDWebImage"
  s.license          = 'MIT'
  s.author           = { "Adrien Long" => "adrien@long.pm" }
  s.source           = { :git => "https://github.com/Bluezen/UIProgressIndicator-for-SDWebImage.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'UIProgressIndicator-for-SDWebImage'
  s.resource_bundles = {
    'UIProgressIndicator-for-SDWebImage' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIImage'
  s.dependency 'DACircularProgress', '~> 2.0'
  s.dependency 'SDWebImage', '~> 3.7.1'
end
