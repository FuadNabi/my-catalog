require_relative '../class/music_album'

describe MusicAlbum do
  context 'Test MusicAlbum Class' do
    it 'takes two parameters and returns a object' do
      @music_album = MusicAlbum.new 'The best of', '2002-02-02', true
      expect(@music_album).to be_an_instance_of MusicAlbum
    end
  end
end
