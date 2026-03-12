# Auth & Access Management Documentation: Information Architecture Analysis

## Platforms Analyzed

- **Datadog** (docs.datadoghq.com)
- **New Relic** (docs.newrelic.com)
- **Dynatrace** (docs.dynatrace.com)
- **Splunk** (docs.splunk.com / help.splunk.com — Enterprise/Cloud Platform + Observability Cloud)

---

## 1. Per-Platform Documentation Structures

### 1.1 Datadog

All auth/access docs live under a single **Account Management** top-level section (`/account_management/`).

```
account_management/
├── (overview)                              # Account Management landing page
├── api-app-keys/                           # API and Application Keys
│   └── (authorization scopes)
├── rbac/                                   # Access Control (RBAC)
│   ├── permissions/                        # Role Permissions reference
│   ├── (custom roles)
│   └── (granular access control)
├── saml/                                   # SAML Single Sign-On
│   ├── configuration/                      # SAML Configuration guide
│   ├── (IdP-specific guides)               # Okta, Azure AD, Google, Auth0, etc.
│   └── (group mappings)
├── scim/                                   # User Provisioning with SCIM
├── login_methods/                          # Configuring Login Methods
├── multi_organization/                     # Managing Multiple-Organization Accounts
├── teams/                                  # Teams
├── org_settings/                           # Organization Settings
│   └── service_accounts/                   # Service Accounts
├── audit_trail/                            # Audit Trail
│   └── guides/                             # Audit Trail guides
│       └── track_monitor_access_and_configuration_changes/
├── guide/
│   └── secure-configuration/               # Recommended Secure Configuration
├── (billing)                               # Plan & Usage / Billing
├── (MFA)                                   # Multi-Factor Authentication
└── (OAuth)                                 # OAuth Apps
```

**Key characteristics:**
- Flat-ish hierarchy under a single parent section
- URL slugs use underscores (`account_management`, `api-app-keys`)
- Mixes conceptual, procedural, and reference content within the same pages
- RBAC and SAML are peer sections rather than nested under a shared "Access Control" parent
- Service Accounts are nested under Organization Settings
- Audit Trail has its own sub-section with guided use-case pages

---

### 1.2 New Relic

Auth/access docs are spread across two main URL trees under **Accounts & Billing**.

```
accounts/
├── accounts-billing/
│   ├── account-structure/
│   │   └── new-relic-account-structure     # Organization and account structure (conceptual)
│   │
│   └── new-relic-one-user-management/      # User Management section
│       ├── introduction-managing-users     # Introduction to user management (conceptual)
│       ├── user-management-concepts        # Important user and access management concepts (conceptual)
│       ├── user-management-ui-and-tasks    # User management UI and common tasks (procedural)
│       ├── user-permissions                # User permissions reference
│       ├── user-type                       # User types: basic, core, full platform
│       ├── introduction-saml-scim          # Get started with SAML SSO and/or SCIM (procedural)
│       ├── authentication-domains-saml-sso-scim-more  # Authentication domains (conceptual + procedural)
│       └── tutorial-add-new-user-groups-roles  # Tutorial: managing accounts & user access (tutorial)
│
├── accounts/
│   ├── automated-user-management/          # Automated User Management (SCIM)
│   │   ├── automated-user-provisioning-single-sign  # Introduction to AUM (conceptual)
│   │   ├── roles-permissions-automated-user-management  # How IdP groups map to NR groups
│   │   ├── scim-support-automated-user-management  # SCIM API reference
│   │   ├── onelogin-scimsso-application-configuration  # OneLogin config guide
│   │   ├── okta-scimsso-application-configuration     # Okta config guide
│   │   └── azure-ad-scimsso-application-configuration # Azure AD config guide
│   │
│   └── account-maintenance/
│       └── query-account-audit-logs-nrauditevent  # NrAuditEvent: Query account audit logs
│
└── apis/
    ├── rest-api-v2/requirements/api-keys   # API keys reference
    └── nerdgraph/examples/
        ├── nerdgraph-manage-users          # NerdGraph: Create and manage users (API tutorial)
        └── use-nerdgraph-manage-license-keys-user-keys  # NerdGraph: Manage API keys (API tutorial)
```

