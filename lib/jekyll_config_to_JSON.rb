require 'json'
require 'fileutils'

module Jekyll
  
  # https://github.com/jekyll/jekyll-sitemap/blob/v0.7.0/lib/jekyll-sitemap.rb#L3-L8
  class PageWithoutAFile < Page
    def read_yaml(*)
      @data ||= {}
    end
  end
  
  class GenerateJSON < Jekyll::Generator
    attr_reader :site
    safe true
    priority :low
    @@globals = {
      "json_file_path" => "",
      "output_directory" => "/api/v1/",
      "output_file" => "config.json",
      "src_dir" => "",
      "dst_dir" => ""
    }

    def generate(site)
      @site = site
      jobs
    end

    def initialize(site)
      @site = site
    end

    def self.json_output_directory
      @@globals["output_directory"]
    end

    def self.json_file
      @@globals["json_file_path"]
    end

    # write to file
    def write(file, content)
      f = File.new(file, "w+")
      f.puts content
      f.close
    end
    
    def page(name, data)
      page = PageWithoutAFile.new(@site, File.dirname(__FILE__), @@globals["output_directory"], name)
      page.output = data.to_json
      page
    end

    # add file to list of objects to be generated
    def static_gen(output_dir, output_file)
      if File.exists?@@globals["json_file_path"]
        site.static_files << Jekyll::StaticFile.new(self.site, self.site.source, output_dir, output_file)
      end
    end

    def gen_alt(name, data)
      self.site.pages << self.page(name, data)
    end

    def jobs
      config = @site.config['react']
      config_json = config.to_json
       
      @site.pages.each do |page|
        if page.data['render'] && page.data['render'] == 'dynamic'
          puts page.url
          page.content = ''
        end
      end

      if @@globals["src_dir"].to_s.empty? && @@globals["dst_dir"].to_s.empty?
        @@globals["src_dir"] = File.join(@site.source, @@globals["output_directory"])
        @@globals["dst_dir"] = File.join(@site.dest, @@globals["output_directory"])
        @@globals["json_file_path"] = File.join(@@globals["src_dir"], @@globals["output_file"])
        gen_alt(@@globals["output_file"], config_json)
      else
        #else the filejoins have already been executed (IE: We are regenerating and not building)
        gen_alt(@@globals["output_file"], config_json)
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
=begin 
      # cleanup source folder
      src_folder = File.join(source, GenerateJSON::json_output_directory)
      File.unlink GenerateJSON::json_file if File.exists?(GenerateJSON::json_file)
      if File.exists?(src_folder)
        FileUtils.rm_rf(src_folder)
        src_arr = src_folder.split("/")
        src_arr.pop
        src_folder = src_arr.join("/")
        FileUtils.rm_rf(src_folder)
      end
=end
    end
  end
end
