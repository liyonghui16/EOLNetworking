#
# Be sure to run `pod lib lint ELNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EOLNetworking'
  s.version          = '0.0.10'
  s.summary          = 'A EOLNetworking.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Cache/Validator/Intercept/ Networking
                       DESC

  s.homepage         = 'https://github.com/liyonghui16/EOLNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liyonghui16' => '18335103323@163.com' }
  s.source           = { :git => 'https://github.com/liyonghui16/EOLNetworking.git', :tag => "0.0.10" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios, "7.0"
  s.ios.deployment_target = '7.0'

  s.source_files = 'ELNetworking/Classes/*.h', 'ELNetworking/Classes/*/*.{h,m}'
  
  # s.resource_bundles = {
  #   'ELNetworking' => ['ELNetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
end