**Key characteristics:**
- Two-tier URL structure with some nesting inconsistency (`accounts/accounts-billing/` and `accounts/accounts/`)
- Clear separation of conceptual docs (concepts, introductions) from procedural (UI tasks, tutorials) and reference (permissions)
- Authentication domains as a unifying concept governing provisioning method, auth method, and session settings
- Three user types (basic, core, full platform) as a separate access dimension from RBAC
- IdP-specific guides nested under automated user management
- Audit via NRQL event type (`NrAuditEvent`) rather than a standalone audit section
- API management docs live under `/apis/` rather than under the user management tree

---

### 1.3 Dynatrace

Auth/access docs are organized under **Manage** with a modern IAM path and a legacy path running in parallel.

```
manage/
├── identity-access-management/             # Modern IAM (ABAC-based)
│   ├── iam-concepts                        # IAM Overview (conceptual)
│   │
│   ├── user-and-group-management/          # "Identity management" pillar
│   │   ├── identity-concepts              # Identity management concepts (conceptual)
│   │   ├── access-user-management         # User management (procedural)
│   │   ├── access-group-management        # Group management (procedural)
│   │   ├── access-service-users           # Service users (procedural + conceptual)
│   │   ├── access-mfa/                    # Multi-factor authentication
│   │   │   └── user-mfa                   # MFA TOTP setup (how-to)
│   │   ├── sign-in-with-microsoft         # Sign in with Microsoft / OIDC (procedural)
│   │   ├── access-saml/                   # SAML federation
│   │   │   ├── federation-concepts        # Federation concepts (conceptual)
│   │   │   ├── saml-configurations        # SAML configurations (procedural)
│   │   │   ├── saml-federation-models     # Federation use cases (conceptual)
│   │   │   └── idp-specific/             # IdP-specific guides
│   │   │       ├── saml-okta
│   │   │       ├── saml-azure
│   │   │       ├── saml-adfs
│   │   │       └── saml-google
│   │   └── access-scim/                   # SCIM provisioning
│   │       ├── scim-azure
│   │       └── scim-okta
│   │
│   ├── permission-management/              # "Access management" pillar
│   │   ├── access-concepts                # Access management concepts (conceptual)
│   │   ├── role-based-permissions         # Legacy RBAC permissions (reference)
│   │   ├── default-policies               # Default policies reference
│   │   └── manage-user-permissions-policies/
│   │       ├── iam-policy-mgt            # Manage IAM policies (procedural)
│   │       ├── iam-policystatement-syntax # Policy statement syntax (reference + examples)
│   │       ├── iam-policy-boundaries     # Policy boundaries (conceptual + procedural)
│   │       └── advanced/
│   │           ├── iam-policystatements  # Full permissions reference
│   │           ├── iam-policy-templating # Policy templating
│   │           └── migrate-roles         # RBAC-to-ABAC migration guide
│   │
│   ├── access-tokens-and-oauth-clients/    # "Tokens & OAuth" pillar
│   │   ├── token-concepts                 # Token concepts (conceptual)
│   │   ├── platform-tokens               # Platform tokens (procedural)
│   │   └── oauth-clients                 # OAuth clients (procedural)
│   │
│   └── use-cases/                          # Goal-oriented tutorials
│       ├── access-platform               # Grant access to Dynatrace
│       ├── access-security-context       # Grant access with security context
│       └── access-settings               # Grant access to Settings
│
├── access-control/                         # Legacy/Classic path
│   ├── access-tokens/
│   │   └── personal-access-token
│   └── user-management-and-sso/
│       ├── manage-users-and-groups-with-saml/
│       └── manage-users-and-groups-with-scim/
│
├── account-management/                     # Account-level admin portal
│   └── identity-access-management/
│       └── oauth                          # Account Management OAuth
│
└── data-privacy-and-security/              # Audit logs live here
    └── configuration/
        ├── audit-logs                     # Audit logs via API
        └── audit-logs-grail               # Audit logs on Grail

dynatrace-api/
└── account-management-api/                 # API reference mirrors UI structure
    ├── user-management-api/
    ├── group-management-api/
    ├── policy-management-api/
    ├── permission-management-api/
    ├── service-user-management-api/
    ├── platform-tokens-api/
    └── environment-management-api/
```

**Key characteristics:**
- Three-pillar architecture: Identity (who) / Access (what permissions) / Tokens (how to authenticate)
- Every major section has a dedicated `-concepts` page as the conceptual entry point
- Explicit separation of content types: concepts, procedural, reference, use-cases, migration guides
- Modern (ABAC) and legacy (RBAC) paths coexist under different URL trees
- IdP-specific guides nested under `/idp-specific/` with `saml-{provider}` and `scim-{provider}` naming
- Audit logs placed under Data Privacy & Security, not under IAM
- API reference docs structurally mirror the UI management docs
- Use-cases section provides cross-cutting goal-oriented tutorials

