require 'spec_helper'

describe NonSharedAccessors do

  context 'Native Class Accessor in Ruby' do

    it 'should explain native behavior (shared class variable)' do
      class A
        cattr_accessor :value
      end

      class B < A

      end

      expect(A.value).to be_nil
      expect(B.value).to be_nil

      A.value = 2

      expect(A.value).to eq(2)
      expect(B.value).to eq(2)

      B.value = 3

      expect(A.value).to eq(3)
      expect(B.value).to eq(3)
    end
  end

  it 'should behave as a separate accessor(separate class valiable)' do

    class A
      include NonSharedAccessors
      non_shared_cattr_accessor :value
    end

    class B < A

    end

    expect(A.value).to be_nil
    expect(B.value).to be_nil

    A.value = 2

    expect(A.value).to eq(2)
    expect(B.value).to eq(nil)

    B.value = 3

    expect(A.value).to eq(2)
    expect(B.value).to eq(3)
  end

end