module Redenv
  module CLI
    def self.start
      usage if ARGV.length == 0
      if ENV['REDIS_URL'] || ENV['REDISTOGO_URL'] then
        envexec(*ARGV.dup)
      else
        fatal("REDIS_URL/REDISTOGO_URL undefined")
      end
    end
    
    private
    def self.envexec(*args)
      if ENV['REDIS_URL'] 
        url = URI(ENV['REDIS_URL'])
      elsif ENV['REDISTOGO_URL']
        url = URI(ENV['REDISTOGO_URL'])
      end
      
      params = {}
      params[:host] = url.host
      params[:port] = url.port
      params[:db] = url.path[1..-1].to_i if url.path
      params[:password] = CGI.unescape(url.password) if url.password
      
      redis = Redis.new(params)
      opts = hashify(url.query) 
      
      vars = redis.hgetall(opts[:namespace]) 
      ENV.update vars
      exec(*args)
    end
    
    def self.hashify(query)
      params = {}
      escaped = CGI.unescape(query)
      escaped.split('&').each do |frag|
        k, v = frag.split('=')
        params[k.to_sym] = v.strip
      end
      params
    end
    
    def self.usage()
      printf("redenv: usage: redenv child\n")
      printf("redenv: export REDIS_URL=redis://:password@127.0.0.1/0?namespace=app.config\n")
      exit(2)
    end
    
    def self.fatal(message)
      printf("%s\n", message)
      exit(1)
    end
  end
end