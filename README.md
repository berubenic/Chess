# Chess

CLI Chess game made with Ruby.
This is the final project of the Ruby Track from [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav)

## Requirements
- [Ruby](https://www.ruby-lang.org/en/) >= 2.6.5
- [Bundler](https://bundler.io/) >= 2.1.2

## Installation

- Clone the repo locally.

- `cd` into the directory.

- And then execute:

```ruby
$ bundle install
```

## Demo

## How to Play

- Run `ruby game/game.rb`
- Select Play or Load (to play a previously saved game)

## Play Online

- Play in your browser with [repl.it](##)

## Gems Used

- [tty-prompt](https://github.com/piotrmurach/tty-prompt)
  - For player input and menus
- [figlet](https://github.com/tim/figlet)
  - For creating the title

## Project Review

- Tests were written for all piece movements, captures and win conditions.
- These tests helped me move forward with confidence.
- Not putting enough thought in how my Game class was going to interact with my other classes left me in tough spot as most of my code was already written and tested.
- Refactoring is still needed to keep my code as DRY as possible. Further tests would be needed. 







