Pod::Spec.new do |s|
  s.name          = 'StravaKit'
  s.version       = '2.1.0'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.summary       = 'Swift Strava client using Moya'
  s.homepage      = 'https://github.com/marcbaldwin/StravaKit'
  s.author        = { 'marcbaldwin' => 'marc.baldwin88@gmail.com' }
  s.source        = { :git => "https://github.com/marcbaldwin/StravaKit.git", :tag => s.version }
  s.source_files  = 'StravaKit/*.swift'
  s.platform      = :ios, '8.0'
  s.swift_version = '5'
  s.framework     = 'Foundation'
  s.dependency      'Moya/RxSwift', '~> 13'
end
