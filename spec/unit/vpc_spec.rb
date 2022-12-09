# frozen_string_literal: true

require 'spec_helper'

describe 'VPC' do
  let(:vpc_id) do
    output(role: :prerequisites, name: 'vpc_id')
  end
  let(:vpc_account_id) do
    output(role: :prerequisites, name: 'vpc_account_id')
  end
  let(:infrastructure_events_bucket) do
    output(role: :prerequisites, name: 'bucket_name')
  end

  describe 'by default' do
    before(:context) do
      @plan = plan(role: :root)
    end

    it 'creates a bucket object' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_s3_bucket_object')
              .once)
    end

    it 'uses the provided infrastructure bucket name' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_s3_bucket_object')
              .with_attribute_value(
                :bucket, infrastructure_events_bucket
              ))
    end

    it 'includes the VPC ID and account ID in the object key' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_s3_bucket_object')
              .with_attribute_value(
                :key, including(vpc_account_id).and(including(vpc_id))
              ))
    end

    it 'uses the VPC ID as the object content' do
      expect(@plan)
        .to(include_resource_creation(type: 'aws_s3_bucket_object')
              .with_attribute_value(
                :content, vpc_id
              ))
    end

    it 'outputs the VPC lifecycle event key' do
      expect(@plan)
        .to(include_output_creation(name: 'vpc_lifecycle_event_key'))
    end
  end
end
