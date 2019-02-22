Pod::Spec.new do |spec|

  spec.name         = "MUKit"
  spec.version      = "0.1.0"
  spec.summary      = "MUKit is a UI framework that expose reusable components."
  spec.description  = <<-DESC
    As we always use the same or a really close object, with a one time definition
    with UIAppearence, we made severals components that we want to share with you.
                   DESC
  spec.homepage     = "https://github.com/MUKit/MUKit"
  spec.license      = "MIT"
  spec.authors      = { "Damien NOËL DUBUISSON" => "damien@slide-r.com", "Loïc GRIFFIÉ" => "loic@slide-r.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/MUKit/MUKit.git", :tag => "#{spec.version}" }
  spec.source_files = "**/*" # ?

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

end
