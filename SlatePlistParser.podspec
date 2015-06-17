Pod::Spec.new do |s|
  s.name             = "SlatePlistParser"
  s.version          = "0.1.0"
  s.summary          = "A SlatePlistParser."
  s.description      = <<-DESC
			A SlatePlistParser. Create subviews and apply view properties from plist. 
                       DESC
  s.homepage         = "https://github.com/mmslate/SlatePlistParser"
  s.license          = 'MIT'
  s.author           = { "linyize" => "linyize@gmail.com" }
  s.source           = { :git => "https://github.com/mmslate/SlatePlistParser.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = '*.{h,m}'
end
