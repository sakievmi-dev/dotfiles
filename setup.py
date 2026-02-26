from pathlib import Path
import os
import argparse
import subprocess

SCRIPT = Path(__file__).resolve().parent
PACKAGES_PATH = SCRIPT / "pkgs"
INSTALLERS_PATH = SCRIPT / "sdata" / "installers"

stow_pkgs = {}

for category in os.scandir(PACKAGES_PATH):
    pkgs = {}
    for pkg in os.scandir(category.path):
        pkg_data = {}

        # Checking if installer exists
        installer_path = INSTALLERS_PATH / str(pkg.name + ".sh")
        if not installer_path.exists:
            continue
        pkg_data["installer_path"] = installer_path.absolute()

        configs_path = INSTALLERS_PATH / category / pkg.name
        pkg_data["configs_path"] = configs_path

        pkgs[pkg.name] = pkg_data

    stow_pkgs[category.name] = pkgs

# Functions {{{


def install_pkg(category: str, package: str):
    if category not in stow_pkgs:
        print(f"Category {category} does not exist. Skipping..")
        return None

    if package not in stow_pkgs[category]:
        print(f"Package {package} does not exist. Skipping..")
        return None

    installer_path = stow_pkgs[category][package]["installer_path"]
    subprocess.run(["sh", installer_path])


def install_core():
    try:
        for pkg in stow_pkgs["core"]:
            installer_path = stow_pkgs["core"][pkg]["installer_path"]

            subprocess.run(["sh", installer_path])

    except KeyboardInterrupt:
        print("Operation Aborted by user.")

    except Exception as e:
        print(f"Error occured while installing dotfiles! Error: {e}")


# TODO
def install_extra(pkg_name: str):
    pass


# }}}

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Install and manage sakievmi-dotfiles")
    subparsers = parser.add_subparsers(dest="command", help="List available commands")

    setup_parser = subparsers.add_parser(
        "setup", help="Installs core packages of sakievmi-dotfiles"
    )

    install_parser = subparsers.add_parser(
        "install", help="Installs extra packages selected by user"
    )
    install_parser.add_argument(
        "packages", nargs="+", help="List of packages to install"
    )

    args = parser.parse_args()

    if args.command == "setup":
        try:
            install_core()
        except KeyboardInterrupt:
            print("Operation Aborted by user.")
        except Exception as e:
            print(f"Error occured while installing dotfiles! Error: {e}")

    elif args.command == "install":
        try:
            for package in args.packages:
                if package in stow_pkgs["extra"]:
                    print(package)
                else:
                    print(f"{package} was not found... skipping")
        except KeyboardInterrupt:
            print("Operation Aborted by user.")
        except Exception as e:
            print(f"Error occured while installing extra packages! Error: {e}")

    else:
        parser.print_usage()
