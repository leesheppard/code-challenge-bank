# frozen_string_literal: true

require_relative '../lib/bank'
require_relative '../lib/importer'

RSpec.describe Bank do
  let(:bank) { described_class.new }

  describe '#load_accounts' do
    context 'with valid data' do
      it 'loads account balances' do
        expect(bank.accounts.size).to eq(5)
      end
    end
  end

  describe '#account_balances' do
    it 'prints account balances' do
      expect { bank.account_balances }.to output("Account balances\n1111234522226789: $5000.00\n1111234522221234: $10000.00\n2222123433331212: $550.00\n1212343433335665: $1200.00\n3212343433335755: $50000.00\n").to_stdout
    end
  end

  describe '#print_balances' do
    before do
      bank.process_transfers
    end
    it 'prints account balances' do
      expect { bank.print_balances }.to output("New balances\n1111234522226789: $4820.50\n1111234522221234: $9974.40\n2222123433331212: $1550.00\n1212343433335665: $1725.60\n3212343433335755: $48679.50\n").to_stdout
    end
  end
end
