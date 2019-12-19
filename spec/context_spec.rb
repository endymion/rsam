RSpec.describe RSAM::Context do

  context "#environment_name" do

    it 'defaults to "development"' do
      ENV['RSAM_ENVIRONMENT'] = nil
      environment = RSAM::Context.environment_name
      expect(environment).not_to be nil
      expect(environment).to eq 'development'
    end

    it 'uses the RSAM_ENVIRONMENT value, if present' do
      ENV['RSAM_ENVIRONMENT'] = 'production'
      environment = RSAM::Context.environment_name
      expect(environment).not_to be nil
      expect(environment).to eq 'production'
    end

  end

  context "#project_name" do

    it 'defaults to the current working directory name' do
      environment = RSAM::Context.project_name
      expect(environment).not_to be nil
      expect(environment).to eq `pwd`.gsub(/^.*\//,'').chop
    end

  end

  context "#deployment_bucket_name" do

    it 'appends "-deployment" to the project name' do
      deployment_bucket_name = RSAM::Context.deployment_bucket_name
      expect(deployment_bucket_name).not_to be nil
      expect(deployment_bucket_name).to eq(
        RSAM::Context.project_name + '-deployment'
      )
    end

  end

end
