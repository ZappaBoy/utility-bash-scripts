#!/usr/bin/env bash

# Before use this script install youtube-dl
# Check: https://github.com/ytdl-org/youtube-dl
#
# Usage:
# Go to you course link and pass only the course name from the url as parameter.
# Example:
# Course Url: https://www.udemy.com/course/social-media-marketing-il-corso-completo-con-certificato/
# ./coursedl.sh "social-media-marketing-il-corso-completo-con-certificato"

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)
base_url="https://www.udemy.com/"
course_name=$1
[ -z "${course_name}" ] && echo "Please define a course name" && exit 1

course_dir="$script_dir/${course_name}"
mkdir -p "$course_dir"

node "$script_dir/convert-cookies.js" "$script_dir/udemy-cookies.txt" > "$script_dir/netscape-cookies.txt"
youtube-dl "${base_url}${course_name}" --cookies "$script_dir/netscape-cookies.txt" --output "$course_dir/%(title)s.%(ext)s"
rm "$script_dir/netscape-cookies.txt"
