#!/bin/zsh

# Check for argument
if [ -z "$1" ]; then
	echo "Usage: $0 /path/to/target_directory"
	exit 1
fi

TARGET_DIR="$1"
DRY_RUN=true

if [ ! -d "$TARGET_DIR" ]; then
	echo "Error: '$TARGET_DIR' is not a valid directory."
	exit 1
fi

# Initialize counters
processed=0
skipped=0

echo "--- Processing: $TARGET_DIR ---"
printf "%-12s | %-25s | %-12s | %s\n" "STATUS" "ORIGINAL NAME" "NEW NAME" "REASON"
echo "--------------------------------------------------------------------------------"

(
	cd "$TARGET_DIR" || exit
	
	for item in *; do
		# 1. Skip if it's not a directory
		if [[ ! -d "$item" ]]; then
			printf "[%-10s] | %-25s | %-12s | %s\n" "SKIPPED" "$item" "----" "Not a folder"
			((skipped++))
			continue
		fi

		# 2. Try to parse the date
		if [[ "$OSTYPE" == "darwin"* ]]; then
			new_name=$(date -j -f "%d %B %Y" "$item" "+%Y%m%d" 2>/dev/null)
		else
			new_name=$(date -d "$item" "+%Y%m%d" 2>/dev/null)
		fi

		# 3. If valid date, show preview/rename; otherwise skip
		if [ $? -eq 0 ] && [ -n "$new_name" ]; then
			if [ "$DRY_RUN" = true ]; then
				printf "[%-10s] | %-25s | %-12s | %s\n" "PREVIEW" "$item" "$new_name" "Valid Date"
			else
				mv "$item" "$new_name"
				printf "[%-10s] | %-25s | %-12s | %s\n" "RENAMED" "$item" "$new_name" "Success"
			fi
			((processed++))
		else
			printf "[%-10s] | %-25s | %-12s | %s\n" "SKIPPED" "$item" "----" "Invalid date format"
			((skipped++))
		fi
	done

	echo "--------------------------------------------------------------------------------"
	echo "SUMMARY:"
	echo "  Processed: $processed"
	echo "  Skipped:   $skipped"
)

if [ "$DRY_RUN" = true ]; then
	echo "--------------------------------------------------------------------------------"
	echo "Review the list. If it looks correct, set DRY_RUN=false in the script to apply."
fi