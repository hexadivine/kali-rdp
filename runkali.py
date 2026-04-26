import tkinter as tk
from tkinter import simpledialog, messagebox
import subprocess

root = tk.Tk()
root.withdraw()  

# Input dialog
user_input = simpledialog.askstring("Input Window", "Provide kali tool name: ")

if user_input is None:
  exit

# Execute command in kali ssh
subprocess.Popen([
    "ssh",
    "-Y",
    "-C",
    "-c", "chacha20-poly1305@openssh.com",
    "kali@localhost",
    user_input
])
