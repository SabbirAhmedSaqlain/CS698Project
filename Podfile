# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

def all_pods

pod 'CryptoSwift', '~> 1.8.1'
 
end
 

target 'To-Do' do
  all_pods
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
end
