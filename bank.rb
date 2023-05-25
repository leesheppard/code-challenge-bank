require 'csv'

class Bank
  def initialize
    @accounts = {}
  end
  
  def load_accounts(csv_filename)
    CSV.foreach(csv_filename) do |row|
      account_number, balance = row[0], row[1].to_f
      
      @accounts[account_number] = balance
    end
  end

  def process_transfers(csv_filename)
    CSV.foreach(csv_filename) do |row|
      from_account, to_account, amount = row[0], row[1], row[2].to_f
      
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
bank.load_accounts('mb_acc_balance.csv')
bank.process_transfers('mb_trans.csv')
bank.print_balances