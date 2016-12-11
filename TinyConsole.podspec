Pod::Spec.new do |s|
  s.name             = 'TinyConsole'
  s.version          = '1.3.1'
  s.summary          = 'A tiny log console to display information while using your iOS app. Written in Swift 3.'

  s.description      = <<-DESC
Shows a console view on the lower bottom of your screen to display debug information of your running app.
                       DESC

  s.homepage         = 'https://github.com/Cosmo/TinyConsole'
  s.screenshots      = 'https://raw.githubusercontent.com/Cosmo/TinyConsole/master/TinyConsole-Demo.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Devran Ünal' => 'maccosmo@gmail.com' }
  s.source           = { :git => 'https://github.com/Cosmo/TinyConsole.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/maccosmo'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TinyConsole/**/*'
end
