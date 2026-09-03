# Karate v2 Automation Framework

Framework built on **Karate 2.1.2**, **JUnit 6**, **Maven**, and **Java 21**.

It provides a scalable starting point for API automation while keeping optional UI, GraphQL, and mock examples in the same repository.

## What is included

- REST API tests: GET, POST, PUT, DELETE
- Schema / contract assertions
- CSV-driven Scenario Outlines
- Generated test data utility
- Shared headers and optional bearer-token support
- Environment configuration: `local`, `qa`, `stage`
- Tag-based smoke / regression execution
- Configurable parallel execution
- Karate HTML reports
- JUnit XML and Cucumber JSON reports
- Optional browser UI example
- Optional GraphQL example
- Optional mock-service example
- GitHub Actions CI with manual environment/tag/thread inputs
- Security and contribution guidance

## Technology baseline

| Component | Version / approach |
|---|---|
| Karate | 2.1.2 |
| Java | 21+ |
| JUnit | 6.1.2 |
| Maven Surefire | 3.5.6 |
| CI | GitHub Actions |

## Repository structure

```text
.
├── .github/workflows/karate-tests.yml
├── docs/ARCHITECTURE.md
├── pom.xml
├── src/test/java
│   ├── karate-config.js
│   ├── logback-test.xml
│   ├── com/example/karate/KarateSuiteTest.java
│   ├── features
│   │   ├── api
│   │   │   ├── posts/posts.feature
│   │   │   └── users/users.feature
│   │   ├── common
│   │   │   ├── headers.js
│   │   │   └── random-data.js
│   │   ├── graphql/countries.feature
│   │   ├── mock/users-mock.feature
│   │   └── ui/login.feature
│   └── test-data/users.csv
├── CONTRIBUTING.md
└── SECURITY.md
```

## Prerequisites

```bash
java -version   # Java 21+
mvn -version
```

## Run tests

### Default suite

```bash
mvn clean test
```

The default suite excludes tests tagged `@ignore`.

### QA environment

```bash
mvn clean test -Dkarate.env=qa
```

### Smoke tests only

```bash
mvn clean test -Dkarate.options="--tags @smoke"
```

### API tests only

```bash
mvn clean test -Dkarate.options="--tags @api"
```

### Regression tests

```bash
mvn clean test -Dkarate.options="--tags @regression"
```

### Set parallel threads

```bash
mvn clean test -Dkarate.threads=8
```

### Override an API endpoint

```bash
mvn clean test \
  -Dapi.baseUrl=https://api.qa.example.com \
  -Dkarate.env=qa
```

### Pass an API token

```bash
mvn clean test -Dapi.token="$API_TOKEN"
```

Do not commit tokens or credentials.

## Test tags

| Tag | Purpose |
|---|---|
| `@api` | REST API suite |
| `@smoke` | Critical fast checks |
| `@regression` | Broader regression suite |
| `@ui` | Browser automation |
| `@graphql` | GraphQL tests |
| `@ignore` | Disabled by default / explicit execution only |

## Add a new API domain

Create a directory under `src/test/java/features/api`, for example:

```text
features/api/orders/
├── orders.feature
└── order-schema.json
```

Use `apiBaseUrl` from `karate-config.js` and reuse the common headers:

```gherkin
Background:
  * url apiBaseUrl
  * headers call read('classpath:features/common/headers.js')
```

Avoid duplicating base URLs, tokens or common headers inside feature files.

## Environments

`karate-config.js` currently provides:

- `local`
- `qa`
- `stage`

Replace the sample URLs with your system endpoints, or supply them dynamically using `-Dapi.baseUrl` and `-Dui.baseUrl`.

A production environment is intentionally not included in the starter configuration.

## Reports

After execution, open:

```text
target/karate-reports/
```

The runner also enables JUnit XML and Cucumber JSON output for CI integrations.

## GitHub Actions

`.github/workflows/karate-tests.yml` runs on:

- pushes to `main` and `development`
- pull requests to `main` and `development`
- manual `workflow_dispatch`

Manual runs support:

- environment
- tag expression
- parallel thread count

Reports are uploaded as GitHub Actions artifacts even when tests fail.

## Optional UI execution

The UI example is tagged `@ui @ignore`. Run it explicitly only on machines / runners with Chrome available:

```bash
mvn clean test -Dkarate.options="--tags @ui"
```

## Scaling recommendations

For an enterprise repository, extend this skeleton with:

1. OAuth / service-account authentication features using `callonce`.
2. Contract schemas per API domain.
3. Test-data setup / cleanup features.
4. Separate smoke and regression GitHub workflows if execution volume grows.
5. Environment-specific secrets from GitHub Environments or your secrets manager.
6. API ownership folders aligned with services / bounded contexts.
7. Retry only for explicit asynchronous polling patterns, not broad test retries.
8. Test-management publishing using the generated JUnit XML or Cucumber JSON.

## Reference

Karate project: https://github.com/karatelabs/karate

Karate documentation: https://docs.karatelabs.io/