---

### 1.4 Splunk

Auth/access docs are split across two products with different documentation structures.

#### Splunk Enterprise / Cloud Platform

Docs live under **Administer > Manage Users and Security** (`/Security/`).

```
Security/ (Manage Users and Security)
├── About user authentication                    # Authentication overview (conceptual)
├── Manage Splunk platform users and roles/      # User & role management
│   ├── About configuring role-based user access # RBAC overview (conceptual)
│   ├── Create and manage users with Splunk Web  # User management (procedural)
│   └── About users and roles                    # Users and roles concepts
│
├── Use LDAP as an authentication scheme/        # LDAP authentication
│   ├── LDAP prerequisites and considerations
│   ├── Manage Splunk user roles with LDAP
│   └── (advanced LDAP configuration)
│       ├── Map LDAP groups to Splunk roles using config files
│       └── Configure LDAP using configuration files
│
├── Use SAML as an authentication scheme for SSO/ # SAML/SSO
│   ├── How SAML SSO works                       # SAML concepts
│   ├── Configure single sign-on with SAML
│   ├── Configure SAML SSO using configuration files
│   ├── Best practices for using SAML
│   └── Secure SSO with TLS certificates
│
├── Perform advanced user and role management/    # Advanced config
│   ├── Define roles with capabilities            # Capabilities reference
│   └── Create and manage roles using authorize.conf
│
└── (Audit)                                       # Audit features
    └── Audit trail and logging
```

#### Splunk Observability Cloud

Docs live under **Administer > Authentication and Security**.

```
admin/
├── authentication-and-security/                  # Auth & security landing
│   ├── maintain-a-secure-organization            # Security overview (conceptual)
│   │
│   ├── authentication-tokens/                    # Tokens section
│   │   ├── tokens                               # Authentication tokens overview
│   │   ├── org-tokens                           # Organization access tokens (procedural)
│   │   ├── api-access-tokens                    # User API access tokens (procedural)
│   │   └── manage-usage-with-access-tokens      # Manage usage with tokens (procedural)
│   │
│   ├── single-sign-on/                           # SSO section
│   │   ├── configure-sso-integrations           # SSO integrations overview
│   │   ├── sso-GeneralSAML                      # Generic SAML SSO config
│   │   ├── (sso-ADFS)                           # ADFS SSO config
│   │   ├── (sso-AzureAD)                        # Azure AD / Entra ID SSO config
│   │   └── (sso-Google)                         # Google SSO config
│   │
│   └── (audit)                                   # Audit features
│
├── user-management/                              # User management section
│   ├── roles/                                    # Roles section
│   │   ├── roles-and-capabilities-about         # About roles (conceptual)
│   │   └── roles-and-capabilities-table         # Roles & capabilities matrix (reference)
│   │
│   └── teams/                                    # Teams section
│       └── enhanced-team-security               # Enhanced team security (procedural)
│
└── splunkplatform/
    └── centralized-rbac                          # Centralized user and role management
```

**Key characteristics:**
- Two distinct documentation trees for two products (Enterprise/Cloud vs Observability Cloud)
- Enterprise uses a "security manual" metaphor: auth scheme-centric organization (LDAP, SAML as separate sections)
- Observability Cloud uses a more modern structure: authentication-and-security + user-management
- Enterprise emphasizes configuration files (`authorize.conf`) alongside UI-based management
- Observability Cloud has four built-in roles (Admin, Power, Usage, Read-only) vs Enterprise's open-ended capability model
- Centralized RBAC page bridges the two product lines
- Tokens in Observability Cloud are a first-class section (org tokens vs API tokens)

---

## 2. Cross-Platform Information Architecture: Synthesized Model

Based on the patterns across all four platforms, the canonical information architecture for auth & access management documentation can be distilled into the following **seven pillars**, ordered to match the runtime flow a user experiences (authenticate first, then be identified, then be authorized):

