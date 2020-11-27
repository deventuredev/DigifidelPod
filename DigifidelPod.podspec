#
# Be sure to run `pod lib lint DigifidelPod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DigifidelPod'
  s.version          = '2.6.4'
  s.summary          = 'The pod of Digifidel 2.6.4'

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
  s.author           = { 'deventuredev@gmail.com' => 'razvan.tamazlicariu@deventure.co' }
  s.source           = { :git => 'https://github.com/deventuredev/DigifidelPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'
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
#  s.frameworks = 'GoogleMaps'
  s.dependency 'GoogleMaps'
  s.dependency 'Google-Maps-iOS-Utils'
  s.dependency 'SwiftSignalRClient'

  # s.dependency 'AFNetworking', '~> 2.3'
  s.vendored_frameworks = 'Loooot.framework'
end
