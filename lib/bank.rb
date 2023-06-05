# frozen_string_literal: true

require_relative 'importer'

class Bank
  attr_accessor :accounts

  def initialize
    @accounts = Importer.new.load_accounts('./csv/mb_acc_balance.csv')
  end

  def account_balances
    accounts.each do |account|
      puts "Start balance #{account.account_number}: $#{'%.2f' % account.balance}"
    end
  end

  def process_transfers
    self.accounts = Importer.new.load_transfers('./csv/mb_trans.csv', accounts)
  end

  def print_balances
    accounts.each do |account|
      puts "New balance #{account.account_number}: $#{'%.2f' % account.balance}"
    end
  end
end

bank = Bank.new
bank.account_balances
bank.process_transfers
bank.print_balances
