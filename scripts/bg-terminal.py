import json
import argparse
from pathlib import Path


def main():
    settingPath = "/mnt/c/Users/NMT45/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    settingFile = Path(settingPath)

    # check file setting có tồn tại ko
    if settingFile.exists():
        # chạy file python với --img <img name> để chọn file
        # VD : python bg-terminal.py --img shana1
        parser = argparse.ArgumentParser(
            description="Set background image for Windows Terminal profile."
        )

        # chỉ 1 trong 2 argument
        group = parser.add_mutually_exclusive_group(required=True)
        group.add_argument("--img", "-i", help="Tên ảnh")
        group.add_argument("--list", "-l", action="store_true", help="List ảnh có sẵn")

        args = parser.parse_args()

        # vào list ảnh
        if args.list:
            imgFolder = Path("/mnt/c/Users/NMT45/Pictures/terminal/")
            for img in imgFolder.glob("*.jpg"):
                print(img.name)

        # vào change img
        if args.img:
            imgPathInSettingFile = (
                f"C:\\Users\\NMT45\\Pictures\\terminal\\{args.img}.jpg"
            )
            imgPath = f"/mnt/c/Users/NMT45/Pictures/terminal/{args.img}.jpg"
            imgFile = Path(imgPath)

            # check file ảnh có tồn tại ko
            if imgFile.exists():
                # load file json
                with open(settingPath, "r", encoding="utf-8") as f:
                    data = json.load(f)

                for object in data["profiles"]["list"]:
                    if object["name"] == "Ubuntu":
                        object["backgroundImage"] = imgPathInSettingFile
                        object["backgroundImageOpacity"] = 0.2
                        object["colorScheme"] = "Tango Dark"
                        object["font"]["face"] = "JetBrainsMonoNL Nerd Font"

                # ghi đè file json
                with open(settingPath, "w", encoding="utf-8") as f:
                    json.dump(data, f, ensure_ascii=False, indent=4)

                print("Changed background successes!")

            else:
                print("Image file not found.")

    else:
        print("File setting not found.")


if __name__ == "__main__":
    main()
