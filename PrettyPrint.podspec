Pod::Spec.new do |s|
  s.name = "PrettyPrint"
  s.version = "0.0.1"
  s.summary = "Protocol which provides an interface for retrieving pretty string representations of objects"
  s.description = "Protocol adopters can retrieve a pretty string representation (description) of themselves rather than the default Swift object notation by adopting the PrettyPrintable protocol"
  s.homepage = "https://github.com/mtfourre/PrettyPrintable"
  s.license = { :type => "Unlicense", :file => "LICENSE" }
  s.author = { "Michael Fourre" => "mtfourre@gmail.com" }
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.source = { :git => 'https://github.com/mtfourre/PrettyPrint.git' }
  s.source_files = "*.swift"
end
