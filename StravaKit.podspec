Pod::Spec.new do |s|
  s.name          = 'StravaKit'
  s.version       = '4.4.0'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.summary       = 'RxSwift Strava client'
  s.homepage      = 'https://github.com/marcbaldwin/StravaKit'
  s.author        = { 'marcbaldwin' => 'marc.baldwin88@gmail.com' }
  s.source        = { :git => "https://github.com/marcbaldwin/StravaKit.git", :tag => s.version }
  s.source_files  = 'Sources/*.swift'
  s.ios.deployment_target = '12.0'
  s.framework     = 'Foundation'
  s.dependency      'Alamofire', '~> 5'
  s.dependency      'RxSwift', '~> 6'
end
