# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Popt' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks

  use_frameworks!
    pod 'SVProgressHUD',  '2.0.3'
    pod 'Alamofire',      '3.3.0'
    pod 'SwiftyJSON',     '2.3.2'
    pod 'AlamofireImage', '2.4.0'

  def testing_pods
    pod 'Quick',          '0.9.2'
    pod 'Nimble',         '4.0.1'
  end

  target 'PoptTests' do
    testing_pods
#    inherit! :search_paths
  end

  target 'PoptUITests' do
    testing_pods
#    inherit! :search_paths
  end

end
