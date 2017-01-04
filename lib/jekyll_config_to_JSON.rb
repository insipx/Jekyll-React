module Jekyll
  require 'json'
  require 'fileutils'
 
  class GenerateJSON < Jekyll::Generator
    safe true
    priority :low
    @@globals = {
      "json_file_path" => nil,
      "output_directory" => "/api/v1/",
      "output_file" => "config.json",
      "src_dir" => nil,
      "dst_dir" => nil
    }
    def self.json_output_directory
      @@globals["output_directory"]
    end
    def self.json_file
      @@globals["json_file_path"]
    end

    def generate(site)
       
      @@globals["src_dir"] = File.join(site.source, @@globals["output_directory"]) unless @@globals["src_dir"].any?
      @@globals["dst_dir"] = File.join(site.dest, @@globals["output_directory"]) unless @@globals["dst_dir"].any?
      FileUtils.mkdir_p(@@globals["src_dir"]) unless File.exists?(@@globals["src_dir"])

      config = site.config['react']
      config_json = config.to_json
      
      @@globals["json_file_path"] = File.join(@@globals["src_dir"], @@globals["json_file"]) unless @@globals["json_file_path"].any?
      f = File.new(@@globals["json_file_path"], "w+") unless !File.file(@@globals["json_file_path"])
      f.puts config_json
      f.close
      if File.file(src_dir)
        site.static_files << Jekyll::StaticFile.new(site, site.source, @@globals['output_directory'], @@globals['output_file'])
      end
     
    end
  end
  #static override of the Jekyll Class
  class Site
    alias :super_write :write
    def write
      # call the super method to generate our site
      # Must call otherwise our site will be gone :'(
      super_write

      # cleanup source folder
      src_folder = File.join(source, GenerateJSON::json_output_directory) unless !File.file?([source, GenerateJSON::json_output_directory].join('/'))
      File.unlink GenerateJSON::json_file if File.exists?(GenerateJSON::json_file)
      FileUtils.rm_rf(src_folder) unless !File.file?(src_folder)
      src_arr = src_folder.split("/")
      src_arr.pop
      src_folder = src_arr.join("/")
      FileUtils.rm_rf(src_folder) unless !File.file?(src_folder)

    end
  end
end
