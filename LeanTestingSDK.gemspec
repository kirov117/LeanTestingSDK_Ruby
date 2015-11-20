Gem::Specification.new do |s|
	s.name        = 'LeanTestingSDK'
	s.version     = '1.0.0'
	s.date        = '2015-11-20'
	s.platform    = Gem::Platform::RUBY
	s.summary     = 'Lean Testing Ruby Client Library'
	s.description = 'Lean Testing Ruby Client Library'
	s.authors     = ['Marcel Bontaș']
	s.email       = ['marcel.bontas@yandex.ru']
	s.files       = Dir.glob('LeanTestingSDK/**/*')
	s.homepage    = 'https://leantesting.com/'
	s.license     = 'Proprietary'
	s.require_path= 'LeanTestingSDK'

	s.add_dependency('curb', '~> 0.8')
end
