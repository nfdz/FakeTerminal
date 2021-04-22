<p>
  <img src="dev/terminal_icon.png?raw=true" alt="Fake Terminal"/>
</p>


# Fake Terminal

Interactive terminal with fake data made with Flutter.

## The Idea

The application tries to simulate a classic terminal with a Bash shell on a Linux machine. In order to give the user this feeling, it implements a set of typical commands that every terminal user has ever used: `cat`, `ls`, `man`, and so on.

To provide a custom experience with specific content, the application allows to inject content through a JSON file. Through it, it is possible to add:
- Fake files to interact with them from the shell.
- Fake commands that can be executed.
