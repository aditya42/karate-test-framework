# Contributing

1. Create a feature branch from `development`.
2. Add or update feature files under `src/test/java/features`.
3. Reuse configuration, headers and utilities instead of duplicating them.
4. Tag tests with one or more suite tags such as `@api`, `@smoke`, `@regression`, `@ui` or `@graphql`.
5. Keep destructive or environment-sensitive examples behind `@ignore` until explicitly enabled.
6. Run `mvn clean test -Dkarate.env=qa` before opening a pull request.
7. Never commit secrets, credentials, access tokens or production test data.
