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

    # Classes
    class FuzzelOption:
        def __init__(self, title: str, command: list[str] = []) -> None:
            self.title = title
            self.command = command

        def exec(self) -> str:
            if self.command:
                process = subprocess.run(self.command, capture_output=True, text=True)
                process_output = process.stdout

                print(process_output)

                return process_output

            return ""

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

            selected_option = Fuzzel.spawn_fuzzel(formatted_options, self.prompt).split(
                "\n"
            )[0]

            for option in self.options:
                if option.title == selected_option:
                    option.exec()


# Menus
# main_menu = Fuzzel.Menu()

Fuzzel.Menu(
    options=[
        Fuzzel.FuzzelOption("drist1"),
        Fuzzel.FuzzelOption("  drist2", ["echo", "ponos2"]),
        Fuzzel.FuzzelOption("  drist3", ["echo", "ponos3"]),
    ]
).show()

