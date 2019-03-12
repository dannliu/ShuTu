Pod::Spec.new do |s|
  s.name         = "STKit"
  s.version      = "0.0.1"
  s.summary      = "A collection of utils for personal use"
  s.homepage     = "https://github.com/x4snowman/STKit"
  s.license      = "MIT"
  s.author       = { "x4snowman" => "liudanyun@gmail.com" }
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/x4snowman/STKit.git", :branch => "master" }
  s.source_files = "Source/*.swift"
  s.swift_version = '4.2'
end
