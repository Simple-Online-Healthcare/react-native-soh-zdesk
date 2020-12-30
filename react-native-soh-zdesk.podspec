require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-soh-zdesk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-soh-zdesk
                   DESC
  s.homepage     = "https://github.com/simple-online-pharmacy/react-native-soh-zdesk"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Your Name" => "yourname@email.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/simple-online-pharmacy/react-native-soh-zdesk.git", :tag => "#{s.version}" }
  s.source_files = 'ios/*.{h,m}'
  s.static_framework = true

  s.platform       = :ios, '10.0'

  s.requires_arc = true

  s.dependency "React"
  s.dependency "ZendeskSupportSDK"
  s.dependency "ZendeskChatSDK"
  s.dependency "ZendeskChatProvidersSDK"
  # ...
  # s.dependency "..."
end

