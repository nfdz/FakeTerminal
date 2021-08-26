<p align="left">
  <a href="https://github.com/nfdz/FakeTerminal/actions/workflows/ci.yml">
    <img alt="build and test status" src="https://github.com/nfdz/FakeTerminal/actions/workflows/ci.yml/badge.svg">
  </a>
</p>

<p>
  <img src="dev/terminal_icon.png?raw=true" alt="Fake Terminal" width="200" height="200"/>
</p>

# Fake Terminal

Interactive terminal with fake commands and data made with Flutter.

## Why?

This terminal is a fun way to communicate information in a different, fun, familiar and relaxed way.

This is also a playground. Where we can test Flutter & Dart, testing the framework and language updates, new libraries, platforms, design patterns, testing strategies, CI/CD, and so on.

The application tries to simulate a classic terminal with a Bash shell on a Linux machine. In order to give the user this feeling, it implements a set of typical commands that every terminal user has ever used: `cat`, `ls`, `man`, and so on.

## How to use?

1. Fork this repository.
2. Edit `terminal_texts.dart`. This contains the texts localized in English that the application needs to work.
3. Edit `fake_data.json`. This is a JSON file that contains a set of `fake_files` and `fake_commands`.
  - Fake file model. The content of the file can be directly in the JSON by using `content`. 
  Or it can be in a remote by using `content_url`, and the HTTP client will try to GET the data from this URL.
```json
{
  "name": "name-of-the-file",
  "content_url": "url-to-the-content"
}
```
```json
{
  "name": "name-of-the-file",
  "content": "The content"
}
```
  - Fake command model. It has the following fields:
    - `name`: It will launch the execution.
    - `description`: It is used by `help` and `man` to compose the command information.
    - `default_argument`: It is the argument that will be executed when the user did not provide one.
    - `arguments`: Set of arguments. Each argument has a `name`, `description`, and `output`/`output_url`. As with the file, the information can be in the file or remotely.

```json
{
  "name": "name-of-the-command",
  "description": "This is the description",
  "default_argument": "default",
  "arguments": [
      {
          "name": "default",
          "description": "Default argument",
          "output": "The output"
      },
      {
          "name": "other-argument",
          "description": "Other argument",
          "output_url": "url-to-the-output"
      }
  ]
}
```