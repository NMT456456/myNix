import json
import argparse


def main():
    parser = argparse.ArgumentParser(
        description="Set background image for Windows Terminal profile."
    )
    parser.add_argument("--img", "-i", help="Tên ảnh")
    args = parser.parse_args()

    settingPath = "/mnt/c/Users/NMT45/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
    with open(settingPath, "r", encoding="utf-8") as f:
        data = json.load(f)

    for object in data["profiles"]["list"]:
        if object["name"] == "Ubuntu":
            object["backgroundImage"] = (
                f"C:\\Users\\NMT45\\Pictures\\shana\\{args.img}.jpg"
            )

    with open(settingPath, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=4)

    print("Done!")


if __name__ == "__main__":
    main()
