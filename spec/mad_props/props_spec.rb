require 'mad_props'

describe MadProps::Props do

  context 'from a hash' do

    let(:hash) do
      { name: 'randy', age: 5, cool: true, null: nil, pi: 3.14 }
    end
    let(:updated_hash) do
      # NOTE: we are changing the types of some of the values.  schema?
      { name: 'monkey', age: 1, cool: false, null: 'and void', pi: 'yummy' }
    end

    let(:props) { MadProps::Props.new(hash) }

    describe 'getters' do
      it 'define getters' do
        hash.keys.each do |key|
          props.respond_to?(key).should be_true
        end
      end
      it 'implement getters' do
        hash.each do |key,value|
          props.send(key).should == value
        end
      end
    end

    describe 'setters' do
      it 'define setters' do
        hash.keys.each do |key|
          props.respond_to?(key.to_s+"=").should be_true
        end
      end
      it 'implement setters' do
        updated_hash.each do |key, new_value|
          props.send(key.to_s+"=", new_value)
          props.send(key).should == new_value
        end
      end
    end

    describe '#properties' do
      it 'should list the properties' do
        [:name, :age, :cool, :null, :pi].each do |key|
          props.properties.should include(key)
        end
      end
    end

    describe '#remove_property' do
      it 'remove the property' do
        props.properties.should include(:cool)
        props.remove_property(:cool)
        props.properties.should_not include(:cool)
      end
    end

    # --------------------

    context 'with invalid arguments' do
      let(:invalid_args) { [1, false, [1,2], :a, Object, Object.new] }
      let(:reserved_keys) { %w(tap extend clone dup) }

      it 'should raise exception' do
        invalid_args.each do |arg|
          expect { MadProps::Props.new(arg) }.to raise_error ArgumentError
        end
        reserved_keys.each do |arg|
          expect { MadProps::Props.new(arg) }.to raise_error ArgumentError
        end
      end
    end

    # --------------------

    context 'with invalid property value types' do
      pending 'raise an exception'
    end

    # --------------------

    context 'with invalid property names' do
      pending 'should raise an exception'
    end

  end

  # --------------------

  context 'no args' do

    let(:props) { MadProps::Props.new }

    describe '#add_property' do
      before(:each) { props.add_property(:name, 'randy') }
      it 'define getter' do
        props.respond_to?(:name).should be_true
        props.name.should == 'randy'
      end
      it 'define setter' do
        props.name = 'monkey'
        props.name.should == 'monkey'
      end
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
