module TarvitHelpers

  class RecursiveLoader
    attr_reader :method

    def initialize(method=:require)
      raise "Method #{method} is invalid, must be :require or :load" unless [ :require, :load ].include?(method)
      @method = method
    end

    def load_modules(dir, priorities=[])
      load_ruby_files(dir, priorities)
      prioritize_dirs(global_dirs(dir), priorities).each do |subdir|
        load_modules dir.join(subdir), priorities
      end
    end

    def load_modules_in(dir)
      load_ruby_files(dir)
      valid_directories(dir).each do |subdir|
        load_modules_in dir.join(subdir)
      end
    end

    module Context
      def load_modules(dir, priorities=[], method=:require)
        RecursiveLoader.new(method).load_modules(dir, priorities)
      end
    end

    extend Context

    private

    def global_dirs(dir)
      (valid_directories(dir)).uniq.sort
    end

    def valid_directories(dir)
      Dir.open(dir).entries.select do |entry|
        !%w{ . .. }.include?(entry) && File.directory?(dir.join(entry))
      end
    end

    def load_ruby_files(dir, priorities=[])
      prioritize_files(ruby_files(dir), priorities).each do |rb|
        send(method, dir.join(rb))
      end
    end

    RB_EXT = '.rb'

    def ruby_files(dir)
      Dir.open(dir).entries.select do |entry|
        entry.ends_with? RB_EXT
      end.sort
    end

    def prioritize_dirs(list, priorities)
      (priorities.select{|p| list.include?(p) } + list ).uniq
    end

    def prioritize_files(files, priorities)
      files_priorities = priorities.map do |p|
        p.include?(RB_EXT) ? p : (p+RB_EXT)
      end
      prioritize_dirs(files, files_priorities)
    end
  end
end
