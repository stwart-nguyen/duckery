# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Duckery do
  # Make sure this run first
  before(:all) do
    described_class.config do |config|
      config.variants = %i[has_noise four_wings]
    end
  end

  let(:prepending_class) { SampleDuck }

  context "after prepending #{described_class}" do
    let!(:variant) { described_class.variants.sample }

    context 'when prepending class does not define method `variant`' do
      before { prepending_class.prepend(described_class) }

      it 'does not define variant as class method' do
        expect(prepending_class.respond_to?(variant)).to be false
      end
    end

    context 'when prepending class has method `variant`' do
      before do
        prepending_class.define_singleton_method(variant) {}
        prepending_class.prepend(described_class)
      end

      context 'when prepending class calls variant' do
        before { prepending_class.send(variant) }

        it 'adds variant to statistic' do
          expect(described_class.statistic[prepending_class.name][:variants]).to include(variant)
        end
      end

      context 'when prepending class does not call variant' do
        it 'does not add variant to statistic' do
          expect(described_class.statistic[prepending_class.name][:variants]).not_to include(variant)
        end
      end
    end
  end
end
