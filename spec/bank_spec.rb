# frozen_string_literal: true

require_relative '../bank'

RSpec.describe Bank do
  let(:bank) { Bank.new }

  describe '#load_accounts' do
    context 'with valid data' do
      it 'loads account balances' do
        expect do
          bank.load_accounts('mb_acc_balance.csv')
        end.to change { bank.instance_variable_get(:@accounts).size }.by(5)
      end
    end    
  end
end
