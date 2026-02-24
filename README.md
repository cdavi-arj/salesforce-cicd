# CI/CD for Org Development Model

This project demonstrates how to use GitHub Actions for CI/CD in an Org Development Model using Salesforce DX (no unlocked packages, no scratch orgs).

We use a QA sandbox as integration environment and GitHub Actions to automate validation, testing, static analysis and deployment.

---

## High Level Flow

**1-** The `master` branch represents the production metadata.

**2-** At the beginning of a sprint, we create a `develop` branch from `master`.

**3-** Developers clone the repository and authorize the project against their own sandbox (one-time step).

**4-** Developers create feature branches from `develop`.

**5-** Developers push commits to their feature branch.

**6-** A Pull Request is opened from the feature branch into `develop`.

**7-** The PR triggers a CI job that:
- Generates delta metadata
- Performs a check-only deployment to QA sandbox
- Runs Apex tests
- Runs static code analysis

**8-** If CI passes, the branch can be merged into `develop`.

**9-** Merge into `develop` triggers a real deployment into QA.

**10-** At the end of the sprint, `develop` is merged into `master`, triggering a production deployment.
