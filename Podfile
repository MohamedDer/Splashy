# Uncomment the next line to define a global platform for your project
# platform :ios, '17.0'

target 'Splashy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Splashy
  pod 'Kingfisher', '~> 7.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ''
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
  end
end