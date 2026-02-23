import subprocess
from pathlib import Path


class Fuzzel:
    def __init__(self) -> None:
        pass

    @staticmethod
    def spawn_fuzzel(options_string: str, prompt: str) -> str:
        executable = Path("/usr/bin/fuzzel")

        process = subprocess.run(
            [executable, "-d", "-p", prompt],
            input=options_string,
            capture_output=True,
            text=True,
        )
        process_output = process.stdout

        return process_output

    class FuzzelOption:
        def __init__(self, title: str, command: list[str]) -> None:
            self.title = title
            self.command = command

        def exec(self):
            command_output = subprocess.run(self.command, capture_output=True).stdout

            print(command_output)

    class Menu:
        def __init__(
            self, options: list["Fuzzel.FuzzelOption"], prompt: str = "󰍜 "
        ) -> None:
            self.options = options
            self.prompt = prompt

        def show(self):
            formatted_options = "".join(
                [f"{option.title}\n" for option in self.options]
            )

            selected_option = Fuzzel.spawn_fuzzel(formatted_options, self.prompt)

            print(selected_option)


# Menus
# main_menu = Fuzzel.Menu()

Fuzzel.Menu(
    options=[
        Fuzzel.FuzzelOption("drist1", ["echoponos1"]),
        Fuzzel.FuzzelOption("drist2", ["echoponos2"]),
        Fuzzel.FuzzelOption("drist3", ["echoponos3"]),
    ]
).show()
