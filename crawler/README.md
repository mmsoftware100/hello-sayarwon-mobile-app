# Hello Sayarwon JSON crawler

Archives public API responses from https://wp.hellosayarwon.com/wp-json/api.
No authentication, bypasses, or personal data extraction. Requires permission to
redistribute the upstream content; respect site terms and copyright.

## Run
```bash
python3 crawler/crawl.py --max-pages 2000 --delay 2
```

Output: `data/hello-sayarwon/raw/{articles,categories,article-details,category-details}/`,
index files, and state files. Re-running resumes listing pagination and skips
already downloaded details. To refresh an existing archive, reset its state
and remove stale detail files intentionally.

## Security deployment gate
Workflow is intentionally **manual-only** (workflow_dispatch). It must remain
on a draft PR until organization/repository Actions policy, audit logs, past
compromised workflow history, credentials, branch protection, and content
redistribution rights are reviewed. Rotate any previously exposed tokens.

After approval, a maintainer can add:
```yaml
  schedule:
    - cron: '17 2 * * *'
```
under `on:` on the protected default branch. Do not add external actions,
long-lived secrets, or untrusted PR triggers. The job uses a short-lived
GITHUB_TOKEN with write access only for committing the archive.

Note: GitHub-hosted runner duration, repo size, upstream pagination behavior,
and quota may constrain a full crawl. Initial crawl can require multiple runs.
The crawler intentionally fails on unexpected response shapes rather than
silently claiming completion. HTTP 429 and 5xx are retried with backoff.
