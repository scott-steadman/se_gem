require 'yaml'

#
# Read a file, run it through ERB, then YAML::load.
#
# The caller is expected to have loaded ERB.
#
#  +filename+ - name of file
#  +args+     - arguments for ERB.new call
#
def YAML.load_erb_file(filename, *args)
  YAML::load(ERB.new(IO.read(filename), *args).result)
end