```
Auth & Access Management
│
├── 1. OVERVIEW & CONCEPTS
│   ├── Access management overview / landing page
│   ├── Key concepts (identity, authentication, authorization)
│   └── Architecture / how it all fits together
│
├── 2. AUTHENTICATION (How users prove identity — the front door)
│   ├── Authentication overview / login methods
│   ├── Username & Password
│   ├── Multi-Factor Authentication (MFA/2FA)
│   ├── Single Sign-On (SSO)
│   │   ├── SAML SSO
│   │   │   ├── SAML concepts / how it works
│   │   │   ├── SAML configuration (procedural)
│   │   │   └── IdP-specific guides
│   │   │       ├── Okta
│   │   │       ├── Azure AD / Entra ID
│   │   │       ├── Google Workspace
│   │   │       ├── OneLogin
│   │   │       ├── AD FS
│   │   │       └── (others)
│   │   └── OIDC (where supported)
│   ├── LDAP (where supported)
│   └── Authentication Domains / Settings
│       └── Session management, user type upgrades, provisioning method
│
├── 3. IDENTITY MANAGEMENT (Who exists in the system)
│   ├── Users
│   │   ├── User concepts (user types, lifecycle)
│   │   ├── Add / invite / manage users (procedural)
│   │   └── User provisioning methods
│   ├── Groups
│   │   ├── Group concepts
│   │   └── Create / manage groups (procedural)
│   ├── Service Accounts / Service Users
│   │   └── Create / manage service accounts (procedural)
│   ├── Teams / Organizational Units
│   │   └── Create / manage teams (procedural)
│   └── Organizations & Multi-Org
│       ├── Organization structure concepts
│       └── Multi-organization management (procedural)
│
├── 4. AUTOMATED PROVISIONING (How identities are synced at scale)
│   ├── SCIM overview / concepts
│   ├── SCIM configuration (procedural)
│   ├── IdP-specific SCIM guides
│   │   ├── Okta SCIM
│   │   ├── Azure AD SCIM
│   │   └── OneLogin SCIM
│   ├── SAML group mappings / attribute mappings
│   └── SCIM API reference
│
├── 5. AUTHORIZATION & PERMISSIONS (What users can do)
│   ├── Access control overview / concepts
│   ├── Roles
│   │   ├── Default / built-in roles
│   │   ├── Custom roles
│   │   └── Role management (procedural)
│   ├── Permissions / Capabilities
│   │   └── Permissions reference (full matrix)
│   ├── Policies (where supported — ABAC)
│   │   ├── Policy concepts
│   │   ├── Policy syntax / reference
│   │   └── Policy management (procedural)
│   ├── Access Grants / Assignments
│   │   └── Linking groups → roles → targets
│   └── Granular / Resource-Level Access Control
│
├── 6. API & PROGRAMMATIC ACCESS (Machine identity)
│   ├── API Keys / Tokens overview
│   ├── API keys (org-level / ingest keys)
│   ├── Application / User keys
│   ├── Access tokens (session / bearer tokens)
│   ├── OAuth clients / apps
│   ├── Authorization scopes
│   └── Token management (rotation, expiration, revocation)
│
├── 7. AUDIT & COMPLIANCE
│   ├── Audit trail / audit logs overview
│   ├── Querying audit events
│   ├── Audit log use-case guides
│   └── Security best practices / secure configuration
│
└── SUPPLEMENTARY
    ├── Migration guides (e.g., RBAC → ABAC, old model → new model)
    ├── Tutorials / use-case walkthroughs
    ├── Troubleshooting
    └── API reference (mirrors UI management structure)
```

---

## 3. Comparative Matrix

| Dimension | Datadog | New Relic | Dynatrace | Splunk | **Grafana** |
|---|---|---|---|---|---|
| **Top-level section** | Account Management | Accounts & Billing | Manage | Administer / Security | **Configure Security + Administration** (split) |
| **URL convention** | Underscores (`account_management`) | Kebab-case (`new-relic-one-user-management`) | Kebab-case (`identity-access-management`) | Mixed (path-based segments) | **Kebab-case (`configure-authentication`)** |
| **Hierarchy depth** | 2-3 levels | 3-4 levels | 4-5 levels | 2-3 levels | **2-4 levels** |
| **Auth model** | RBAC | RBAC + User Types | ABAC (modern) + RBAC (legacy) | RBAC + Capabilities | **Basic roles + RBAC (Enterprise)** |
| **IdP-specific guides** | Under SAML section | Under Automated User Mgmt | Under `/idp-specific/` subfolder | Under SSO section | **Under SAML + under SCIM** |
| **Service accounts** | Under Org Settings | Not a distinct concept | Under Identity Mgmt ("service users") | Not a distinct concept (Obs Cloud) | **Under Administration (dedicated section)** |
| **Concepts vs procedural split** | Mixed in same pages | Separate pages | Strict separation (`-concepts` suffix) | Mostly mixed | **Mostly procedural; few concept pages** |
| **Audit docs placement** | Under Account Mgmt | Separate event type (NrAuditEvent) | Under Data Privacy & Security | Under Security section | **Under Configure Security (single page)** |
| **Tokens/API keys** | Peer section to RBAC | Under APIs section | Dedicated pillar under IAM | Dedicated section under Auth | **Service account tokens + Access Policies (Cloud)** |
| **Multi-org/multi-account** | Dedicated section | Under Account Structure | Under Account Mgmt | Centralized RBAC bridges products | **Under Administration (org management)** |
| **Use-case tutorials** | Audit trail guides | Tutorial page | Dedicated `/use-cases/` section | Examples/tutorials section | **RBAC rollout strategy guide only** |
| **Migration content** | N/A | Implied (old vs new user model) | Explicit migration guide | N/A | **API keys → service accounts** |
| **Dual/legacy paths** | No | Yes (old vs new user model) | Yes (RBAC vs ABAC paths) | Yes (Enterprise vs Obs Cloud) | **Yes (OSS/Enterprise vs Cloud)** |

