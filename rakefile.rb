

desc 'Sync the repositories (e.g. run repo sync)'
task :sync do
    puts "Syncing repositories"
    `repo sync`
end

desc 'Switch to the provided yocto release branch (e.g. gatesgarth, zeus, etc.)'
task :set_yocto_release, [:release_name] do |t, args|
    puts "Switching to #{args[:release_name]} branch"
    `repo init -b #{args[:release_name]}`
    Rake::Task[:sync].invoke()
end

desc 'Switch to the provided manifest (e.g. xilinx)'
task :set_manifest, [:manifest_name] do |t, args|
    puts "Switching to #{args[:manifest_name]} manifest"
    `repo init -m #{args[:manifest_name]}.xml`
    Rake::Task[:sync].invoke()
end