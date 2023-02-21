require_relative '../Class/music_album'

describe MusicAlbum do
  context 'Test MusicAlbum Class' do
    it 'takes one parameters and returns a object' do
      @music_album = MusicAlbum.new '2002-02-02'
      expect(@music_album).to be_an_instance_of MusicAlbum
    end
  end
end
