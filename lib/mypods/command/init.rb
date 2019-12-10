module MyPod
    class Command
        class Init < Command
            self.summary = "Generate a Mypodfile for the current directory"
            self.description = <<-DES
                Generate a Mypodfile for the current directory if none currently exists.
            DES
            # self.arguments =  [
            #     CLAide::Argument.new()
            # ]
            
            def initialize(argv)
                @mypodfile_path = Pathname.pwd + 'Mypodfile'
                super
            end
            
            def run
                @mypodfile_path.open('w') { |f| f << mypodfile_template }
            end
            
            def mypodfile_template
                mypodfile = ''
                mypodfile = <<~RUBY
                    mypods do
                        # Repo here
                        # repo 'name', :source => 'url_github', :branch => 'branch_to_sync'
                    end
                RUBY
                mypodfile
            end
        end
    end
end
