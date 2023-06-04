# frozen_string_literal: true

require 'csv'

class Bank
  def initialize
    @accounts = {}
  end

  def load_accounts(csv_filename)
    CSV.foreach(csv_filename) do |row|
      account_number = row[0]
      balance = row[1].to_f
      raise 'Invalid account number' if account_number.size != 16
      raise 'Invalid balance value' if balance.negative?

      @accounts[account_number] = balance
    end
  end

  def process_transfers(csv_filename)
    CSV.foreach(csv_filename) do |row|
      from_account = row[0]
      to_account = row[1]
      amount = row[2].to_f
      raise 'Invalid account number' if from_account.size != 16 || to_account.size != 16
      raise 'Invalid transfer amount' if amount.negative?
      raise 'Account not found' unless @accounts.key?(from_account) && @accounts.key?(to_account)
      raise 'Insufficient funds' if (@accounts[from_account] - amount).negative?

      @accounts[from_account] -= amount
      @accounts[to_account] += amount
    end
  end

  def print_balances
    @accounts.each do |account_number, balance|
      puts "#{account_number}: $#{'%.2f' % balance}"
    end
  end
end

bank = Bank.new
bank.load_accounts('./csv/mb_acc_balance.csv')
bank.process_transfers('./csv/mb_trans.csv')
bank.print_balances
