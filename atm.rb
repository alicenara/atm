class Atm  # A class name always starts with capital letter
  STARTING_BALANCE = 100.0

  def initialize(filename = 'balance.txt')
    # Read from a file
    @filename = filename
    begin
      @actual_balance = IO.readlines(filename)
    rescue
      @actual_balance = STARTING_BALANCE
    end
    # @instance variable = available through all the class yey
  end

  def run
    balance = actual_balance
    printf "This is the ATM awesome app. What do you wanna do?\n"
    print_menu
    selection = gets.chomp
    selection = selection.downcase
    while selection != 'q' 
      case selection
      when 'd'
        balance = deposit_action(balance)
      when 'w'
        balance = withdraw_action(balance)
      when 'b'
        print_money(balance, 1)
      else
        printf "This is not a valid option, please choose one of the following:\n"
      end
      print_menu
      selection = gets.chomp
      selection = selection.downcase
      printf "\n"
    end
    # Save in a file
    f = File.open(filename, 'w')
    f.write(balance)
    f.close
  end

  def print_money(money, type)
    # types:
    # => 1. Print balance
    # => 2. Print deposit
    # => 3. Print withdraw
    case type
    when 1
      printf "Your current balance is $%.2f\n", money
    when 2
      printf "You've just withdraw $%.2f\n", money
    when 3
      printf "You've just desposit $%.2f\n", money
    end
  end

  def print_menu
    printf "Desposit money: press D\n"
    printf "Withdraw money: press W\n"
    printf "Inspect balance: press B\n"
    printf "Quit: press Q\n"
  end 

  def withdraw_action(balance)
    amount = 0
    while amount <= 0 
      printf "\nHow much do you want to withdraw (only the number in $)? "
      begin
        amount = gets.to_f
        if amount <= 0  then 
          printf "\nIncorrect number, it must be greater than 0."
        elsif amount > balance 
          printf "\nYou don't have enough money on your account."
          amount = 0
        end
      rescue
        printf "\nThat's not a number! Try again."
      end
    end
    balance = balance - amount
    print_money(amount, 2)
    print_money(balance, 1)
    return balance
  end

  def deposit_action(balance)
    amount = 0
    while amount <= 0 
      printf "\nHow much do you want to deposit (only the number in $)? "
      begin
        amount = gets.to_f
        if amount <= 0  then 
          printf "\nIncorrect number, it must be greater than 0."
        end
      rescue
        printf "\nThat's not a number! Try again."
      end
    end
    balance += amount
    print_money(amount, 3)
    print_money(balance, 1)
    return balance
  end
end
