require 'thor'

class RSAM

  class CLI < Thor

    desc "build", "Use SAM to build the app."
    long_desc <<-LONGDESC
    LONGDESC
    def build
      system('sam build --use-container')
    end

  end

end
