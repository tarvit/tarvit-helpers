module TarvitHelpers

  class RecursiveLoader
    attr_reader :method

    def initialize(method=:require)
      raise "Method #{method} is invalid, must be :require or :load" unless [ :require, :load ].include?(method)
      @method = method
    end

    def load_modules(dir, priorities=[])
      load_ruby_files(dir)
      dirs = global_dirs(dir)
      (priorities.select{|p| dirs.include?(p)} + dirs ).each do |subdir|
        load_modules_in dir.join(subdir)
      end
    end

    def load_modules_in(dir)
      load_ruby_files(dir)
      valid_directories(dir).each do |subdir|
        load_modules_in dir.join(subdir)
      end
    end

    def self.load_modules(dir, priorities=[], method=:require)
      new(method).load_modules(dir, priorities)
    end

    private

    def global_dirs(dir)
      (valid_directories(dir)).uniq
    end

    def valid_directories(dir)
      Dir.open(dir).entries.select do |entry|
        !%w{ . .. }.include?(entry) && File.directory?(dir.join(entry))
      end
    end

    def load_ruby_files(dir)
      ruby_files(dir).each do |rb|
        send(method, dir.join(rb))
      end
    end

    def ruby_files(dir)
      Dir.open(dir).entries.select do |entry|
        entry.ends_with? '.rb'
      end
    end
  end
end
