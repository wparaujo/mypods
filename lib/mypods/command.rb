require 'claide'

module MyPod
    class Command < CLAide::Command
        require 'mypods/command/init'
        require 'mypods/command/install'

        self.command = 'mypods'
        self.version = '1.0.0'
        self.description = 'Local Development Pods Manager.'
        
        def self.run(argv)
            super(argv)
        end
    end
end
