[![forthebadge](https://forthebadge.com/images/badges/made-with-ruby.svg)](https://forthebadge.com)

# Requirements

- [Ruby](Gemfile#L4)
- [Bundler](https://bundler.io)

## Task

- You are a developer for a company that runs a very simple banking service.
- Each day companies provide you with a CSV file with transfers they want to make between accounts for customers they are doing business with.
- Accounts are identified by a 16 digit number and money cannot be transferred from them if it will put the account balance below $0.
- The task is to implement a simple system that can load account balances for a single company and then accept a day's transfers in a CSV file.

### Configuration

Download and install:

    $ git clone https://github.com/leesheppard/code-challenge-bank.git    
    $ cd code-challenge-bank

### Run the application

To run the transfer of funds:

    $ rake transfers

Or manually with:

    $ ruby bank.rb

### Testing

To run test suite:

    $ rspec

### Afterword

Thanks for checking out my work.

![Lee Sheppard signature](http://res.cloudinary.com/leesheppard/image/upload/v1496495524/Lee-Sheppard-Black_iv1j84.png)

- [Linkedin](https://www.linkedin.com/in/leesheppard)
- [Twitter](https://twitter.com/leesheppard)