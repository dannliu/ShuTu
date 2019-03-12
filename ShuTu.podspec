Pod::Spec.new do |s|
  s.name         = "ShuTu"
  s.version      = "0.0.1"
  s.summary      = "A collection of utils for personal use"
  s.homepage     = "https://github.com/x4snowman/ShuTu"
  s.license      = "MIT"
  s.author       = { "x4snowman" => "liudanyun@gmail.com" }
  s.ios.deployment_target = "10.0"
  s.source       = { :git => "https://github.com/x4snowman/ShuTu.git", :branch => "master" }
  s.source_files = "Source/*.swift"
  s.swift_version = '4.2'
end
