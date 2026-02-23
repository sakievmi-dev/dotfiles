from __future__ import annotations
import subprocess
from pathlib import Path


# Utils {{{


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


# }}}

# Classes {{{


class FuzzelOption:
    def __init__(self, title: str, command: list[str] | FuzzelMenu = []) -> None:
        self.title = title
        self.command = command

    def exec(self) -> FuzzelMenu | None:
        # Check if getting a command prompt
        if isinstance(self.command, list) and len(self.command) > 0:
            subprocess.run(self.command, capture_output=True, text=True)
            return None

        # Check if getting a FuzzelMenu
        if isinstance(self.command, FuzzelMenu):
            return self.command

        return None


class FuzzelMenu:
    def __init__(
        self,
        options: list[FuzzelOption],
        prompt: str = "󰍜 ",
        has_back: bool = False,
        parent: FuzzelMenu | None = None,
    ) -> None:
        self.options = options
        self.prompt = prompt
        self.has_back = has_back
        self.parent = parent

    def show(self) -> FuzzelMenu | None:
        # Creating list copy with [:]
        local_options = self.options[:]
        if self.has_back and isinstance(self.parent, FuzzelMenu):
            local_options.insert(0, FuzzelOption(" Back", self.parent))

        # Formatting options for fuzzel
        formatted_options = "".join([f"{option.title}\n" for option in local_options])

        result = spawn_fuzzel(formatted_options, self.prompt).split("\n")[0]

        # Check if user pressed esc
        if not result:
            return None

        for option in local_options:
            if option.title == result:
                return option.exec()

        return None


# }}}

# Configuration {{{


def setup_menus():
    main = FuzzelMenu(options=[])
    power = FuzzelMenu(options=[], prompt="󰐥 ", has_back=True, parent=main)

    main.options = [
        FuzzelOption("󰣇 System"),
        FuzzelOption("  󰐥 Power Menu", power),
        FuzzelOption("  󰚰 Update", ["echo", "done"]),
    ]

    power.options = [
        FuzzelOption("  󰐥 Shutdown", ["systemctl", "poweroff"]),
        FuzzelOption("   Reboot", ["systemctl", "reboot"]),
    ]

    return main


# }}}

if __name__ == "__main__":
    current = setup_menus()
    while current:
        current = current.show()
