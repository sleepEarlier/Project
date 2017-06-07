

Pod::Spec.new do |s|

  s.name         = "KMCategory"
  s.version      = "0.1.1"
  s.summary      = "Some categories methods"

  s.description  = <<-DESC
                  This provide some frequently used categories methods
                   DESC

  s.homepage     = "https://github.com/sleepEarlier/Project"

  s.license      = { :type => "MIT", :file => "LICENSE"}

  s.author       = { "sleepEarlier" => "jky130@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/sleepEarlier/Project.git", :tag => s.version }

  s.source_files  = "Project/Classes/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Project/Classes/KMCategories.h","Project/Class/**/*.h"

  s.ios.deployment_target = "7.0"

  s.frameworks = "UIKit", "Foundation"

  s.requires_arc = true

end
