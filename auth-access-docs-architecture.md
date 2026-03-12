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

Based on the patterns across all four platforms, the canonical information architecture for auth & access management documentation can be distilled into the following **seven pillars**:

```
Auth & Access Management
│
├── 1. OVERVIEW & CONCEPTS
│   ├── Access management overview / landing page
│   ├── Key concepts (identity, authentication, authorization)
│   └── Architecture / how it all fits together
│
├── 2. IDENTITY MANAGEMENT (Who)
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
├── 3. AUTHENTICATION (How users prove identity)
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
├── 4. AUTOMATED PROVISIONING (How users are synced)
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

| Dimension | Datadog | New Relic | Dynatrace | Splunk |
|---|---|---|---|---|
| **Top-level section** | Account Management | Accounts & Billing | Manage | Administer / Security |
| **URL convention** | Underscores (`account_management`) | Kebab-case (`new-relic-one-user-management`) | Kebab-case (`identity-access-management`) | Mixed (path-based segments) |
| **Hierarchy depth** | 2-3 levels | 3-4 levels | 4-5 levels | 2-3 levels |
| **Auth model** | RBAC | RBAC + User Types | ABAC (modern) + RBAC (legacy) | RBAC + Capabilities |
| **IdP-specific guides** | Under SAML section | Under Automated User Mgmt | Under `/idp-specific/` subfolder | Under SSO section |
| **Service accounts** | Under Org Settings | Not a distinct concept | Under Identity Mgmt ("service users") | Not a distinct concept (Obs Cloud) |
| **Concepts vs procedural split** | Mixed in same pages | Separate pages | Strict separation (`-concepts` suffix) | Mostly mixed |
| **Audit docs placement** | Under Account Mgmt | Separate event type (NrAuditEvent) | Under Data Privacy & Security | Under Security section |
| **Tokens/API keys** | Peer section to RBAC | Under APIs section | Dedicated pillar under IAM | Dedicated section under Auth |
| **Multi-org/multi-account** | Dedicated section | Under Account Structure | Under Account Mgmt | Centralized RBAC bridges products |
| **Use-case tutorials** | Audit trail guides | Tutorial page | Dedicated `/use-cases/` section | Examples/tutorials section |
| **Migration content** | N/A | Implied (old vs new user model) | Explicit migration guide | N/A |
| **Dual/legacy paths** | No | Yes (old vs new user model) | Yes (RBAC vs ABAC paths) | Yes (Enterprise vs Obs Cloud) |

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
├── Identity Management
│   ├── Users
│   ├── Groups
│   ├── Service Accounts
│   ├── Teams
│   └── Organizations / Multi-Org
│
├── Authentication
│   ├── Login Methods Overview
│   ├── Multi-Factor Authentication
│   ├── SSO / SAML
│   │   ├── Configuration
│   │   └── IdP Guides (Okta, Azure, Google, ...)
│   ├── OIDC (if supported)
│   └── LDAP (if supported)
│
├── User Provisioning
│   ├── SCIM Overview
│   ├── Configuration
│   ├── IdP-Specific Guides
│   └── SCIM API Reference
│
├── Roles & Permissions
│   ├── Access Control Overview
│   ├── Built-in Roles
│   ├── Custom Roles
│   ├── Permissions Reference
│   ├── Policies (ABAC, if supported)
│   └── Granular Access Control
│
├── API Keys & Tokens
│   ├── Overview
│   ├── Organization / Ingest Keys
│   ├── User / Application Keys
│   ├── OAuth Clients
│   └── Token Management (rotation, scoping, expiration)
│
├── Audit & Compliance
│   ├── Audit Trail
│   ├── Querying Audit Logs
│   └── Security Best Practices
│
└── Guides & Tutorials
    ├── Getting Started with Access Control
    ├── Common Use Cases
    └── Migration Guides
```

This structure balances the strengths observed across all four platforms: Dynatrace's clean conceptual separation, Datadog's flat navigability, New Relic's thorough user-type modeling, and Splunk's practical auth-scheme-centric organization.
