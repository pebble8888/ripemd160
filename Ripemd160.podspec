Pod::Spec.new do |spec|
  spec.name         = "ripemd160"
  spec.version      = "1.1.0"
  spec.summary      = "RIPEMD-160 written in pure swift"
  spec.homepage     = "https://github.com/pebble8888/ripemd160"
  spec.license      = "MIT"
  spec.author       = { "pebble8888" => "pebble8888@gmail.com" }
  spec.ios.deployment_target = "11.4"
  spec.osx.deployment_target = "10.12"
  spec.source       = { :git => "https://github.com/pebble8888/ripemd160.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources"
  spec.swift_version = "5.0"
end

