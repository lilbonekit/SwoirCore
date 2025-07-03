Pod::Spec.new do |spec|

  spec.name         = "SwoirCore"
  spec.version      = "1.0.0"
  spec.summary      = "SwoirCore for swift"

  spec.homepage     = "https://github.com/lilbonekit/SwoirCore"
  spec.license      = "MIT"
  spec.author       = { "lilbonekit" => "mykytasydorenko0@gmail.com" }
  spec.platform = :ios
  spec.ios.deployment_target = "14.0"

  spec.source          = {
    :git    => 'https://github.com/lilbonekit/SwoirCore.git',
    :commit => '6c9f8f4d0fabda568244e2cd8de7b1242c5edd76'
  }

  spec.source_files  = "Sources/**/*.{swift}"

  spec.swift_version = "5.0"

  spec.dependency "OpenSSL-Universal", '1.1.1900'
  # spec.xcconfig          = { 'OTHER_LDFLAGS' => '-weak_framework CryptoKit -weak_framework CoreNFC -weak_framework CryptoTokenKit' }

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end