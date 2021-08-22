# Chess

CLI Chess game made with Ruby.<br>
<ul>
  <li>Built using Object Oriented Programming principles in mind:
    <ul>
      <li> Encapsulation: Grouping ressembling logic together through classes</li>
      <li>Abstraction: Letting classes know as little as possible to others</li>
      <li>Inheritance: Each different piece inherits from the Piece super class </li>
      <li>Polymorphism: Each different piece can behave like it's parent Piece class</li>
    </ul>
      </li>
  <li>Throughly tested using Rspec.</li>
  <li>Save a match in progress thanks to serialization.</li>
</ul>



This is the final project for the Ruby Track from [The Odin Project](https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project?ref=lnav)

## Requirements

- [Ruby](https://www.ruby-lang.org/en/) >= 2.4
- [Bundler](https://bundler.io/) >= 2.1.2

## Installation

- Clone the repo locally. ([Instructions](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github/cloning-a-repository))

- `cd Chess` into the directory.

- And then execute:

```ruby
$ bundle install
```

## Demo

![fool's mate example](gif/fool.gif)

## How to Play

- Run `ruby game/game.rb`
- Select Play or Load (to play a previously saved game)

## Play Online

- Play in your browser with [repl.it](https://repl.it/@NicholasBerube/Chess#README.md)
- Make sure to zoom in on the console as it tends to feel small

## Gems Used

- [tty-prompt](https://github.com/piotrmurach/tty-prompt)
  - For player input and menus
- [figlet](https://github.com/tim/figlet)
  - For creating the title
- [pastel](https://github.com/piotrmurach/pastel)
  - Terminal output styling
