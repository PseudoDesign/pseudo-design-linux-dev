class Configuration
    def initialize(name, default_value)
        @name = name
        @default_value = default_value
    end

    def file
        File.expand_path(File.join(File.dirname(__FILE__), ".conf", @name))
    end

    def value
        if File.exist?(self.file)
            File.read(self.file)
        else
            @default_value
        end
    end

    def value=(value)
        FileUtils.mkdir_p File.dirname(self.file)
        File.write(self.file, value)
    end
end

# A list of configurations and defaults
env_manifest_branch = Configuration.new('manifest-branch', 'scarthgap')
env_manifest_name = Configuration.new('manifest-name', 'default')

# Derrived configurations.


namespace :manifest do
    desc "Get or Set the manifest branch to the provided value."
    task :branch, [:set_value] do |t, args|
        if args.set_value
            env_manifest_branch.value = args.set_value
        end
        puts "Manifest branch: #{env_manifest_branch.value}"
    end

    desc "Get or Set the manifest name to the provided value."
    task :name, [:set_value] do |t, args|
        if args.set_value
            env_manifest_name.value = args.set_value
        end
        puts "Manifest name: #{env_manifest_name.value}"
    end

    desc "Initialize and sync the environment using the `repo` command"
    task :sync do
        `repo init -u 'git@github.com:PseudoDesign/pseudo-design-linux-manifest.git' -m '#{env_manifest_name.value}.xml' -b '#{env_manifest_branch.value}'`
        `repo sync`
    end
end
