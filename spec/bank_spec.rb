# frozen_string_literal: true

require_relative '../lib/bank'

RSpec.describe Bank do
  let(:bank) { described_class.new }

  describe '#load_accounts' do
    context 'with valid data' do
      it 'loads account balances' do
        expect do
          bank.load_accounts('./csv/mb_acc_balance.csv')
        end.to change { bank.instance_variable_get(:@accounts).size }.by(5)
      end
    end
    
    context 'with invalid data' do
      it 'raises an error if account number is invalid' do
        expect do
          bank.load_accounts('./csv/invalid_accounts.csv')
        end.to raise_error('Invalid account number')
      end

      it 'raises an error if balance is negative' do
        expect do
          bank.load_accounts('./csv/negative_balance.csv')
        end.to raise_error('Invalid balance value')
      end
    end
  end

  describe '#process_transfers' do
    before do
      bank.load_accounts('./csv/mb_acc_balance.csv')
    end

    context 'with valid data' do
      it 'processes transfers' do
        expect do
          bank.process_transfers('./csv/daily_transfers.csv')
        end.to change { bank.instance_variable_get(:@accounts)['1111234522226789'] }.by(-500.00)
                                                                                    .and change {
                                                                                           bank.instance_variable_get(:@accounts)['3212343433335755']
                                                                                         }.by(-1000.00)
      end
    end

    context 'with invalid data' do
      it 'raises an error if account number is invalid' do
        expect do
          bank.process_transfers('./csv/invalid_accounts.csv')
        end.to raise_error('Invalid account number')
      end

      it 'raises an error if transfer amount is negative' do
        expect do
          bank.process_transfers('./csv/negative_transfer_amount.csv')
        end.to raise_error('Invalid transfer amount')
      end

      it 'raises an error if account is not found' do
        expect do
          bank.process_transfers('./csv/account_not_found.csv')
        end.to raise_error('Account not found')
      end
      
      it 'raises an error if there are insufficient funds' do
        expect do
          bank.process_transfers('./csv/insufficient_funds.csv')
        end.to raise_error('Insufficient funds')
      end
    end
  end

  describe '#print_balances' do
    it 'prints account balances' do
      bank.load_accounts('./csv/mb_acc_balance.csv')
      expect { bank.print_balances }.to output("1111234522226789: $5000.00\n1111234522221234: $10000.00\n2222123433331212: $550.00\n1212343433335665: $1200.00\n3212343433335755: $50000.00\n").to_stdout
    end
  end
end
