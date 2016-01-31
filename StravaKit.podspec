Pod::Spec.new do |s|
  s.name         = "StravaKit"
  s.version      = "0.0.1"
  s.license      = "MIT"
  s.summary      = "Swift adapter to the Strava v3 API"
  s.homepage     = "https://github.com/marcbaldwin/StravaKit"
  s.author       = { "Marc Baldwin" => "marc.baldwin88@gmail.com" }
  s.source       = { :git => "https://github.com/marcbaldwin/StravaKit.git", :tag => s.version }
  s.source_files = "StravaKit/*.swift"
  s.platform     = :ios, '8.0'
  s.frameworks   = "Foundation", "UIKit"
  s.requires_arc = true
  s.dependency "Alamofire"
  s.dependency "SwiftyJSON"
  s.dependency "URITemplate"
end
