module Sh
  require 'open3'
  def self.hostname
    return bt "hostname".split("\n").first
  end
  
  def self.whoami
    return bt "whoami"
  end

  def self.bt(command)
    return `#{command}`
  end
    
  def self.sh(command, chomped=true, silence_errors=true)
    if silence_errors
      result = Open3.popen3(command)[1].readlines.to_s
    end
    result = result.chomp if chomped
    return result
  end
  
  def self.storage_bt(command)
    result = nil
    case STORAGE["type"]
    when "local"
      result = self.bt(command).split("\n")
    when "remote"
      result = self.bt("ssh #{STORAGE["user"]}@#{STORAGE["host"]} '#{command}'").split("\n")
    end
    return result    
  end
  
  def self.bt(command)
    return `#{command}`
  end
  
  def self.clean_gets
    STDOUT.flush
    response = STDIN.gets
    response = response.chomp
    exit 0 if response=="exit"
    return response
  end
  
  def self.clean_gets_yes_no(prompt=nil, retry_prompt="Sorry, one more time:")
    max_retries = 1000
    puts prompt+" (y/n)" if !prompt.nil?
    answer = Sh::clean_gets
    retries = 0
    while answer!="y" && answer!="n"
      retries+=1
      return nil if retries >= max_retries
      puts retry_prompt if !prompt.nil?
      answer = Sh::clean_gets
    end
    return answer=="y"
  end

  def self.mkdir(folder_location, location=STORAGE["type"])
    case location
    when "local"
      Sh::sh("mkdir -p #{folder_location}")
    when "remote"
      Sh::sh("ssh #{STORAGE["user"]}@#{STORAGE["host"]} 'mkdir -p #{folder_location}'")
    end
  end
  
  
  def self.ls(folder_location)
    self.bt("ls #{folder_location}").split("\n")
  end
  
  def self.storage_ls(folder_location, location=STORAGE["type"])
    case location
    when "local"
      Sh::bt("ls #{folder_location}").split("\n")
    when "remote"
      Sh::bt("ssh #{STORAGE["user"]}@#{STORAGE["host"]} 'ls #{folder_location}'").split("\n")
    end
  end  
  
  def self.decompress(file, to_location=".")
    existing_files = Sh::resolve_all_files(File.dirname(file))
    case File.extname(file)
    when ".gz"
      if to_location == "."
        Sh::sh("gunzip -c #{file} > #{file.gsub(File.dirname(file), file).gsub(".gz", "")}")
      else
        Sh::sh("gunzip -c #{file} > #{to_location}#{file.gsub(File.dirname(file), "").gsub(".gz", "").gsub(/^\//, "")}")
      end
    when ".zip"
      if to_location == "."
        Sh::sh("unzip #{file} -d #{File.dirname(file)}")
      else
        Sh::sh("unzip #{file} -d #{to_location}+#{file.gsub(File.dirname(file), "")}")
      end
    when ".tar.gz"
    else
      return [file]
    end
    current_files = Sh::resolve_all_files(File.dirname(file))
    file_additions = current_files-existing_files
    return file_additions
  end
  
  def self.compression_types
    return [".zip", ".tar.gz", ".gz"]
  end
  
  def self.resolve_all_files(folders)
    files = []
    folders = [folders].flatten
    folders.each do |folder|
      files << Sh::bt("find #{folder} -type f").split("\n").select{|file| File.file?(file) && !File.extname(file).empty? && !File.zero?(file)}
    end
    return files.flatten.uniq
  end
  
  def self.rm(file)
    if File.exists?(file)
      if File.file?(file)
        Sh::sh("rm #{file}") 
      else
        Sh::sh("rm -r #{file}") 
      end
    end
  end
  

  def self.compress(file)
    if File.file?(file)
      `zip #{file}.zip #{file} -j`
    elsif File.directory?(file)
      `zip #{file}.zip #{file} -j`
    end
  end
  
end