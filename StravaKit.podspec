Pod::Spec.new do |s|
  s.name         = "StravaKit"
  s.version      = "1.3.0"
  s.license      = "MIT"
  s.summary      = "Swift Strava client using Moya"
  s.homepage     = "https://github.com/marcbaldwin/StravaKit"
  s.author       = { "marcbaldwin" => "marc.baldwin88@gmail.com" }
  s.source       = { :git => "https://github.com/marcbaldwin/StravaKit.git", :tag => s.version }
  s.source_files = "StravaKit/*.swift"
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.framework  = "Foundation"
    ss.dependency 'Moya/RxSwift', '~> 13' 
  end

end
