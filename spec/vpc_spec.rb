require 'spec_helper'

describe 'VPC' do
  let(:vpc_id) { output_for(:prerequisites, "vpc_id") }
  let(:infrastructure_events_bucket) { vars.infrastructure_events_bucket }

  subject { vpc(vpc_id) }

  it 'writes the VPC ID to the provided infrastructure events bucket' do
    expected_vpc_id = subject.vpc_id

    expect(s3_bucket(infrastructure_events_bucket))
        .to(have_object("vpc-existence/#{account.account}/#{expected_vpc_id}"))
  end

  it 'exposes the object key as an output' do
    expected_vpc_id = subject.vpc_id
    expected_object_key = "vpc-existence/#{account.account}/#{expected_vpc_id}"
    actual_object_key = output_for(:harness, 'vpc_lifecycle_event_key')

    expect(actual_object_key).to(eq(expected_object_key))
  end
end
