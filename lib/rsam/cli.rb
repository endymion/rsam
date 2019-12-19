require 'thor'
require 'colorize'
require 'aws-sdk'

class RSAM

  class CLI < Thor

    desc "build", "Use SAM to build the app."
    long_desc <<-LONGDESC
LONGDESC
    def build
      RSAM.report_current_environment_name

      command = 'sam build --use-container'
      puts 'running sam command: ' + command.light_blue
      system(command)
    end

    desc "package", "Use SAM to package the app."
    long_desc <<-LONGDESC
LONGDESC
    def package
      RSAM.report_current_environment_name
      RSAM.report_current_deployment_bucket_name

      command = 'sam package ' +
        "--output-template-file #{RSAM::Context.environment_name}-packaged.yaml " +
        "--s3-bucket #{RSAM::Context.deployment_bucket_name}"
      puts 'running sam command: ' + command.light_blue
      system(command)
    end

    desc "deploy", "Use SAM to deploy the app."
    long_desc <<-LONGDESC
LONGDESC
    def deploy
      RSAM.report_current_environment_name
      RSAM.report_current_deployment_bucket_name

      command = 'sam deploy ' +
        "--template-file #{RSAM::Context.environment_name}-packaged.yaml " +
        "--stack-name #{RSAM::Context.project_name}-#{RSAM::Context.environment_name} " +
        "--capabilities CAPABILITY_IAM"
      puts 'running sam command: ' + command.light_blue
      system(command)
    end

  end

  def self.report_current_environment_name
    environment = RSAM::Context.environment_name
    puts 'current application environment: ' + environment.light_blue
  end

  def self.report_current_deployment_bucket_name
    bucket_name = RSAM::Context.deployment_bucket_name
    print 'deployment bucket name: ' + bucket_name.light_blue

    # Make sure that it exists.
    s3 = Aws::S3::Client.new
    unless s3.list_buckets.buckets.any?{|bucket| bucket.name.eql? bucket_name}
      print ' creating...'.yellow
      s3.create_bucket(bucket: bucket_name)
      puts 'success!'.green
    else
      puts ' exists'.green
    end
  end

end
