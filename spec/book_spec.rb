require_relative '../Class/book'
require_relative '../Class/item'

describe Book do
  describe 'New' do
    it 'should return an instance of Book' do
      @book = Book.new('2015-04-21', 'Ebo White', 'bad')

      expect(@book).to be_an_instance_of Book
    end
  end

  describe '< Item' do
    it 'should inherit from Item class' do
      @book = Book.new('2015-04-21', 'Ebo White', 'bad')

      expect(Book).to be < Item
    end
  end

  describe '#move_to_archive' do
    it 'should return true' do
      @book = Book.new('2015-04-21', 'Ebo White', 'bad')

      @book.move_to_archive
      expect(@book.archived).to be true
    end
  end
end