---

## 4. Content Type Taxonomy

All four platforms use variations of these content types, though with different levels of explicit separation:

| Content Type | Description | Best Practice (from Dynatrace) |
|---|---|---|
| **Concepts** | Explains what something is and why it matters. No step-by-step instructions. | Dedicated pages with `-concepts` suffix |
| **Procedural / How-To** | Step-by-step instructions for completing a task. | Named with action verbs (`access-`, `configure-`, `manage-`) |
| **Reference** | Exhaustive listings of permissions, policy syntax, API endpoints, capabilities. | Standalone pages or tables |
| **Tutorial / Use-Case** | Goal-oriented walkthroughs that cross multiple concepts. | Grouped under `/use-cases/` or `/guides/` |
| **Migration Guide** | Transitioning between models or versions. | Under `/advanced/` or as standalone guides |
| **IdP-Specific Guide** | Vendor-specific configuration for identity providers (Okta, Azure, Google, etc.). | Under `/idp-specific/` with `{protocol}-{provider}` naming |
| **API Reference** | Programmatic management endpoints mirroring UI structure. | Separate API docs tree that mirrors the management sections |

---

## 5. Key Architectural Patterns & Recommendations

### Pattern 1: Three-Pillar Decomposition (Identity / Authentication / Authorization)
Dynatrace demonstrates this most cleanly. Separating "who" (users, groups, service users), "how they prove identity" (SAML, OIDC, MFA), and "what they can do" (roles, permissions, policies) provides clear mental models and scalable doc structures.

### Pattern 2: Concepts-First Navigation
Every major section should have a concepts/overview page as the entry point. Dynatrace's `-concepts` suffix pattern makes this explicit and consistent. New Relic also does this well with dedicated concept pages.

### Pattern 3: IdP-Specific Guides as Leaf Nodes
All platforms place provider-specific guides (Okta, Azure, Google, etc.) as children of the relevant protocol section (SAML or SCIM). This prevents the top-level navigation from being cluttered by vendor names.

### Pattern 4: Tokens & API Access as a First-Class Section
Programmatic access (API keys, tokens, OAuth) is significant enough to warrant its own section rather than being buried under "settings." Datadog, Dynatrace, and Splunk Observability Cloud all treat this as a major section.

### Pattern 5: Audit Logs Placement Varies
- Datadog and Splunk: Under the auth/security section itself
- Dynatrace: Under Data Privacy & Security (compliance-oriented framing)
- New Relic: As a queryable event type rather than a dedicated doc section

The most common pattern is to include audit alongside auth docs, but compliance-heavy organizations may prefer the Dynatrace approach of placing it under privacy/security.

### Pattern 6: Support for Legacy + Modern Paths
Both Dynatrace and New Relic maintain parallel documentation for old and new access models. This is important during transitions but should include clear migration guides and deprecation notices.

### Pattern 7: API Docs Mirror Management Docs
Dynatrace's API reference tree structurally mirrors its management UI docs (user management API, group management API, policy management API, etc.). This makes it easy for developers to find the programmatic equivalent of any UI operation.

---

## 6. Recommended Canonical IA (Synthesized)

Based on the analysis, the recommended information architecture for an auth & access management documentation section is:

