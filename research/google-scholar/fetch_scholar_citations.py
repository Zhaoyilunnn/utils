"""
Usage:
    python fetch_scholar_citations.py

Dependencies:
    pip install google-search-results pandas

Environment Variables:
    SERPAPI_API_KEY: Your SerpApi key. Alternatively, place it in 'api_key.txt'
                     in the same directory as this script.

Description:
    Fetches Google Scholar citations for papers listed in 'papers.txt'.
    Outputs results to 'citations_output.csv'.
"""

from serpapi import GoogleSearch
import pandas as pd
import time
import os

# --- Configuration ---
API_KEY_FILE = os.path.join(os.path.dirname(__file__), "api_key.txt")
PAPERS_FILE = os.path.join(os.path.dirname(__file__), "papers.txt")


def load_api_key():
    # Priority: 1. Environment variable 2. api_key.txt file
    env_key = os.environ.get("SERPAPI_API_KEY")
    if env_key:
        return env_key

    if os.path.exists(API_KEY_FILE):
        with open(API_KEY_FILE, "r") as f:
            return f.read().strip()
    return None


def load_papers():
    if os.path.exists(PAPERS_FILE):
        with open(PAPERS_FILE, "r") as f:
            return [line.strip() for line in f if line.strip()]
    return []


def get_citations_from_serpapi(paper_titles, api_key):
    results_data = []

    for title in paper_titles:
        print(f"Processing: {title}")

        # 1. Search for target paper to get 'cites_id'
        query = f'"{title}"'
        try:
            search = GoogleSearch(
                {"engine": "google_scholar", "q": query, "api_key": api_key}
            )
            results = search.get_dict()
        except Exception as e:
            print(f"  Error: Network request failed - {str(e)}")
            continue

        if "error" in results:
            print(f"  API Error: {results.get('error')}")
            continue

        organic_results = results.get("organic_results", [])
        if not organic_results:
            print("  Note: No exact match found. Retrying without quotes...")
            try:
                search = GoogleSearch(
                    {"engine": "google_scholar", "q": title, "api_key": api_key}
                )
                results = search.get_dict()
                organic_results = results.get("organic_results", [])
            except Exception as e:
                print(f"  Error: Retry search failed - {str(e)}")

        if not organic_results:
            print("  Note: No matching results found.")
            results_data.append(
                {"paper": title, "cite number": 0, "citation": "Paper Not Found"}
            )
            continue

        # Find best match (check top 3)
        target_pub = None
        for res in organic_results[:3]:
            res_title = res.get("title", "").lower()
            if title.lower() in res_title or res_title in title.lower():
                target_pub = res
                break

        if not target_pub:
            target_pub = organic_results[0]
            print(f"  Warning: No exact match found, using: {target_pub.get('title')}")

        inline_links = target_pub.get("inline_links", {})
        cited_by_info = inline_links.get("cited_by", {})

        cites_id = cited_by_info.get("cites_id", "")
        cite_count = cited_by_info.get("total", 0)

        # 2. Fetch citation list with pagination
        if cites_id and cite_count > 0:
            print(f"  Found {cite_count} citations, fetching list...")
            start = 0
            is_first_row = True

            while start < cite_count:
                try:
                    cite_search = GoogleSearch(
                        {
                            "engine": "google_scholar",
                            "cites": cites_id,
                            "api_key": api_key,
                            "start": start,
                            "num": 20,
                        }
                    )
                    cite_results = cite_search.get_dict()
                except Exception as e:
                    print(
                        f"  Error: Failed to fetch citations (start={start}) - {str(e)}"
                    )
                    break

                if "error" in cite_results:
                    print(f"  API Error (citations): {cite_results.get('error')}")
                    break

                citations = cite_results.get("organic_results", [])
                if not citations:
                    break

                for cite in citations:
                    results_data.append(
                        {
                            "paper": title if is_first_row else "",
                            "cite number": cite_count if is_first_row else "",
                            "citation": cite.get("title", "No Title"),
                            "authors": cite.get("publication_info", {}).get(
                                "summary", ""
                            ),
                        }
                    )
                    is_first_row = False

                start += 20
                if start >= 500:
                    print("  Note: Reached limit of 500 citations.")
                    break
                time.sleep(0.5)
        else:
            print("  Note: 0 citations found.")
            results_data.append(
                {"paper": title, "cite number": 0, "citation": "No Citations"}
            )

        time.sleep(1)

    return pd.DataFrame(results_data)


# --- Execution ---
if __name__ == "__main__":
    my_papers = load_papers()
    if not my_papers:
        print(f"Error: No paper titles found in {PAPERS_FILE}.")
        exit(1)

    API_KEY = load_api_key()
    if not API_KEY:
        print(
            "Error: API_KEY not found. Set SERPAPI_API_KEY env var or check api_key.txt."
        )
        exit(1)

    df = get_citations_from_serpapi(my_papers, API_KEY)
    df.to_csv("citations_output.csv", index=False, encoding="utf-8-sig")
    print("\nDone! Results saved to citations_output.csv")
