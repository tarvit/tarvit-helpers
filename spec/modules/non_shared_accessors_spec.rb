require 'spec_helper'

describe NonSharedAccessors do

  context 'Native Class Accessor in Ruby' do

    it 'should explain native behavior (shared class variable)' do
      class A1
        cattr_accessor :value
      end

      class B1 < A1

      end

      expect(A1.value).to be_nil
      expect(B1.value).to be_nil

      A1.value = 2

      expect(A1.value).to eq(2)
      expect(B1.value).to eq(2)

      B1.value = 3

      expect(A1.value).to eq(3)
      expect(B1.value).to eq(3)
    end
  end

  it 'should behave as a separate accessor(separate class valiable)' do

    class A2
      include NonSharedAccessors
      non_shared_cattr_accessor :value
    end

    class B2 < A2

    end

    expect(A2.value).to be_nil
    expect(B2.value).to be_nil

    A2.value = 2

    expect(A2.value).to eq(2)
    expect(B2.value).to eq(nil)

    B2.value = 3

    expect(A2.value).to eq(2)
    expect(B2.value).to eq(3)
  end

end