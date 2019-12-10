module MyPod
    class MyPodFile
        class DSL
            require 'open3'

            # attr_accessor 

            def repo(name = nil, **requirements)
                # stdout_str, stdout_error, status = Open3.capture3("git clone #{requirements[:source]}")
                root_dir = Pathname.pwd
                
                if Dir.exists?(name)
                    Dir.chdir("#{name}")
                    stdout_str, status = Open3.capture2("git pull origin #{requirements[:branch]}")
                    # p stdout_str
                    Dir.chdir(root_dir)
                else
                    stdout_str, status = Open3.capture2("git clone #{requirements[:source]}")
                    # p stdout_str
                    
                    if status.success?
                        Dir.chdir("#{name}")
                        stdout_str, status = Open3.capture2("git fetch && git checkout -b #{requirements[:branch]} && git pull --allow-unrelated-histories origin #{requirements[:branch]}")
                        Dir.chdir(root_dir)
                        # p stdout_str
                    end
                end
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