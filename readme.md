# Folder Date Reformatter

A lightweight Zsh script designed for macOS (and Linux) to batch-rename folders from a human-readable format (**DD Month YYYY**) to a sortable, ISO-style format (**YYYYMMDD**).

## 📋 Features

* **Smart Date Parsing:** Uses the system `date` command to accurately convert month names (e.g., "January") to numbers ("01").
* **Safety First:** Includes a `DRY_RUN` mode to preview changes before they happen.
* **Robust Filtering:** Automatically skips files, non-date folders, or hidden system files (like `.DS_Store`).
* **Aligned Output:** Provides a clean, tabular view of what is being processed, skipped, or renamed.
* **Cross-Platform:** Detects if you are on macOS (BSD) or Linux (GNU) and adjusts syntax automatically.

---

## 🚀 Getting Started

### 1. Installation

Save the script as `tidy-dates.sh` and give it execute permissions:

```bash
chmod +x tidy-dates.sh

```

### 2. Configuration

By default, the script runs in **Preview Mode**. Open the script and look for the `DRY_RUN` variable at the top:

* `DRY_RUN=true`: (Default) Shows you what *would* happen.
* `DRY_RUN=false`: Performs the actual folder renaming.

---

## 🛠 Usage

Run the script by passing the path to the directory containing your folders as an argument.

### Option A: Relative or Absolute Path

```bash
./tidy-datessh ~/Documents/MyFolders

```

### Option B: The "Mac Trick"

1. Type `./tidy-dates.sh ` (ensure there is a space at the end).
2. Drag the folder you want to process from **Finder** directly into the **Terminal** window.
3. Press **Enter**.

---

## 🔍 Example Output

When you run the script, you will see a structured table:

| STATUS | ORIGINAL NAME | NEW NAME | REASON |
| --- | --- | --- | --- |
| `[PREVIEW]` | 28 January 2026 | 20260128 | Valid Date |
| `[SKIPPED]` | vacation_notes.txt | ---- | Not a folder |
| `[SKIPPED]` | Old Backups | ---- | Invalid date format |

---

## ⚠️ Important Notes

* **Backup:** It is always a good idea to have a backup of your data before running batch-rename scripts.
* **Format Strictness:** The script expects the format `Day Month Year` (e.g., `05 May 2024`). If your folders use dashes or slashes, the `date` command parsing may need adjustment.
* **Collisions:** If two folders result in the same date string (e.g., "28 January 2026" and "28 Jan 2026"), the script will rename the first one and may throw an error on the second.
