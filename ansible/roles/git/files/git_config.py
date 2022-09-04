import os
import codecs
import six
from colorama import Fore, Style

def echo(msg, msg_type=None):
    if not isinstance(msg, six.string_types):
        msg = str(msg)
    if msg_type == "warning":
        colored_msg = Fore.YELLOW + msg + Style.RESET_ALL
    if msg_type == "error":
        colored_msg = Fore.RED + msg + Style.RESET_ALL
    if msg_type == "info":
        colored_msg = Fore.GREEN + Style.DIM + msg + Style.RESET_ALL
    if not msg_type:
        colored_msg = msg + Style.RESET_ALL
    print(colored_msg)

def update_file(file_path, match_str, insert_str):
    """Insert insert_str into given file, by match_str."""
    changed = False
    with codecs.open(file_path, "r+", encoding="utf-8") as xml_file:
        contents = xml_file.readlines()
        if match_str in contents[-1]:  # Handle last line, prev. IndexError
            contents.append(insert_str)
            changed = True
        else:
            for index, line in enumerate(contents):
                if match_str in line and insert_str not in contents[index + 1]:
                    contents.insert(index + 1, insert_str)
                    changed = True
                    break
        xml_file.seek(0)
        xml_file.writelines(contents)

    if not changed:
        print(
            "WARNING: We couldn't find the match_str, "  # NOQA
            u"skip inserting into {0}:\n".format(file_path)  # NOQA
        )


def update_git_config():
    # file_name = u".gitconfig"
    file_name = u".gitconfig"
    directory_path = os.path.expanduser("~")
    file_path = f"{directory_path}/{file_name}"
    match_str = "[alias]"

    insert_str = r"""
    st = status
    cm = commit
    ch = checkout
    sw = switch
    br = branch
    mg = merge
    acm =  "!git add -A && git commit -m"
    mgd = "!git mg $1 && git br -d $1; #"
    # 查看分支(樹狀圖)
    lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
    # 查看reflog(HeighLight)
    rl = reflog --pretty=format:\"%Cred%h%Creset %C(auto)%gd%Creset %C(auto)%gs%C(reset) %C(green)(%cr)%C(reset) %C(bold blue)<%an>%Creset\" --abbrev-commit
    # 查看stash(HeighLight)
    sl = stash list --pretty=format:\"%C(red)%h%C(reset) - %C(dim yellow)(%C(bold magenta)%gd%C(dim yellow))%C(reset) %<(70,trunc)%s %C(green)(%cr) %C(bold blue)<%an>%C(reset)\"
    """
    update_file(file_path, match_str, insert_str)

if __name__ == '__main__':
    update_git_config()
    print("Script Finished", end="")
