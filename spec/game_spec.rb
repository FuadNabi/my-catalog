require_relative '../class/game'

describe Game do
  let(:game) { Game.new('yes', '11/22/2022', '01/28/1998') }
  describe 'New' do
    it 'should return an instance of Game' do
      expect(game).to be_an_instance_of Game
    end
    it 'should have a multiplayer' do
      expect(game.multiplayer).to eq('yes')
    end
    it 'should have a last_played_at' do
      expect(game.last_played_at).to eq('11/22/2022')
    end
    it 'should have a published_date' do
      expect(game.publish_date).to eq('01/28/1998')
    end
    it 'has can_be_archived? method' do
      expect(game).to respond_to(:can_be_archived?)
    end
  end
end
