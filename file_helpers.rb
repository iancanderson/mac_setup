require './config_constants'

def make_dir_unless_exists(path)
  Dir.mkdir(path) unless Dir.exists?(path)
end

def home_filepath(file)
  Pathname(File.join(Dir.home, file))
end

def home_subdir(dir)
  path = home_filepath(dir)
  make_dir_unless_exists(path)
  path
end

def ssh_dir
  home_subdir('.ssh')
end

def code_dir
  home_subdir('code')
end

def code_subdir(subdir)
  path = code_dir.join(subdir)
  make_dir_unless_exists(path)
  path
end

def personal_code_path
  code_subdir(GITHUB_USERNAME)
end

def thoughtbot_code_path
  code_subdir('thoughtbot')
end
