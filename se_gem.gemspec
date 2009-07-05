spec = Gem::Specification.new do |s|
  s.name                  = 'se_gem'
  s.version               = '0.0.1'
  s.summary               = 'A collection of useful scripts.'
  s.required_ruby_version = '>= 1.8.6'

  s.author                = 'Scott Steadman (and others)'
  s.email                 = 'gems@stdmn.com'
  s.homepage              = 'http://github.com/ss/se_gem'

  s.has_rdoc              = true
  s.files                 = ['README']
  s.files                 << Dir['lib/**/*']
  s.test_files            = Dir['test/**/*_test.rb']
end
