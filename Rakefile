require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README ].include? file
    new_path = file.gsub('__','/').gsub('@@','.')
    source = File.join(Dir.pwd, file)
    destination = File.join(ENV['HOME'], new_path)
    if File.exist?(destination)
      if File.identical? destination, source
        puts "identical #{source}"
      elsif replace_all
        replace_file(source,destination)
      else
        print "overwrite #{source}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(source,destination)
        when 'y'
          replace_file(source,destination)
        when 'q'
          exit
        else
          puts "skipping #{source}"
        end
      end
    else
      link_file(source,destination)
    end
  end

  unless File.exists?(File.join(ENV['HOME'],'.vim/bundle/vundle'))
    puts "to install Vundle, issue :"
    puts "git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle"
  end
end

def replace_file(source,destination)
  system %Q{rm -rf "#{destination}"}
  link_file(source,destination)
end

def link_file(source,destination)
    puts "linking #{source}"
    system %Q{ln -fs "#{source}" "#{destination}"}
end
