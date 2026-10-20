#!/usr/bin/env python3
"""Polite, resumable public API JSON archiver. Python standard library only."""
import argparse
import json
import os
import pathlib
import random
import re
import time
import urllib.error
import urllib.parse
import urllib.request

BASE = "https://wp.hellosayarwon.com/wp-json/api"
ROOT = pathlib.Path("data/hello-sayarwon")
UA = "HelloSayarwonArchive/1.0 (public API archival; contact repository owner)"
def save(path, obj):
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(".tmp")
    tmp.write_text(json.dumps(obj, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    tmp.replace(path)
def load(path, fallback):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return fallback
def request(path, params=None):
    url = BASE + path
    if params:
        url += "?" + urllib.parse.urlencode(params)
    for attempt in range(5):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept": "application/json"})
            with urllib.request.urlopen(req, timeout=30) as resp:
                if resp.status != 200:
                    raise RuntimeError("HTTP " + str(resp.status))
                return json.load(resp)
        except urllib.error.HTTPError as exc:
            if exc.code in (401, 403, 404):
                raise RuntimeError(f"Access denied or missing ({exc.code}): {path}") from exc
            if exc.code == 429 or exc.code >= 500:
                pause = min(120, 2 ** attempt * 5 + random.random())
                print(f"HTTP {exc.code}, waiting {pause:.1f}s")
                time.sleep(pause)
                continue
            raise
        except (urllib.error.URLError, TimeoutError):
            time.sleep(2 ** attempt * 5 + random.random())
    raise RuntimeError("Retry limit reached: " + path)
def slug(value):
    value = str(value).strip().strip("/")
    return re.sub(r"[^a-zA-Z0-9_-]", "_", value)[:160] or "unknown"
def crawl_collection(name, path, key, max_pages, delay):
    state_path = ROOT / "state" / (name + ".json")
    state = load(state_path, {"next_page": 1, "completed": False})
    if state.get("completed"):
        print(name, "already complete")
        return
    page = int(state["next_page"])
    while page <= max_pages:
        result = request(path, {"page": page})
        items = result.get("data", {}).get(key, []) if key else result.get("data", [])
        if not isinstance(items, list):
            raise RuntimeError(f"Unexpected {name} response structure on page {page}")
        save(ROOT / "raw" / name / f"page-{page:05d}.json", result)
        print(name, page, len(items))
        if not items:
            save(state_path, {"next_page": page, "completed": True})
            return
        save(state_path, {"next_page": page + 1, "completed": False})
        page += 1
        time.sleep(delay)
    print(name, "stopped at max-pages safety limit")
def details(name, singular, collection, key, delay):
    records = {}
    for file in sorted((ROOT / "raw" / collection).glob("page-*.json")):
        payload = load(file, {})
        data = payload.get("data", {})
        items = data.get(key, []) if key else data
        for item in items:
            if isinstance(item, dict):
                permalink = item.get("permalink")
                if permalink:
                    records[str(permalink)] = item
    save(ROOT / (name + "-index.json"), list(records.values()))
    for idx, permalink in enumerate(sorted(records)):
        output = ROOT / "raw" / name / (slug(permalink) + ".json")
        if output.exists():
            continue
        encoded = urllib.parse.quote(permalink.strip("/"), safe="/")
        try:
            save(output, request("/" + singular + "/" + encoded))
        except RuntimeError as exc:
            print("SKIP", permalink, exc)
            continue
        if idx % 20 == 0:
            print(name, idx, "/", len(records))
        time.sleep(delay)
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-pages", type=int, default=2000)
    parser.add_argument("--delay", type=float, default=2.0)
    args = parser.parse_args()
    if args.max_pages < 1 or args.delay < 1:
        parser.error("max-pages must be >=1 and delay >=1 second")
    crawl_collection("articles", "/articles", "posts", args.max_pages, args.delay)
    crawl_collection("categories", "/categories", None, args.max_pages, args.delay)
    details("article-details", "article", "articles", "posts", args.delay)
    details("category-details", "category", "categories", None, args.delay)
if __name__ == "__main__":
    main()
