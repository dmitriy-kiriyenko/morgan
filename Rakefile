require 'yaml'

desc "Install cookbooks"
task :cookbooks do
  cookbooks = YAML.load(File.read("cookbooks.yml"))
  cookbooks.each do |name, data|
    data ||= {}
    target = "cookbooks/#{name}"

    if File.exist? target
      puts "*** Skipping #{name} - already exists ***"
      next
    else
      puts "*** Installing #{name} ***"
    end

    if data["git"]
      system "git clone #{data["git"]} #{target}"
    else
      system "git clone https://github.com/opscode-cookbooks/#{name} #{target}"
    end

    system "cd #{target} && git checkout #{data["rev"]}" if data["rev"]
  end
end