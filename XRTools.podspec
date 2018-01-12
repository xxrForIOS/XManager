Pod::Spec.new do |s|

  s.name = "XRTools"
  s.version = "0.0.2"
  s.summary = "日常开发常用工具"
  s.homepage = "https://github.com/xxrForIOS/XRTools"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Melo" => "xr_112@163.com" }
  s.platform = :ios, '9.0'
  s.source = { :git => "https://github.com/xxrForIOS/XRTools.git", :tag => "0.0.2" }
  s.requires_arc = true
  s.ios.deployment_target = "9.0"
  s.source_files = "**/*.{h,m}"
end