```
Auth & Access Management (top-level section)
│
├── Overview
│   └── Key concepts and architecture
│
├── Authentication                            ← first: how users prove identity
│   ├── Login Methods Overview
│   ├── Multi-Factor Authentication
│   ├── SSO / SAML
│   │   ├── Configuration
│   │   └── IdP Guides (Okta, Azure, Google, ...)
│   ├── OIDC (if supported)
│   └── LDAP (if supported)
│
├── Identity Management                       ← second: who exists in the system
│   ├── Users
│   ├── Groups
│   ├── Service Accounts
│   ├── Teams
│   └── Organizations / Multi-Org
│
├── User Provisioning                         ← third: how identities are synced at scale
│   ├── SCIM Overview
│   ├── Configuration
│   ├── IdP-Specific Guides
│   └── SCIM API Reference
│
├── Roles & Permissions                       ← fourth: what authenticated identities can do
│   ├── Access Control Overview
│   ├── Built-in Roles
│   ├── Custom Roles
│   ├── Permissions Reference
│   ├── Policies (ABAC, if supported)
│   └── Granular Access Control
│
├── API Keys & Tokens                         ← fifth: programmatic/machine authentication
│   ├── Overview
│   ├── Organization / Ingest Keys
│   ├── User / Application Keys
│   ├── OAuth Clients
│   └── Token Management (rotation, scoping, expiration)
│
├── Audit & Compliance                        ← sixth: tracking what happened
│   ├── Audit Trail
│   ├── Querying Audit Logs
│   └── Security Best Practices
│
└── Guides & Tutorials
    ├── Getting Started with Access Control
    ├── Common Use Cases
    └── Migration Guides
```

The ordering follows the runtime flow a user actually experiences: authenticate
(prove who you are), then be identified (exist in the system), then be
authorized (get permissions). This matches user mental models better than an
admin-setup ordering where identity management comes first. It also aligns with
how Splunk organizes its docs, leading with "About user authentication" before
role and user management content.

This structure balances the strengths observed across all four platforms:
Dynatrace's clean conceptual separation, Datadog's flat navigability, New
Relic's thorough user-type modeling, and Splunk's practical
auth-scheme-centric organization.

---

## 7. Grafana Current Docs vs. Recommended Canonical IA

Grafana's auth and access management content is currently split across **two doc sets** (Grafana OSS/Enterprise and Grafana Cloud) and **two top-level sections within each** (Administration and Configure Security). This section maps the current Grafana structure to the recommended canonical IA, identifies gaps, and highlights structural differences.

### 7.1 Current Grafana Documentation Structure

#### Grafana OSS / Enterprise

Auth/access content lives under two separate top-level areas:

```
setup-grafana/
└── configure-security/                          # "Configure Security" section
    ├── (overview)                               # Security overview (network, CORS, request restrictions)
    ├── configure-authentication/                # Authentication methods landing page
    │   ├── (overview / comparison table)        # Feature comparison across auth methods
    │   ├── azuread/                             # Entra ID (Azure AD) OAuth
    │   ├── okta/                                # Okta OAuth
    │   ├── generic-oauth/                       # Generic OAuth
    │   ├── github/                              # GitHub OAuth
    │   ├── gitlab/                              # GitLab OAuth
    │   ├── google/                              # Google OAuth
    │   ├── grafana-cloud/                       # Grafana.com OAuth
    │   ├── saml/                                # SAML (Enterprise)
    │   │   ├── (overview)
    │   │   ├── saml-configuration-options/      # SAML config reference
    │   │   ├── configure-saml-with-okta/        # Okta SAML guide
    │   │   ├── configure-saml-with-entra-id/    # Entra ID SAML guide
    │   │   ├── saml-ui/                         # Configure SAML via UI
    │   │   └── troubleshoot-saml/               # SAML troubleshooting
    │   ├── ldap/                                # LDAP
    │   ├── jwt/                                 # JWT Proxy
    │   ├── auth-proxy/                          # Auth Proxy
    │   ├── basic-auth/                          # Basic Auth
    │   └── passwordless/                        # Passwordless Auth
    ├── configure-scim-provisioning/             # SCIM provisioning
    │   ├── (overview)
    │   ├── configure-scim-with-okta/            # Okta SCIM guide
    │   ├── configure-scim-with-entra-id/        # Entra ID SCIM guide
    │   └── manage-users-teams/                  # Manage users and teams with SCIM
    └── audit-grafana/                           # Audit Grafana instance (Enterprise)

administration/
├── user-management/                             # User management
│   └── manage-org-users/                        # Manage users in an organization
├── team-management/                             # Team management
│   └── configure-grafana-teams/                 # Configure Grafana Teams
├── organization-management/                     # Organization management
├── service-accounts/                            # Service accounts
│   └── migrate-api-keys/                        # Migrate API keys to service account tokens
├── roles-and-permissions/                       # Roles and permissions
│   ├── (overview)                               # Roles and permissions concepts
│   └── access-control/                          # RBAC (Enterprise)
│       ├── (overview)                           # RBAC overview
│       ├── assign-rbac-roles/                   # Assign RBAC roles
│       ├── manage-rbac-roles/                   # Manage RBAC roles
│       ├── custom-role-actions-scopes/          # Permissions, actions, and scopes reference
│       ├── plan-rbac-rollout-strategy/          # Plan RBAC rollout strategy
│       ├── rbac-grafana-provisioning/           # Provision RBAC with Grafana (YAML)
│       ├── rbac-terraform-provisioning/         # Provision RBAC with Terraform
│       ├── folder-access-control/               # Folder access control
│       └── troubleshooting/                     # Troubleshoot RBAC
└── api-keys/                                    # API keys (deprecated → service accounts)
```

