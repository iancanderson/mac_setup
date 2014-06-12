#!/usr/bin/env ruby

require 'logger'
require 'pathname'

PERSONAL_EMAIL = 'ian@iancanderson.com'
PERSONAL_SSH_KEY = 'id_rsa'
WORK_EMAIL = 'iancanderson@thoughtbot.com'
WORK_SSH_KEY = 'tb_rsa'

@logger = Logger.new(STDOUT)

def make_dir_unless_exists(path)
  Dir.mkdir(path) unless Dir.exists?(path)
end

def home_filepath(file)
  Pathname(File.join(Dir.home, file))
end

def generate_ssh_keys
  ssh_dir = home_filepath('.ssh')
  make_dir_unless_exists(ssh_dir)
  
  personal_ssh_key_path = ssh_dir.join(PERSONAL_SSH_KEY)
  if personal_ssh_key_path.exist?
    @logger.info("Personal SSH key already exists")
  else
    @logger.info("Generating personal ssh key")
    `ssh-keygen -t rsa -C #{PERSONAL_EMAIL} -f #{personal_ssh_key_path}`
  end
  
  work_ssh_key_path = ssh_dir.join(WORK_SSH_KEY)
  if work_ssh_key_path.exist?
    @logger.info("Work SSH key already exists")
  else
    @logger.info("Generating work ssh key")
    `ssh-keygen -t rsa -C #{WORK_EMAIL} -f #{work_ssh_key_path}`
  end
end

def setup_dotfiles
  code_path = File.join(Dir.home, "code")
  make_dir_unless_exists(code_path)
  Dir.chdir(code_path) do
    `git clone git://github.com/thoughtbot/dotfiles.git`
    `brew bundle dotfiles/Brewfile`
    `rcup -f -d dotfiles -x README.md -x LICENSE -x Brewfile`
  end
end

def setup_keyboard_mappings
  `osascript applescripts/map_caps_lock_to_control.scpt`
end

#`brew bundle`
setup_keyboard_mappings
generate_ssh_keys
setup_dotfiles

