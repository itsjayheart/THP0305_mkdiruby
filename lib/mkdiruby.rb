=begin

mkdiruby.rb should do on its own 

everything one needs to set up

when working on a Ruby project

in a Github repository

=end


#defining a method
# => which provides info
	# 	=> if the user request misses input
	# 	=> or if it contains too many arguments
def check_if_user_gave_input
  abort("mkdiruby: missing input") if ARGV.empty?
  abort("mkdiruby: input contains more than one argument") if ARGV.count > 1
end

#defining a method 
# => which puts the user's argument into a string variable
def get_folder_name
  return folder_name = ARGV.join
end

#defining a method
# => which creates a folder
# => which names it after the get_folder_name method
def create_folder(name)
  Dir.mkdir("#{name}")
end

#defining a method
# => which creates a Gemfile
# => which writes in it the gems needed for the project
# => and eventually installs them with bundler
def gemfile_creation
	system('touch Gemfile')
	file = File.open('Gemfile', 'w')
	file.puts("source 'https://rubygems.org'")
	file.puts("ruby '2.5.1'")
	file.puts("gem 'rspec'")
	file.puts("gem 'dotenv'")
	file.puts("gem 'pry'")
	file.puts("gem 'rubocop', '~> 0.57.2'")
	file.close
	system('bundle install')
end


#defining a method
# => which executes git init
def git_init
	system('git init')
end


#defining a method
# => which creates a .env file
# => which creates a .gitignorefile
# => which informs the .gitignore file with .env 
def dotenv_gitignore
	system('touch .env')
	system('touch .gitignore')
	file = File.open('.gitignore', 'w')
	file.puts('.env')
	file.close
end

#defining a method
# => which creates a lib folder
def lib
	Dir.mkdir('lib')
end


#defining a method
# => which initializes the rspec gem
def rspec
	system('rspec --init')
end


#defining a method
# => which creates a Readme.md file
# => and fills it with love
def readme
	system('touch README.md')
	file = File.open('README.md', 'w')
	file.puts('this project is written in the ruby computer science language')
	file.puts('more info on https://ruby-doc.org')
	file.puts('')
	file.puts('r e g a r d s')
	file.puts('')
	file.puts('j')
	file.close
end


#defining a method
# => which creates the main ruby file
# => which initializes it with needed gems
def create_main_dot_rb(name)
	system("touch #{name}.rb")
	file = File.open("#{name}.rb", 'w')
	file.puts("require 'pry'")
	file.puts("require 'dotenv'")
	file.puts('')
	file.puts("Dotenv.load('.env')")
	file.close
end

#defining a method
# => which creates a ruby file template
# => which initializes it with needed gems
def create_template_dot_rb
	system('touch template.rb')
	file = File.open('template.rb', 'w')
	file.puts("require 'pry'")
	file.puts("require 'dotenv'")
	file.puts('')
	file.puts("Dotenv.load('.env')")
	file.close
end

#defining a method
# => which creates the main ruby file's spec file
# => which connects it to the the main ruby file
# => which provides a template for Test-Driven Development
def create_main_spec_dot_rb(name)
	system("touch #{name}_spec.rb")
	file = File.open("#{name}_spec.rb", 'w')
	file.puts("require_relative '../lib/#{name}'")
	file.puts('')
	file.puts('')
	file.puts("describe 'the /name/ method' do")
	file.puts("	it 'should /action/' do")
	file.puts("		expect(/name/(/argument/)).to eq(/result/)")
	file.puts("	end")
	file.puts("end")
	file.close
end

#defining a method
# => which creates a test ruby file template
# => which connects it to a ruby file template
# => which provides a template for Test-Driven-Development
def create_template_spec_dot_rb
	system('touch template_spec.rb')
	file = File.open('template_spec.rb', 'w')
	file.puts("require_relative '../lib/template'")
	file.puts('')
	file.puts('')
	file.puts("describe 'the /name/ method' do")
	file.puts("	it 'should /action/' do")
	file.puts("		expect(/name/(/argument/)).to eq(/result/)")
	file.puts("	end")
	file.puts("end")
	file.close
end


#defining a perform method
def perform
	check_if_user_gave_input
	create_folder(get_folder_name)
	
	Dir.chdir("#{get_folder_name}")
	
	gemfile_creation
	git_init
	dotenv_gitignore
	lib
	rspec
	readme

	print 'enter the title of your main ruby file : '
	main_dot_rb = STDIN.gets.chomp
	puts ''

	Dir.chdir('lib') do
		create_main_dot_rb(main_dot_rb)
		create_template_dot_rb
	end

	Dir.chdir('spec') do
		create_main_spec_dot_rb(main_dot_rb)
		create_template_spec_dot_rb
		system("subl #{main_dot_rb}_spec.rb")	
	end
end

#executing the perform method
perform


