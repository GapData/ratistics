require 'spec_helper'

module Ratistics

  describe Functions do

    context '#delta' do

      it 'computes the delta of two positive values' do
        Functions.delta(10.5, 5.0).should be_within(0.01).of(5.5)
      end

      it 'computes the delta of two negative values' do
        Functions.delta(-10.5, -5.0).should be_within(0.01).of(5.5)
      end

      it 'computes the delta of a positive and negative value' do
        Functions.delta(10.5, -5.0).should be_within(0.01).of(15.5)
      end

      it 'computes the delta of two positive values with a block' do
        v1 = {:count => 10.5}
        v2 = {:count => 5.0}
        Functions.delta(v1, v2){|x| x[:count]}.should be_within(0.01).of(5.5)
      end

      it 'computes the delta of two negative values with a block' do
        v1 = {:count => -10.5}
        v2 = {:count => -5.0}
        Functions.delta(v1, v2){|x| x[:count]}.should be_within(0.01).of(5.5)
      end

      it 'computes the delta of a positive and negative value with a block' do
        v1 = {:count => 10.5}
        v2 = {:count => -5.0}
        Functions.delta(v1, v2){|x| x[:count]}.should be_within(0.01).of(15.5)
      end
    end

    context '#relative_risk' do

      let(:low) { 16.8 }
      let(:high) { 18.2 }

      let(:low_obj) { {:risk => 16.8} }
      let(:high_obj) { {:risk => 18.2} }

      let(:low_risk) { 0.9230769230769231 }
      let(:high_risk) { 1.0833333333333333 }

      it 'computes a relative risk less than one' do
        risk = Ratistics.relative_risk(low, high)
        risk.should be_within(0.01).of(low_risk)
      end

      it 'computes a relative risk less than one with a block' do
        risk = Ratistics.relative_risk(low_obj, high_obj){|item| item[:risk]}
        risk.should be_within(0.01).of(low_risk)
      end

      it 'computes a relative risk equal to one' do
        risk = Ratistics.relative_risk(low, low)
        risk.should be_within(0.01).of(1.0)
      end

      it 'computes a relative risk equal to one with a block' do
        risk = Ratistics.relative_risk(high_obj, high_obj){|item| item[:risk]}
        risk.should be_within(0.01).of(1.0)
      end

      it 'computes a relative risk greater than one' do
        risk = Ratistics.relative_risk(high, low)
        risk.should be_within(0.01).of(high_risk)
      end

      it 'computes a relative risk greater than one with a block' do
        risk = Ratistics.relative_risk(high_obj, low_obj){|item| item[:risk]}
        risk.should be_within(0.01).of(high_risk)
      end
    end

    context '#min' do

      it 'returns nil for a nil sample' do
        Functions.min(nil).should be_nil
      end

      it 'returns nil for an empty sample' do
        Functions.min([].freeze).should be_nil
      end

      it 'returns the element for a one-element sample' do
        Functions.min([10].freeze).should eq 10
      end

      it 'returns the correct min for a multi-element sample' do
        sample = [18, 13, 13, 14, 13, 16, 14, 21, 13].freeze
        Functions.min(sample).should eq 13
      end

      it 'returns the min with a block' do
        sample = [
          {:count => 18},
          {:count => 13},
          {:count => 13},
          {:count => 14},
          {:count => 13},
          {:count => 16},
          {:count => 14},
          {:count => 21},
          {:count => 13},
        ].freeze

        min = Functions.min(sample){|item| item[:count] }
        min.should eq 13
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:vector) { Hamster.vector(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:set) { Hamster.set(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }

        specify { Functions.min(list).should eq 13 }

        specify { Functions.min(vector).should eq 13 }

        specify { Functions.min(set).should eq 13 }
      end
    end

    context '#max' do

      it 'returns nil for a nil sample' do
        Functions.max(nil).should be_nil
      end

      it 'returns nil for an empty sample' do
        Functions.max([].freeze).should be_nil
      end

      it 'returns the element for a one-element sample' do
        Functions.max([10].freeze).should eq 10
      end

      it 'returns the correct max for a multi-element sample' do
        sample = [18, 13, 13, 14, 13, 16, 14, 21, 13].freeze
        Functions.max(sample).should eq 21
      end

      it 'returns the max with a block' do
        sample = [
          {:count => 18},
          {:count => 13},
          {:count => 13},
          {:count => 14},
          {:count => 13},
          {:count => 16},
          {:count => 14},
          {:count => 21},
          {:count => 13},
        ].freeze

        max = Functions.max(sample){|item| item[:count] }
        max.should eq 21
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:vector) { Hamster.vector(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:set) { Hamster.set(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }

        specify { Functions.max(list).should eq 21 }

        specify { Functions.max(vector).should eq 21 }

        specify { Functions.max(set).should eq 21 }
      end
    end

    context '#minmax' do

      it 'returns an array with two nil elements for a nil sample' do
        Functions.minmax(nil).should eq [nil, nil]
      end

      it 'returns an array with two nil elements for an empty sample' do
        Functions.minmax([].freeze).should eq [nil, nil]
      end

      it 'returns the element as min and maxfor a one-element sample' do
        Functions.minmax([10].freeze).should eq [10, 10]
      end

      it 'returns the correct min and max for a multi-element sample' do
        sample = [18, 13, 13, 14, 13, 16, 14, 21, 13].freeze
        Functions.minmax(sample).should eq [13, 21]
      end

      it 'returns the min and max with a block' do
        sample = [
          {:count => 18},
          {:count => 13},
          {:count => 13},
          {:count => 14},
          {:count => 13},
          {:count => 16},
          {:count => 14},
          {:count => 21},
          {:count => 13},
        ].freeze

        minmax = Functions.minmax(sample){|item| item[:count] }
        minmax.should eq [13, 21]
      end

      context 'with Hamster' do

        let(:list) { Hamster.list(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:vector) { Hamster.vector(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }
        let(:set) { Hamster.set(18, 13, 13, 14, 13, 16, 14, 21, 13).freeze }

        specify { Functions.minmax(list).should eq [13, 21] }

        specify { Functions.minmax(vector).should eq [13, 21] }

        specify { Functions.minmax(set).should eq [13, 21] }
      end
    end
  end
end
