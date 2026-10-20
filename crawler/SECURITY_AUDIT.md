# Preliminary security audit — NOT CLEARED TO ENABLE

Scope: mmsoftware100/hello-sayarwon-mobile-app, default branch main.
GitHub code search returned no matches for .github/workflows,
pull_request_target, or secrets. Code search is not an exhaustive audit
of repository history, GitHub Actions settings, organization policies,
installed apps, or past runs. No conclusion of safety is implied.

Required human/admin verification:
- Inspect all workflow files on all branches and Git history for injected workflows.
- Review GitHub Actions run history and organization audit logs.
- Confirm previously exposed PATs/secrets were revoked and rotated.
- Confirm repository Actions settings, allowed actions, token defaults,
  branch protection, and collaborator access.
- Verify content licensing and permission for bulk redistribution.
- Review crawler request rate and output size before enabling scheduled runs.
- Require protected main branch and review before merging this draft PR.

Implementation guardrails: no third-party actions; no PR-based execution;
manual trigger only; job-scoped contents:write token; no long-lived secrets;
fixed upstream hostname; retry/backoff; minimum one-second delay.

Do not merge or enable this workflow until the above checks pass.
