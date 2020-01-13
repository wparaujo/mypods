Gem::Specification.new do |s|
    s.name        = 'mypods'
    s.version     = '0.1.0'
    s.date        = '2019-12-08'
    s.summary     = "Local Development Pods Manager"
    s.description = "Mypods manages the synchronization of various developing local pods with " \
                    "their repositories."
    s.authors     = ["Wesley Araujo"]
    s.email       = 'wparaujo7@gmail.com'
    s.files       = Dir["lib/**/*.rb"] + %w{ bin/mypods README.md }
    s.homepage    = 'https://github.com/wparaujo/mypods'
    s.license     = 'MIT'
    s.executables = %w{ mypods }
    s.require_paths = %w{ lib } 
    s.bindir        = 'bin'

    s.add_runtime_dependency 'claide', '>= 1.0.3', '< 2.0'
    s.add_runtime_dependency 'bundler', '~> 2.0'
    s.add_runtime_dependency 'rake', '~> 13.0'
  end
