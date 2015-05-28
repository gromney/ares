require 'spec_helper'

describe Ares do
  context 'when valid language' do
    let(:language) {:ruby}

    it "should return the description of todays kata" do
      expect(Ares.train(language)).to include :description
    end
  end
end
