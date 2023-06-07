# frozen_string_literal: true

require_relative '../lib/bank'
require_relative '../lib/importer'

RSpec.describe Importer do
  let(:bank) { Bank.new }
  let(:importer) { described_class.new }

  describe '#load_accounts' do
    context 'with invalid data' do
      it 'raises an error if account number is invalid' do
        expect do
          importer.load_accounts('./csv/invalid_accounts.csv')
        end.to raise_error('Invalid account number')
      end

      it 'raises an error if balance is negative' do
        expect do
          importer.load_accounts('./csv/negative_balance.csv')
        end.to raise_error('Invalid balance value')
      end
    end
  end

  describe '#process_transfers' do
    context 'with invalid data' do
      it 'raises an error if account number is invalid' do
        expect do
          importer.load_transfers('./csv/invalid_accounts.csv', bank.accounts)
        end.to raise_error('Invalid account number')
      end

      it 'raises an error if transfer amount is negative' do
        expect do
          importer.load_transfers('./csv/negative_transfer_amount.csv', bank.accounts)
        end.to raise_error('Invalid transfer amount')
      end

      it 'raises an error if account is not found' do
        expect do
          importer.load_transfers('./csv/account_not_found.csv', bank.accounts)
        end.to raise_error('Account not found')
      end

      it 'raises an error if there are insufficient funds' do
        expect do
          importer.load_transfers('./csv/insufficient_funds.csv', bank.accounts)
        end.to raise_error('Insufficient funds')
      end
    end
  end
end
