class RSAM

  class Context

    # Returns the current environment name, based on the environment variable.
    #
    # @return [String] The name of the current environment.  Defaults to "development".
    def self.environment_name
      ENV['RSAM_ENVIRONMENT'] || 'development'
    end

    # Returns the current project name, based on the current working
    # directory, the environment, or an explicit configuration.
    #
    # @return [String] The name of the current environment.
    def self.project_name
      `pwd`.gsub(/^.*\//,'').chop
    end

    # Returns the name of the bucket that RSAM uses for deploying
    # the app.  RSAM will create this bucket if it does not exist.
    #
    # @return [String] The name of the current environment.
    def self.deployment_bucket_name
      name = project_name + '-deployment'
    end

  end
end
