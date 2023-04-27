Pod::Spec.new do |s|
  s.name             = 'LBAppConfiguration'
  s.version          = '1.2.0'
  s.summary          = '项目登录模块组件化以及需要集成的第三方库快速配置。'
  s.description      = '项目登录模块组件化，免去了一些重复且复杂设置，支持任意第三方推送，支持游客模式，只需要设置LoginController类名以及HomeController类名，内含需要集成的第三方库快速配置，省去了其他一些复杂的代码，一键设置，更快更方便。'
  s.homepage         = 'https://github.com/A1129434577/LBAppConfiguration'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'A1129434577' => '1129434577@qq.com' }
  s.source           = { :git => 'https://github.com/A1129434577/LBAppConfiguration.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.static_framework = true
  #s.xcconfig = { 'VALID_ARCHS' => 'arm64 x86_64', }
  s.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }
  #s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' } 
  #s.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.subspec 'LBAppConfiguration' do |ss|
    ss.source_files = "LBAppConfiguration/LBAppConfiguration/**/*.{h,m}"
  end
  
  s.subspec 'Notifications' do |ss|
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.source_files = "LBAppConfiguration/Notifications/**/*.{h,m}"
  end
  
  s.subspec 'Login' do |ss|
    ss.dependency 'LBUserInfo'
    ss.dependency 'LBCommonComponents'
    ss.dependency 'LBAppConfiguration/Notifications'
    ss.source_files = "LBAppConfiguration/Login/**/*.{h,m}"
  end
  
  s.subspec 'JPush' do |ss|
    ss.dependency 'JPush'
    ss.dependency 'LBCommonComponents'
    ss.dependency 'LBAppConfiguration/Notifications'
    ss.source_files = "LBAppConfiguration/JPush/**/*.{h,m}"
  end

  s.subspec 'SDWebImage' do |ss|
    ss.dependency 'SDWebImageWebPCoder'
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.source_files = "LBAppConfiguration/SDWebImage/**/*.{h,m}"
  end
  
  s.subspec 'IQKeyboard' do |ss|
    ss.dependency 'IQKeyboardManager'
    ss.dependency 'LBAppConfiguration/LBAppConfiguration'
    ss.source_files = "LBAppConfiguration/IQKeyboard/**/*.{h,m}"
  end
  
  
end
#--use-libraries
