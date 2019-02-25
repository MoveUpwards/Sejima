Pod::Spec.new do |s|
  s.name = 'MUCore'
  s.version = '$BITRISE_GIT_TAG'
  s.license = 'MIT'
  s.summary = 'MUCore is a framework that expose reusable core component part of MUKit.'
  s.description  = <<-DESC
    As we always use the same or a really close object, we made severals components that we want to share with you.
                   DESC
  s.homepage = 'https://github.com/MoveUpwards/MUKit.git'
  s.authors = { 'Damien NOËL DUBUISSON' => 'damien@slide-r.com', 'Loïc GRIFFIÉ' => 'loic@slide-r.com' }
  s.source = { :git => 'git@github.com:MoveUpwards/MUKit.git', :tag => '0.1.0' }
  s.swift_version   = '4.2'

  s.ios.deployment_target = '11.0'

  s.source_files = 'MUCore/Source/**/*.{xib,swift}'
end