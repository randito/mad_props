require 'mad_props'

describe MadProps::Props do

  context 'from a hash' do

    let(:hash) do
      { name: 'randy', age: 5, cool: true, null: nil, pi: 3.14 }
    end
    let(:updated_hash) do
      # fyi, we are changing the types of some of the values.
      { name: 'monkey', age: 1, cool: false, null: 'and void', pi: 'yummy' }
    end

    describe 'getters' do
      subject { MadProps::Props.new(hash) }
      it 'define getters' do
        hash.keys.each do |key|
          subject.respond_to?(key).should be_true
        end
      end
      it 'implement getters' do
        hash.each do |key,value|
          subject.send(key).should == value
        end
      end
    end

    describe 'setters' do
      it 'define setters' do
        hash.keys.each do |key|
          subject.respond_to?(key.to_s+"=").should be_true
        end
      end
      it 'implement setters' do
        updated_hash.each do |key, new_value|
          subject.send(key.to_s+"=", new_value)
          subject.send(key).should == new_value
        end
      end
    end

    # --------------------

    context 'with invalid arguments' do
      it 'should raise exception' do
        [1, false, [1,2], :a, Object, Object.new].each do |arg|
          expect { MadProps::Props.new(arg) }.to raise_error ArgumentError
        end
      end
    end

    # --------------------

    context 'with invalid property value types' do
      it 'raise an exception'
    end

    # --------------------

    context 'with invalid property names' do
      it 'should raise an exception'
    end

  end


  # describe 'with parent' do
  #   it 'get inherited value'
  #   it 'override inherited value'
  #   describe 'with grandparent' do
  #     it 'gets inherited value'
  #   end
  # end
end