#### Grafana Cloud

Auth/access content lives under **Security and account management**.

```
security-and-account-management/
├── (overview)                                   # Security and account management landing
├── cloud-portal/                                # Cloud Portal management
│   └── (account overview, stacks, billing, security settings, user settings)
├── authentication-and-permissions/              # Auth & permissions section
│   ├── (overview)                               # Configure authentication and authorization
│   ├── cloud-roles/                             # Grafana Cloud user roles and permissions
│   ├── access-control/                          # RBAC
│   │   ├── (overview)                           # RBAC overview
│   │   ├── manage-rbac-roles/                   # Manage RBAC roles
│   │   └── custom-role-actions-scopes/          # Permissions reference
│   ├── access-policies/                         # Grafana Cloud Access Policies
│   │   └── using-an-access-policy-token/        # Using access policy tokens
│   └── service-accounts/                        # Service accounts
└── (configure-authentication via shared Grafana docs: SAML, LDAP, OAuth, SCIM)
```

### 7.2 Mapping: Canonical IA Pillar → Current Grafana Location

| Canonical Pillar | Grafana OSS/Enterprise Location | Grafana Cloud Location | Notes |
|---|---|---|---|
| **1. Overview** | No unified landing page | `security-and-account-management/` | OSS splits across two unrelated top-level sections |
| **2. Authentication** | `setup-grafana/configure-security/configure-authentication/` | Shared with OSS docs; Cloud Portal > Security > Advanced Auth | Well-covered; flat list of 12+ auth methods with feature comparison table |
| **2a. MFA** | Not a standalone section | Not a standalone section | MFA not prominent in Grafana docs; no dedicated page found |
| **2b. SSO / SAML** | `configure-authentication/saml/` (Enterprise) | Shared | Good sub-structure with IdP guides (Okta, Entra ID), config reference, troubleshooting |
| **2c. OAuth** | `configure-authentication/{provider}/` | Shared | Each OAuth provider is a peer page (7 providers) |
| **2d. LDAP** | `configure-authentication/ldap/` | Shared | Enhanced LDAP with active sync in Enterprise |
| **3. Identity Mgmt — Users** | `administration/user-management/` | Cloud Portal > User Settings | Minimal: "manage org users" is essentially one page |
| **3. Identity Mgmt — Groups** | No groups concept | No groups concept | Grafana uses Teams instead of groups |
| **3. Identity Mgmt — Service Accounts** | `administration/service-accounts/` | `authentication-and-permissions/service-accounts/` | Well-covered; includes migration from deprecated API keys |
| **3. Identity Mgmt — Teams** | `administration/team-management/` | Minimal | Team management docs exist but are thin |
| **3. Identity Mgmt — Organizations** | `administration/organization-management/` | Cloud Portal (stacks, not orgs in same sense) | Different models: OSS has multi-org, Cloud has stacks |
| **4. User Provisioning (SCIM)** | `configure-security/configure-scim-provisioning/` | Shared | Good structure: overview + IdP guides (Okta, Entra ID) + manage users/teams |
| **5. Roles & Permissions** | `administration/roles-and-permissions/` + `access-control/` | `authentication-and-permissions/access-control/` + `cloud-roles/` | Well-covered; basic roles (Viewer/Editor/Admin) + RBAC (Enterprise) with planning, provisioning, and troubleshooting guides |
| **5a. Granular Access** | `access-control/folder-access-control/` | N/A | Folder-based access control as primary granular mechanism |
| **6. API Keys & Tokens** | `administration/api-keys/` (deprecated) + `administration/service-accounts/` (tokens) | `authentication-and-permissions/access-policies/` | Cloud has Access Policies (scopes + realms); OSS migrating API keys → service account tokens |
| **6a. OAuth Clients** | Not a standalone section | Cloud Portal > Security > OAuth 2.0 clients | Cloud-specific feature |
| **7. Audit** | `configure-security/audit-grafana/` (Enterprise) | Not a standalone section in Cloud docs | Enterprise-only feature; single page |
| **7a. Security Best Practices** | `configure-security/` (network/CORS guidance scattered) | Cloud Portal security settings | No consolidated best practices page |
| **Guides & Tutorials** | `access-control/plan-rbac-rollout-strategy/` | N/A | Only RBAC has a planning/strategy guide |
| **Migration** | `service-accounts/migrate-api-keys/` | N/A | Only API keys → service accounts migration documented |

