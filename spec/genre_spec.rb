require_relative '../classes/genre'

describe Genre do
  context 'Test Genre Class' do
    it 'takes one parameters and returns a object' do
      @genre = Genre.new 'Rock'
      expect(@genre).to be_an_instance_of Genre
    end
  end
end
