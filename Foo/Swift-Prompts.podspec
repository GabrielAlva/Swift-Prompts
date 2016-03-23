Pod::Spec.new do |s|
	s.name					= 'Swift-Prompts'
	s.version				= '1.0.0'
	s.summary				= 'A Swift library to design custom prompts with a great scope of options to choose from.'
	s.homepage				= 'https://github.com/GabrielAlva/Swift-Prompts'
	s.license				= { :type => 'MIT', :file => 'LICENSE.md' }
	s.author				= { 'Gabriel Alvarado' => 'gabrielle.alva@gmail.com' }
	s.source				= { :git => 'https://github.com/GabrielAlva/Swift-Prompts.git', :tag => "v#{s.version}" }
	s.platform				= :ios, '8.0'
	s.requires_arc			= true
	s.source_files			= 'Swift-Prompts/*.{swift}'
end