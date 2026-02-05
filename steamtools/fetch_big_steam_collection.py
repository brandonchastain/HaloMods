import argparse
import csv
import json
import requests

"""
fetch_big_steam_collection.py

How to use:
1. If you find a collection that appears empty in Steam, view the URL and copy the collection ID at the end.
2. Run this script, providing the collection ID as an argument.

Example usage (CLI):
>   python fetch_big_steam_collection.py 2900785277

What it does:
- Fetches metadata like URL, name, etc for all mods in a specified Steam Workshop collection.
- Outputs data to both stdout and a CSV file.
- Particularly useful for large Steam Workshop collections, which appear empty in the Steam client.

Notes:
- Writes to stdout and outputs a CSV file named 'modInfo.csv'.
- Performs network operations against the public Steam API.

"""

COLLECTION_API = "https://api.steampowered.com/ISteamRemoteStorage/GetCollectionDetails/v1/"
DETAILS_API = "https://api.steampowered.com/ISteamRemoteStorage/GetPublishedFileDetails/v1/"

def fetch_collection_from_api(collection_id):
    """Fetch a Steam collection from the API and extract all child publishedfileids."""
    payload = {
        "collectioncount": 1,
        "publishedfileids[0]": collection_id
    }
    
    response = requests.post(COLLECTION_API, data=payload)
    response.raise_for_status()
    data = response.json()
    
    try:
        children = data["response"]["collectiondetails"][0]["children"]
    except (KeyError, IndexError):
        raise ValueError("Invalid collection response or empty collection")
    
    ids = [int(child["publishedfileid"]) for child in children]
    return ids


def load_collection_ids(path):
    """Load a Steam collection JSON file and extract all child publishedfileids."""
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)

    try:
        children = data["response"]["collectiondetails"][0]["children"]
    except (KeyError, IndexError):
        raise ValueError("Invalid collection JSON structure")

    ids = [int(child["publishedfileid"]) for child in children]
    return ids


def fetch_workshop_details(ids):
    """Query Steam API for metadata about a list of Workshop item IDs."""
    payload = {"itemcount": len(ids)}
    for i, wid in enumerate(ids):
        payload[f"publishedfileids[{i}]"] = wid

    response = requests.post(DETAILS_API, data=payload)
    response.raise_for_status()
    return response.json()


def print_mod_info(details_json):
    """Pretty‑print mod metadata from GetPublishedFileDetails."""
    items = details_json.get("response", {}).get("publishedfiledetails", [])

    # Open CSV file for writing
    with open("modInfo.csv", "w", newline="", encoding="utf-8") as csvfile:
        fieldnames = ["ID", "Title", "Game AppID", "Tags", "URL"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for item in items:
            # Print to console
            print("--------------------------------------------------")
            print(f"ID: {item.get('publishedfileid')}")
            print(f"Title: {item.get('title')}")
            print(f"Game AppID: {item.get('consumer_app_id')}")

            tags = item.get("tags", [])
            tag_names = [t.get("tag") for t in tags]
            tags_str = ', '.join(tag_names) if tag_names else 'None'
            print(f"Tags: {tags_str}")

            url = f"https://steamcommunity.com/sharedfiles/filedetails/?id={item.get('publishedfileid')}"
            print(f"URL: {url}")
            print()

            # Write to CSV
            writer.writerow({
                "ID": item.get('publishedfileid'),
                "Title": item.get('title'),
                "Game AppID": item.get('consumer_app_id'),
                "Tags": tags_str,
                "URL": url
            })


def main():
    parser = argparse.ArgumentParser(description="Fetch Steam Workshop collection metadata and export to CSV")
    parser.add_argument(
        "collection_id",
        type=int,
        nargs="?",
        help="Steam Workshop collection ID (example: 2900785277)"
    )
    args = parser.parse_args()
    
    collection_id = args.collection_id
    ids = fetch_collection_from_api(collection_id)
    print(f"Fetched {len(ids)} workshop item IDs from collection {collection_id}")

    details = fetch_workshop_details(ids)
    print_mod_info(details)


if __name__ == "__main__":
    main()