# Framework Architecture

```text
GitHub / Developer
       |
       v
 Maven + JUnit 6 Runner
       |
       v
 Karate Feature Layer
  |       |       |
 API      UI    GraphQL
  |
  +--> Shared config / headers / utilities / test data
       |
       v
 Environment endpoints
       |
       v
 HTML + JUnit XML + Cucumber JSON reports
```

## Design principles

- **Single configuration entry point:** `karate-config.js` owns environment-specific values.
- **Reusable feature utilities:** common headers and generated data are centralized.
- **Tag-driven execution:** CI can select smoke, API, regression, UI or GraphQL scopes without changing source.
- **Parallel by default:** runner thread count is configurable through `-Dkarate.threads`.
- **CI-safe defaults:** browser, GraphQL and mock examples are tagged `@ignore` and enabled explicitly.
- **No hard-coded secrets:** credentials are supplied at runtime through JVM properties / CI secrets.
