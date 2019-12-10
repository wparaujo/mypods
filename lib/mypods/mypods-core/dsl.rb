module MyPod
    class MyPodFile
        class DSL
            require 'open3'

            # attr_accessor 

            def repo(name = nil, **requirements)
                stdout_str, status = Open3.capture2("git clone #{requirements[:source]}")
            end

            # abstract to installer class
            def mypods
                yield if block_given?
            end

            def self.load(filename)
                dsl = new
                dsl.instance_eval(File.read(filename))
                dsl
            end
        end
    end
end