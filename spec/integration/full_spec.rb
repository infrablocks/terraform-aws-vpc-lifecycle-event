# frozen_string_literal: true

require 'spec_helper'

describe 'full' do
  let(:vpc_id) do
    output(role: :full, name: 'vpc_id')
  end
  let(:vpc_account_id) do
    output(role: :full, name: 'vpc_account_id')
  end
  let(:infrastructure_events_bucket) do
    output(role: :full, name: 'bucket_name')
  end
  let(:vpc_lifecycle_event_key) do
    output(role: :full, name: 'vpc_lifecycle_event_key')
  end

  before(:context) do
    apply(role: :full)
  end

  after(:context) do
    destroy(
      role: :full,
      only_if: -> { !ENV['FORCE_DESTROY'].nil? || ENV['SEED'].nil? }
    )
  end

  describe 'VPC' do
    subject(:target_vpc) do
      vpc(vpc_id)
    end

    it 'writes the VPC ID to the provided infrastructure events bucket' do
      expected_vpc_id = target_vpc.vpc_id

      expect(s3_bucket(infrastructure_events_bucket))
        .to(have_object(
              "vpc-existence/#{vpc_account_id}/#{expected_vpc_id}"
            ))
    end

    it 'exposes the object key as an output' do
      expected_vpc_id = target_vpc.vpc_id
      expected_object_key = "vpc-existence/#{vpc_account_id}/#{expected_vpc_id}"
      actual_object_key = vpc_lifecycle_event_key

      expect(actual_object_key).to(eq(expected_object_key))
    end
  end
end
