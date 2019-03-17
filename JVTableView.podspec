Pod::Spec.new do |s|
  s.name             = 'JVTableView'
  s.version          = '1.6.8'
  s.summary          = 'A short description of JVTableView.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Jasperav/JVTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jasperav' => 'Jasperav@hotmail.com' }
  s.source           = { :git => 'https://github.com/Jasperav/JVTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'JVTableView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JVTableView' => ['JVTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'JVView'
s.dependency 'JVConstraintEdges'
s.dependency 'JVTappable'
s.dependency 'JVFormChangeWatcher'
s.dependency 'JVLoadableImage'
s.dependency 'JVNoParameterInitializable'
s.dependency 'JVLoadableImage'
s.dependency 'JVTextField'
s.dependency 'JVURLOpener'
s.dependency 'JVUIButtonExtensions'
s.dependency 'JVTableViewCellLayoutCreator'
end
