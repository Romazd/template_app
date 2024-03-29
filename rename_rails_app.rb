# rename_rails_app.rb
require 'fileutils'

APP_NAME = ARGV[0]
raise ArgumentError, 'You must provide a new application name' if APP_NAME.nil? || APP_NAME.empty?

def gsub_file(file, old_str, new_str)
  return unless File.exist?(file)
  
  text = File.read(file)
  new_contents = text.gsub(/#{old_str}/, new_str)
  File.open(file, "w") {|file| file.puts new_contents }
end

# Files and folders to rename
files_to_rename = [
  'config/application.rb',
  'config/environment.rb',
  'config/environments/development.rb',
  'config/environments/production.rb',
  'config/environments/test.rb',
  'config/routes.rb',
]

files_to_rename.each do |file|
  gsub_file(file, /TemplateApp/, APP_NAME)
end

gsub_file('config/application.rb', /module TemplateApp/, "module #{APP_NAME.split('_').collect(&:capitalize).join}")

puts "Application has been renamed to #{APP_NAME}"
