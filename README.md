# te - A tiny editor in Nim

This editor is (will be?) heavily inspired by antirez' [kilo](https://github.com/antirez/kilo) editor, and the [vis](https://github.com/martanne/vis) modal editor, albeit with my own twist.

## Why?

Very good question. I wanted to take a crack at building my own tooling, just for the sake of it, but there *is* a method to the madness: I've always wanted an editor that is not just language aware, but _framework_ aware. That's the long-term goal here, to have an editor that picks up on the particular use-cases that each framework exposes, to allow for extremely powerful autocorrect.

## Building

1. `nimble install`
1. `nimble build`
1. `./build/te`

## License

Released under the MIT license, Josh Girvin © 2016
