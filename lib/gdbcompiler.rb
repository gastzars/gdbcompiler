require 'gdbcompiler/version'
require 'yaml'

require_relative 'gdbcompiler/item'
require_relative 'gdbcompiler/script'
require_relative 'gdbcompiler/effect'
require_relative 'gdbcompiler/condition'
require_relative 'gdbcompiler/parser'
require_relative 'gdbcompiler/gdb_error'

# Gdbcompiler self lib for export rAthena database to text
module Gdbcompiler
  TRANSLATE = YAML.load_file(File.dirname(__FILE__) + '/data/translate.yml').freeze
end
