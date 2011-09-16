require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'
ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

# Simple prompt
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Auto indent code
IRB.conf[:AUTO_INDENT]  = true

# This is only done when using the Rails console
if rails_env = ENV['RAILS_ENV']

  # Setup a Rails specific prompt
  rails_root = File.basename(Dir.pwd)
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{rails_root}> ",
    :PROMPT_S => "#{rails_root}* ",
    :PROMPT_C => "#{rails_root}? ",
    :RETURN   => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # This is only done when the irb session and
  # rails are fully loaded (from Mike Clark)
  IRB.conf[:IRB_RC] = Proc.new do
   
    # Log ActiveRecord calls to standard out
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    # Setup a [] alias for find so you can say:
    # Post[1] instead of Post.find(1)
    ActiveRecord::Base.instance_eval { alias :[] :find }
   
    # Require and mixin the SuppressValidations gem
    # (gem install polly-suppress_validations)
    #require "suppress_validations"
    #include SuppressValidations
  end
end

begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

