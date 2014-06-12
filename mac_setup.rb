#!/usr/bin/env ruby

require 'logger'
require 'pathname'

require './config_constants'
require './file_helpers'

@logger = Logger.new(STDOUT)

def generate_ssh_keys
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

  #TODO upload public keys to heroku and github
end

def setup_dotfiles
  Dir.chdir(thoughtbot_code_path) do
    unless thoughtbot_code_path.join('dotfiles').exist?
      `git clone git://github.com/thoughtbot/dotfiles.git`
      `brew bundle dotfiles/Brewfile`
      `rcup -f -v -d dotfiles -x README.md -x LICENSE -x Brewfile`
    end
  end

  Dir.chdir(personal_code_path) do
    unless personal_code_path.join('dotfiles').exist?
      `git clone git://github.com/iancanderson/dotfiles.git`
      `rcup -f -v -d dotfiles -x README.md -x LICENSE -x Brewfile`
    end
  end
end

def setup_keyboard_mappings
  `osascript applescripts/map_caps_lock_to_control.scpt`
end

#`brew bundle`
setup_keyboard_mappings
generate_ssh_keys
setup_dotfiles

