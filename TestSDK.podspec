Pod::Spec.new do |s|

  s.name         = "TestSDK"
  s.version      = "1.0.0"
  s.summary      = "This is such a TestSDK framework, Kwanso."
  s.description  = "This is some super Test framework that was made by Kwanso."
  s.license      = "MIT"
  s.author       = { "Safyan Jamil" => "safyan.jamil@kwanso.com" }
  s.platform     = :ios, "11.0"
  s.homepage      = "https://github.com/kwanso-safyan/TestSDK"
  s.source       = { :git => "https://github.com/kwanso-safyan/TestSDK.git", :tag => "1.0.0" }
  s.source_files  = "TestSDK/**/*.{h,m,swift,xcdatamodeld}"

  #s.framework  = "Alamofire"
  s.frameworks = "Alamofire", "CommonCryptoModule"



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Alamofire", "4.8.0"
  s.dependency "CommonCryptoModule", "1.0.2"
  s.dependency "IQKeyboardManagerSwift", "6.2.0"
  s.dependency "MBProgressHUD", "1.1.0"
  s.dependency "ReachabilitySwift", "4.3.0"
  s.dependency "SwiftyJSON", "4.2.0"

end
