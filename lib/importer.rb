# frozen_string_literal: true

require "csv"
require_relative "account"

class Importer
  def load_accounts(csv_filename)
    accounts = []
    CSV.foreach(csv_filename) do |row|
      account_number = row[0]
      raise "Invalid account number" if account_number.size != 16

      balance = row[1].to_f
      raise "Invalid balance value" if balance.negative?

      account = Account.new(account_number, balance)
      accounts << account
    end
    accounts
  end

  def load_transfers(csv_filename, accounts)
    CSV.foreach(csv_filename) do |row|
      from_account_number = row[0]
      to_account_number = row[1]
      raise "Account number not found" unless from_account_number && to_account_number
      raise "Invalid account number" if from_account_number.size != 16 || to_account_number.size != 16

      amount = row[2].to_f
      raise "Invalid transfer amount" if amount.negative?

      from_account = accounts.detect { |account| account.account_number == from_account_number }
      raise "Account not found" unless from_account
      raise "Insufficient funds" if from_account.balance.negative? || from_account.balance < amount

      to_account = accounts.detect { |account| account.account_number == to_account_number }
      raise "Account not found" unless to_account

      from_account.balance = from_account.balance - amount
      to_account.balance = to_account.balance + amount
    end
    accounts
  end
end
