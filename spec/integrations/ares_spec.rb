require 'spec_helper'

describe Ares do
  let(:language) { :ruby }

  context 'when valid language' do
    it 'returns the description of todays kata' do
      expect(Ares.today_training(language)[:description]).eql to ''
    end
  end
end
