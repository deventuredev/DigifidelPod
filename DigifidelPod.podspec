#
# Be sure to run `pod lib lint DigifidelPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DigifidelPod'
  s.version          = '2.8.5.2'
  s.summary          = 'The pod of Digifidel 2.8.5.2'

#   This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  This is the official Digifidel pod. This version is for testing.
                       DESC

  s.homepage         = 'https://github.com/deventuredev/DigifidelPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'deventuredev@gmail.com' => 'mihai.ionascut@deventure.co' }
  s.source           = { :git => 'https://github.com/deventuredev/DigifidelPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'DigifidelPod/Classes/**'
  s.resource_bundles = {
      'DigifidelBundle' => ['DigifidelPod/Classes/*.{png,storyboard,xib}']
  }
  # s.resource_bundles = {
  #   'LooootPod' => ['DigifidelPod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.static_framework = true
  s.dependency 'GoogleMaps', '< 3.10'
  s.dependency 'Google-Maps-iOS-Utils', '~> 3.8.0'
  s.dependency 'SwiftSignalRClient', '~> 0.8.0'
  s.dependency 'SwiftProtobuf', '~> 1.0'

  s.vendored_frameworks = 'Loooot.xcframework'
end
