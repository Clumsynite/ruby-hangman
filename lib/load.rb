# frozen_string_literal: true

require 'yaml'

# Load game from save state
class Load
  def load_file
    puts 'No save information found' unless File.exist? 'save.yaml'
    YAML.safe_load(File.read('save.yaml'))
  end
end
