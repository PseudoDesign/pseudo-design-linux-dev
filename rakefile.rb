class Configuration
    # "Configurations" allow users to set up local enviornment settings 
    # to control exactly which system configuration they would like for
    # their build environment.  See usage examples below.
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

# Hard-coded configurations
workspace_dir = File.expand_path(File.join(File.dirname(__FILE__), "workspace"))
docker_image_name = "pseudo-design-linux-dev"

# A list of configurations and defaults
env_manifest_branch = Configuration.new('manifest-branch', 'scarthgap')
env_manifest_name = Configuration.new('manifest-name', 'default')

# Derrived values
docker_tag = "#{env_manifest_branch.value}-#{env_manifest_name.value}"
docker_image_full_name = "#{docker_image_name}:#{docker_tag}"

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

    desc "Initialize and sync the environment in the `workspace` directory using the `repo` command"
    task :sync do
        mkdir_p workspace_dir
        Dir.chdir(workspace_dir) do
            `repo init -u 'git@github.com:PseudoDesign/pseudo-design-linux-manifest.git' -m '#{env_manifest_name.value}.xml' -b '#{env_manifest_branch.value}'`
            `repo sync`
        end
    end
end

namespace :docker do
    desc "A string containing the environment variables used to map this rakefile with the docker module."
    environment_vars = "DOCKER_FULL_IMAGE_NAME=#{docker_image_full_name}"

    desc "Build the development container. It will be tagged #{docker_image_full_name}"
    task :build do
        `#{environment_vars} ./docker/create-build-image.sh`
    end

    desc "(Re)start the development container with tag #{docker_image_full_name}"
    task :start do
        sh "#{environment_vars} ./docker/start-build-image.sh"
    end
end

