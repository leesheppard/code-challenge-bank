# frozen_string_literal: true

require 'csv'
require_relative 'account'

class Importer

  def initialize; end

  def load_accounts(csv_filename)
    accounts = []
    CSV.foreach(csv_filename) do |row|
      account_number = row[0]
      balance = row[1].to_f
      account = Account.new(account_number, balance)
      accounts << account
    end
    accounts
  end

  def load_transfers(csv_filename, accounts)
    CSV.foreach(csv_filename) do |row|
      from_account_number = row[0]
      to_account_number = row[1]
      amount = row[2].to_f
      from_account = accounts.find { |account| account.account_number == from_account_number }
      to_account = accounts.find { |account| account.account_number == to_account_number }
      from_account.balance = from_account.balance - amount
      to_account.balance = to_account.balance + amount
    end
    accounts
  end
end
