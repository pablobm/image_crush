Gem::Specification.new do |s|
  s.name = "image_crush"
  s.version = "1.0"
  s.summary = "Reduce the size of PNG and JPEG files"
  s.email = "pablobm@gmail.com"
  s.homepage = "http://github.com/pablobm/image_crush"
  s.description = "Runs the pngcrush and jpegtran tools to reduce the size of image files"
  s.authors = ["Pablo Brasero"]

  s.files = [
    "LICENSE",
    "Rakefile"
  ] + Dir['lib/**/*'] + Dir['tasks/**/*']
    
  s.test_files = Dir['spec/**']
end

