require 'spec_helper'

describe Ares do
  describe "#get_user" do
    context "when valid user" do
      it 'should return full name of user gromney' do
        expect(Ares.get_user('gromney')['name']).to eq 'Geronimo Romney'
      end
    end
  end
  context 'when valid language' do
    let(:language) {:ruby}

    it "should return the description of todays kata" do
      expect(Ares.train(language)).to include :description
    end
  end
end
