from __future__ import annotations
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
        def __init__(self, title: str, command: list[str] | Fuzzel.Menu = []) -> None:
            self.title = title
            self.command = command

        def exec(self) -> Fuzzel.Menu | None:
            if isinstance(self.command, list) and len(self.command) > 0:
                subprocess.run(self.command, capture_output=True, text=True)
                return None

            if isinstance(self.command, Fuzzel.Menu):
                return self.command

            return None

    class Menu:
        def __init__(
            self,
            options: list[Fuzzel.FuzzelOption],
            prompt: str = "󰍜 ",
            has_back: bool = False,
            parent: Fuzzel.Menu | None = None,
        ) -> None:
            self.options = options
            self.prompt = prompt
            self.has_back = has_back
            self.parent = parent

        def show(self) -> Fuzzel.Menu | None:
            local_options = self.options[:]
            if self.has_back and isinstance(self.parent, Fuzzel.Menu):
                local_options.insert(0, Fuzzel.FuzzelOption(" Back", self.parent))

            formatted_options = "".join(
                [f"{option.title}\n" for option in local_options]
            )

            result = Fuzzel.spawn_fuzzel(formatted_options, self.prompt).split("\n")[0]

            if not result:
                return None

            for option in local_options:
                if option.title == result:
                    return option.exec()
            return None


# Menus
# main_menu = Fuzzel.Menu()

menu_main = Fuzzel.Menu(options=[])
menu_power = Fuzzel.Menu(options=[], prompt="󰐥 ", has_back=True, parent=menu_main)

menu_main.options = [
    Fuzzel.FuzzelOption("󰣇 System"),
    Fuzzel.FuzzelOption("  󰐥 Power Menu", menu_power),
    Fuzzel.FuzzelOption("  󰚰 Update", ["echo", "done"]),
]

menu_power.options = [
    Fuzzel.FuzzelOption("  󰐥 Shutdown", ["systemctl", "poweroff"]),
    Fuzzel.FuzzelOption("   Reboot", ["systemctl", "reboot"]),
]


def run_menu(start_menu: Fuzzel.Menu):
    current_menu = start_menu
    while current_menu is not None:
        next_menu = current_menu.show()

        if isinstance(next_menu, Fuzzel.Menu):
            current_menu = next_menu
        else:
            break


run_menu(menu_main)

