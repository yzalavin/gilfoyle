require 'sinatra'
require 'yaml'

CONFIG = YAML.load_file("config/application.yml")

require_relative 'models/message/base'
require_relative 'models/message/creator'
require_relative 'models/message/validator'
require_relative 'models/message/encryptor'

require_relative 'controller'
