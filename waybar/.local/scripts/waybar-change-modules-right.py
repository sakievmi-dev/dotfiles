#!/usr/bin/env python3

import argparse
import json
import shutil
import subprocess
from dataclasses import dataclass
from pathlib import Path

# Const
BASE_DIR = Path(__file__).resolve().parent
WB_USER_CONFIG_PATH = Path().home() / ".config" / "waybar"
WB_CUSTOMIZER_PATH = WB_USER_CONFIG_PATH / "customizer-data"
WB_MODULES = WB_CUSTOMIZER_PATH / "modules"


# Dataclasses
@dataclass()
class WaybarModule:
    json_path: Path
    css_class: str


# Functions
def mod_path(name: str) -> Path:
    return WB_MODULES / name


def restart_waybar():
    subprocess.run(["killall", "waybar"])
    subprocess.Popen(
        ["waybar"],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
        start_new_session=True,
    )


# Data Tables
MODULE_DATA = {
    "battery": WaybarModule(mod_path("battery.json"), "battery"),
    "tray": WaybarModule(mod_path("tray.json"), "tray"),
    "cpu": WaybarModule(mod_path("cpu.json"), "cpu"),
    "memory": WaybarModule(mod_path("memory.json"), "memory"),
    "network": WaybarModule(mod_path("network.json"), "network"),
    "pulseaudio": WaybarModule(mod_path("pulseaudio.json"), "pulseaudio"),
    "clock#date": WaybarModule(mod_path("clock#date.json"), "date"),
    "clock#time": WaybarModule(mod_path("clock#time.json"), "time"),
    "niri/language": WaybarModule(mod_path("niri/language.json"), "language"),
    "custom/updates": WaybarModule(mod_path("custom/updates.json"), "updates"),
    # If you want to add custom module, feel free to do this!
}


class FileManager:
    def __init__(self):
        self.paths = {
            "template_config": WB_CUSTOMIZER_PATH / "templates" / "config",
            "template_arrow": WB_CUSTOMIZER_PATH / "templates" / "arrow.json",
            "user_config": WB_USER_CONFIG_PATH / "config",
            "user_css_arrows": WB_USER_CONFIG_PATH / "arrows.css",
        }

    @staticmethod
    def read_json(json_path: Path):
        print(f"Reading {json_path}...")

        if not json_path.exists():
            raise FileNotFoundError(f"{json_path} does not exist!")

        try:
            with open(json_path, "r", encoding="utf-8") as file:
                return json.load(file)
        except json.JSONDecodeError as e:
            raise ValueError(f"Invalid JSON format in {json_path}: {e}")

    # Read functions
    def get_wb_config_template(self):
        return self.read_json(self.paths["template_config"])

    def get_wb_arrow_template(self):
        return self.read_json(self.paths["template_arrow"])

    def get_wb_module_template(self, module_name: str):
        if module_name not in MODULE_DATA:
            raise KeyError(f"Module '{module_name}' not defined.")
        return self.read_json(MODULE_DATA[module_name].json_path)

    # Write functions
    def write_css_arrows_file(self, lines: list):
        content = "\n".join(lines)
        self.paths["user_css_arrows"].write_text(content, encoding="utf-8")

    def write_wb_config(self, json_data: dict):
        config_path = self.paths["user_config"]
        backup_path = config_path.with_suffix(".bak")

        if not backup_path.exists() and config_path.exists():
            shutil.copy2(config_path, backup_path)

        with open(config_path, "w") as file:
            json.dump(json_data, file, indent=4)


class WaybarConfigManager:
    def __init__(self, fm: FileManager) -> None:
        self.fm = fm

    def generate_rules_and_modules(self, selected_modules: list[str]):
        # Generating queue to ensure that everything is correct
        modules_queue = []

        for module in selected_modules:
            if module in MODULE_DATA:
                modules_queue.append(MODULE_DATA[module])
            else:
                print(f"Module {module} does not exist! Skipping...")

        # Generating .jsonc and .css file data for Waybar config
        final_json_modules = []
        css_rules = []
        arrows_modules = []

        # Creating first arrow (transparent background)
        last_mod = modules_queue[0]
        final_json_modules.append("custom/arrow-end")
        arrows_modules.append("custom/arrow-end")
        css_rules.append(
            f"#custom-arrow-end {{\n"
            f"    font-size: 11pt;\n"
            f"    color: @{last_mod.css_class};\n"
            f"    background: transparent;\n"
            f"}}"
            f""
        )

        for i in range(len(modules_queue)):
            current_mod = modules_queue[i]

            final_json_modules.append(
                str(current_mod.json_path.relative_to(WB_MODULES)).split(".json")[0]
            )

            if i + 1 < len(modules_queue):
                next_module = modules_queue[i + 1]

                arrow_id = f"{current_mod.css_class}-{next_module.css_class}"
                final_json_modules.append(f"custom/arrow#{arrow_id}")
                arrows_modules.append(f"custom/arrow#{arrow_id}")

                css_arrow_id = (
                    f"custom-arrow.{current_mod.css_class}-{next_module.css_class}"
                )
                css_rule = (
                    f"#{css_arrow_id} {{\n"
                    f"    font-size: 11pt;\n"
                    f"    color: @{next_module.css_class};\n"
                    f"    background: @{current_mod.css_class};\n"
                    f"}}"
                    f""
                )
                css_rules.append(css_rule)

        return (final_json_modules, css_rules, arrows_modules)

    def generate_json_config(self, json_modules, arrows_modules):
        # Getting list of modules without arrows
        json_modules_without_arrows = [
            item for item in json_modules if item not in arrows_modules
        ]

        # Generating full json of config file
        new_config = self.fm.get_wb_config_template()

        # Adding all modules into "modules-right"
        new_config["modules-right"] = json_modules

        # Adding all arrows as custom modules
        for module in arrows_modules:
            new_config[module] = self.fm.get_wb_arrow_template()

        # Adding other modules
        for module in json_modules_without_arrows:
            new_config[module] = self.fm.get_wb_module_template(module)

        return new_config

    def apply_css(self, generated_css):
        self.fm.write_css_arrows_file(generated_css)

    def apply_json(self, generated_json):
        self.fm.write_wb_config(generated_json)


if __name__ == "__main__":
    wb_config_manager = WaybarConfigManager(fm=FileManager())

    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--modules_right",
        help="Change modules on the right side separated by ';'. Example: 'niri/language;tray'",
    )
    parser.add_argument(
        "-m", "--modules", help="Show all available modules", action="store_true"
    )

    args = parser.parse_args()

    if args.modules:
        all_modules = [module for module in MODULE_DATA]
        print("\n".join(all_modules))

    if args.modules_right:
        modules_right: list[str] = args.modules_right.split(";")

        json_modules, rules, arrows_modules = (
            wb_config_manager.generate_rules_and_modules(modules_right)
        )

        config_final = wb_config_manager.generate_json_config(
            json_modules, arrows_modules
        )

        wb_config_manager.apply_css(rules)
        wb_config_manager.apply_json(config_final)

        restart_waybar()
