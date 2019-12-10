module MyPod
    class Command
        class Install < Command
            require 'mypods/mypods-core/dsl'

            self.summary = "Install all pods or updated that."
            self.description = <<-DES 
                If pods path is empty, all pods is installed. Case pods is installed,                         verify if update is needed."
            DES
            
            def initialize(argv)
                super
            end
            
            def run
                current_dir = Pathname.new(Dir.pwd)
                dsl = MyPod::MyPodFile::DSL.load(current_dir + 'Mypodfile')
                dsl.instance_variables
            end
        end
    end
end