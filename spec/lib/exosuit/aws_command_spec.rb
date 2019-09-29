require 'rspec'
require 'pry'

require_relative '../../../lib/exosuit/aws_command'

RSpec.describe Exosuit::AWSCommand do
  describe '#to_s' do
    context 'with profile' do
      it 'includes profile flag' do
        aws_command = Exosuit::AWSCommand.new(
          :terminate_instances,
          instance_ids: 'i-0d87dbc1ddfffe265',
          config: { 'aws_profile_name' => 'personal' }
        )

        text = 'aws ec2 terminate-instances --instance-ids i-0d87dbc1ddfffe265 --profile personal'
        expect(aws_command.to_s).to eq(text)
      end
    end

    context 'without profile' do
      it 'does not include profile flag' do
        aws_command = Exosuit::AWSCommand.new(
          :terminate_instances,
          instance_ids: 'i-0d87dbc1ddfffe265'
        )

        text = 'aws ec2 terminate-instances --instance-ids i-0d87dbc1ddfffe265'
        expect(aws_command.to_s).to eq(text)
      end
    end
  end
end
