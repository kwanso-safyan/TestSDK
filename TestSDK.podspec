Pod::Spec.new do |s|

  s.name         = "TestSDK"
  s.version      = "1.0.0"
  s.summary      = "This is such a TestSDK framework, Kwanso."
  s.description  = "This is some super Test framework that was made by Kwanso."
  s.license      = "MIT"
  s.author       = { "Safyan Jamil" => "safyan.jamil@kwanso.com" }
  s.platform     = :ios, "9.0"
#s.source       = { :git => "http://EXAMPLE/TestSDK.git", :tag => "1.0.0" }
  s.source_files  = "Test Framwork"

  s.framework  = "Alamofire"
  # s.frameworks = "SomeFramework", "AnotherFramework"



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "Alamofire", "~> 1.4"

end
