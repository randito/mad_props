require 'mad_props'
include MadProps

describe Props do
  context '#initialize' do
    it 'from hash'
  end
  context 'get/set' do
    it 'define getters'
    it 'define setters'
  end
  describe 'with parent' do
    it 'get inherited value'
    it 'override inherited value'
    describe 'with grandparent' do
      it 'gets inherited value'
    end
  end
end
