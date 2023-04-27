platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0';
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64";
    end
  end
end

target “LBAppConfigurationExample” do

pod 'JPush'
pod 'LBUserInfo'
pod 'IQKeyboardManager'
pod 'LBCommonComponents'
pod 'SDWebImageWebPCoder'

end

