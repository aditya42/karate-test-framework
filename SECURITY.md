# Security

- Do not store API keys, passwords, bearer tokens, certificates or production data in the repository.
- Pass secrets through CI secret stores or JVM system properties such as `-Dapi.token=...`.
- Keep production environments out of the default configuration unless your organization explicitly approves production testing.
- Treat Karate HTML reports as potentially sensitive because request and response bodies may be included.
