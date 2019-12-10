module MyPod
    class MyPodFile
        class DSL
            require 'open3'
            require 'yaml'
            @@h ||= {}

            def repo(name = nil, **requirements)
                root_dir = Pathname.pwd
                lockfile_data = nil

                if File.exists?("Mypodfile.lock")
                    lockfile_data = YAML::load_file("Mypodfile.lock")
                end
                
                if Dir.exists?(name)
                    # Common pull
                    if lockfile_data[name][:branch] == requirements[:branch]
                        Dir.chdir("#{name}")
                        stdout_str, status = Open3.capture2("git pull origin #{requirements[:branch]}")
                        Dir.chdir(root_dir)
                    else
                        # Pull when branch changes
                        Dir.chdir("#{name}")
                        stdout_str, status = Open3.capture2("git fetch && git checkout #{requirements[:branch]} && git pull origin #{requirements[:branch]}")
                        lockfile_data[name][:branch] = requirements[:branch]
                        Dir.chdir(root_dir)
                        File.open("Mypodfile.lock", "w") { |file| file.write(lockfile_data.to_yaml) }
                    end
                else
                    stdout_str, status = Open3.capture2("git clone #{requirements[:source]}")
        
                    if status.success?
                        Dir.chdir("#{name}")
                        stdout_str, status = Open3.capture2("git fetch && git checkout #{requirements[:branch]} && git pull origin #{requirements[:branch]}")
                        Dir.chdir(root_dir)
                        @@h[name] = name
                        @@h[name] = requirements
                    end
                end
            end

            # abstract to installer class
            def mypods
                yield if block_given?
                File.open("Mypodfile.lock", "a") { |file| file.write(@@h.to_yaml) }
            end

            def self.load(filename)
                dsl = new
                dsl.instance_eval(File.read(filename))
            end
        end
    end
end