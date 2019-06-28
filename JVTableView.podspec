Pod::Spec.new do |s|
  s.name             = 'JVTableView'
  s.version          = '1.8.4'
  s.summary          = 'A short description of JVTableView.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Jasperav/JVTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jasperav' => 'Jasperav@hotmail.com' }
  s.source           = { :git => 'https://github.com/Jasperav/JVTableView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'JVTableView/Classes/**/*'

s.dependency 'JVView'
s.dependency 'JVConstraintEdges'
s.dependency 'JVFormChangeWatcher'
s.dependency 'JVLoadableImage'
s.dependency 'JVNoParameterInitializable'
s.dependency 'JVLoadableImage'
s.dependency 'JVURLOpener'
s.dependency 'JVUIButton'
s.dependency 'JVDebugProcessorMacros'
s.dependency 'JVTableViewCellLayoutCreator'
s.dependency 'JVImagePresenter'
s.dependency 'JVChangeableValue'
end