### 7.3 Key Structural Differences from Canonical IA

#### Split across two top-level sections (OSS/Enterprise)

Grafana's most significant structural divergence is that **authentication** lives under `setup-grafana/configure-security/` while **identity and authorization** live under `administration/`. A user looking for "how do I set up SSO and then assign roles" must navigate between two unrelated doc trees. Every other platform analyzed keeps these under a single parent.

#### No unified auth/access landing page (OSS/Enterprise)

There is no single page that introduces the entire auth and access management domain for Grafana OSS/Enterprise. Grafana Cloud has `security-and-account-management/` as a landing page, but OSS/Enterprise users land in either `configure-security/` (a setup guide framing) or `administration/` (a runtime management framing) with no bridge between them.

#### Authentication is configuration-centric, not concept-centric

Grafana's authentication docs are organized as a flat list of "configure X" pages. There is no concepts page explaining authentication in Grafana holistically (what are authentication domains, how do auth methods interact, what happens at login time). The feature comparison table on the `configure-authentication/` landing page is useful but is a reference, not a conceptual introduction.

#### No MFA documentation

Unlike Datadog, New Relic, and Dynatrace, which all have dedicated MFA pages, Grafana does not appear to have a standalone MFA/2FA documentation page. This is a coverage gap if the feature exists.

#### Teams replace Groups

Grafana uses Teams where other platforms use Groups. This is a naming difference, not a structural gap, but the team management docs are thin compared to the role they play in RBAC (teams can be assigned RBAC roles, receive team sync from IdPs, etc.).

#### Access Policies are Cloud-specific

Grafana Cloud introduces Access Policies (scopes + realms) as a distinct concept that doesn't exist in OSS/Enterprise. This creates a divergence in the API keys & tokens pillar between the two doc sets.

#### Audit is minimal

Grafana's audit documentation is a single page under `configure-security/`, available only in Enterprise. Other platforms (especially Datadog and Dynatrace) have multi-page audit sections with use-case guides and querying tutorials.

#### SCIM placement

SCIM is under `configure-security/` alongside authentication, which matches the canonical IA's "User Provisioning" pillar as a peer to authentication. This is well-positioned.

### 7.4 Recommendations for Grafana

Based on the gap analysis, these are the highest-impact structural improvements:

1. **Create a unified auth & access landing page** for Grafana OSS/Enterprise that links to both `configure-security/configure-authentication/` and `administration/roles-and-permissions/`, giving users a single entry point to the domain.

2. **Add a concepts/overview page** to `configure-authentication/` explaining Grafana's authentication model holistically: how auth methods are evaluated, what happens at login, how auth interacts with org roles, and how team sync ties IdP groups to Grafana teams.

3. **Add MFA documentation** if the feature exists, or document how MFA is handled (delegated to IdP via SAML/OAuth).

4. **Expand team management docs** to cover team sync behavior, how teams interact with RBAC roles, and team-based access patterns — since teams are Grafana's equivalent of groups.

5. **Expand audit documentation** with querying/filtering guidance, common audit use cases, and integration with Loki (which is already supported but not well-documented from a user perspective).

6. **Add a security best practices page** consolidating guidance currently scattered across `configure-security/` sub-pages (network restrictions, CORS, request security, auth method selection).

7. **Consider bridging Cloud and OSS/Enterprise token docs** since the two models (service account tokens vs. access policy tokens) serve similar purposes but are documented in completely separate trees with no cross-references.
