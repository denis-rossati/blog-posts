#!/bin/bash
set -e

GCS_BUCKET="$1"
API_KEY="$2"
PATCH_ENDPOINT="$3"

if ! command -v gsutil &>/dev/null; then
 	echo "No gsutil command found"
 	exit 1
fi

if ! command -v jq &>/dev/null; then
	echo "No jq command found"
	exit 1
fi

# Hacky but it does the job :)
generate_uuid_from_filename() {
	filename="$1"

	hash=$(echo -n "$filename" | sha1sum | awk '{print $1}' | cut -c1-32)

	echo "${hash:0:8}-${hash:8:4}-${hash:12:4}-${hash:16:4}-${hash:20:12}"
}

get_title_from_filename() {
	filename="$1"

	title=$(basename "$filename" .md | tr '_' ' ' | sed 's/^./\U&/')

	echo "$title"
}

encode_url() {
    echo -n "$1" | jq -sRr @uri
}

git diff HEAD~ --name-status | while read -r status file1 file2; do
    case "$status" in
        A)
            echo "Added: $file1"

            if [[ "$file1" == *.md ]]; then
		  		if [[ -f "$file1" ]]; then
					title=$(get_title_from_filename "$file1")
					id=$(generate_uuid_from_filename "$file1")

					gsutil cp "$file1" "gs://$GCS_BUCKET/$file1"

					encoded_url=$(encode_url "$file1")
					content_url="https://storage.googleapis.com/$GCS_BUCKET/$encoded_url"

					json=$(jq -n \
						--arg title "$title" \
						--arg id "$id" \
						--arg content_url "$content_url" \
						'\{operation: "ADD", payload: { title: $title, id: $id, contentUrl: $content_url } }'
					)

					curl -X POST "$PATCH_ENDPOINT?apiKey=$API_KEY" \
					-H "Content-Type: application/json" \
					-d "$json"
		  		fi
            fi
            ;;
        M)
            echo "Modified: $file1"

			if [[ "$file1" == *.md ]]; then
				gsutil cp "$file1" "gs://$GCS_BUCKET/$file1"
			fi
            ;;
        D)
            echo "Deleted: $file1"

			if [[ "$file1" == *.md ]]; then
				id=$(generate_uuid_from_filename "$file1")

				gsutil rm "gs://$GCS_BUCKET/$file1"

				json=$(jq -n \
					--arg id "$id" \
					'{ id: $id }'
				)

				curl -X DELETE "$PATCH_ENDPOINT?apiKey=$API_KEY" \
					-H "Content-Type: application/json" \
					-d "$json"
			fi
            ;;
        R*)
            echo "Renamed: $file1 -> $file2"
            if [[ "$file1" == *.md && "$file2" == *.md ]]; then
            	previous_id=$(generate_uuid_from_filename "$file1")
            	new_id=$(generate_uuid_from_filename "$file2")
				title=$(get_title_from_filename "$file2")


				gsutil cp "$file2" "gs://$GCS_BUCKET/$file2"

				encoded_url=$(encode_url "$file2")
				content_url="https://storage.googleapis.com/$GCS_BUCKET/$encoded_url"

				json=$(jq -n \
					--arg previous_id "$previous_id" \
					--arg new_id "$new_id" \
					--arg title "$title" \
					--arg content_url "$content_url" \
					'{operation: "UPDATE", payload: { previousId: $previous_id, newId: $new_id, title: $title, contentUrl: $content_url } }'
				)

				curl -X POST "$PATCH_ENDPOINT?apiKey=$API_KEY" \
					-H "Content-Type: application/json" \
					-d "$json"

				gsutil rm "gs://$GCS_BUCKET/$file1"
            fi
			;;
        *)
            echo "Unknown status ($status): $file1 $file2"
            ;;
    esac
done

