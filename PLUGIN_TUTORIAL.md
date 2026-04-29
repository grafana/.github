# Getting started with Grafana plugins

This tutorial is a practical starting point for building a Grafana plugin with the official Grafana plugin tools. It is aimed at developers who want to go from zero to a working local plugin quickly, and then understand what to build next.

## What you can build

Grafana supports three plugin types:

- **Panel plugins** add new visualizations to dashboards.
- **Data source plugins** connect Grafana to new APIs, databases, or services.
- **App plugins** package a broader experience, such as custom pages, navigation, and bundled features.

If you are unsure where to start, choose the smallest plugin type that fits your goal:

- Pick a **panel plugin** when you need a new visualization.
- Pick a **data source plugin** when you need to fetch data from somewhere new.
- Pick an **app plugin** when you need a larger product surface inside Grafana.

## Prerequisites

Before you scaffold a plugin, make sure your machine has:

- A current LTS version of **Node.js**
- **Docker** and Docker Compose
- **Go** and **Mage** if your plugin includes a backend component

The official plugin tooling will generate most of the project structure for you, including a local development environment.

## Step 1: Scaffold a new plugin

Run the official scaffolding tool:

```bash
npx @grafana/create-plugin@latest
```

The CLI will prompt you for:

- your organization name
- the plugin name
- the plugin type (`panel`, `datasource`, or `app`)
- the package manager you want to use
- whether you want a backend, when applicable

The generated plugin ID follows the standard convention:

```text
<organization>-<plugin-name>-<plugin-type>
```

For example:

```text
acme-traffic-panel
acme-weather-datasource
acme-ops-app
```

## Step 2: Install dependencies and start Grafana locally

Move into the generated directory and install dependencies:

```bash
cd <your-plugin-folder>
npm install
```

Build the frontend in watch mode:

```bash
npm run dev
```

If your plugin includes a backend, build it with the Mage target printed by the scaffold output for your platform. For example:

```bash
mage -v build:linux
```

Then start the local Grafana development environment:

```bash
docker compose up --build
```

Open Grafana at:

```text
http://localhost:3000
```

During development, you do **not** need to sign the plugin. The scaffolded Docker environment is configured to load unsigned plugins in development mode.

## Step 3: Understand the generated structure

The scaffold gives you a working baseline. The most important files are:

### `src/plugin.json`

This is the plugin manifest. Grafana uses it to discover and describe your plugin.

Key fields usually include:

- `id`: the unique plugin ID
- `type`: `panel`, `datasource`, or `app`
- `name`: the display name shown in Grafana
- `dependencies`: supported Grafana versions and plugin dependencies

### `src/module.ts`

This is the frontend entry point. It exports the plugin implementation that Grafana loads.

What it exports depends on the plugin type:

- panel plugins export a panel plugin definition
- data source plugins export a data source plugin definition
- app plugins export an app plugin definition

### `src/`

This is where most frontend work happens:

- React components
- query editors
- configuration editors
- plugin options
- styling and assets

### `pkg/`

If your plugin has a backend, Go code usually lives here.

### `docker-compose.yaml`

This starts a local Grafana instance configured for plugin development.

## Step 4: Make your first useful change

Once the scaffold is running, make one small, visible change and confirm the development loop works.

### For a panel plugin

Start by rendering something simple in the panel component, such as:

- a title
- the last value from a series
- a styled placeholder while you learn the data model

From there, move on to Grafana data frames so your panel reacts to real query results.

### For a data source plugin

Start by implementing a basic query flow:

- define the query model
- build the query editor UI
- return sample or transformed data in the expected response shape

Once that works, add authentication, configuration, and error handling.

### For an app plugin

Start by adding one page or navigation entry so you can verify the app loads correctly inside Grafana. After that, add routes, configuration pages, or embedded workflows.

## Step 5: Test the development workflow

A healthy plugin workflow usually looks like this:

1. Edit code in `src/` or `pkg/`
2. Let the frontend watcher rebuild with `npm run dev`
3. Rebuild the backend when needed with the Mage target for your platform
4. Refresh Grafana and verify the plugin behavior

As you iterate, confirm that:

- the plugin appears in the Grafana plugins UI
- Grafana loads the plugin without errors
- your change is visible and repeatable

## Step 6: Build for production

When you are ready to package the plugin, create a production build:

```bash
npm run build
```

This creates the distributable frontend assets, typically in `dist/`.

If your plugin includes a backend, make sure you also produce the backend binaries required for the target platform before distribution.

## Step 7: Sign the plugin

Grafana requires signed plugins outside local development workflows.

### Public plugins

Public plugins must be reviewed and approved before you can sign them with a public signature level. After approval, export your Grafana Access Policy token and run:

```bash
export GRAFANA_ACCESS_POLICY_TOKEN=<your-token>
npx @grafana/sign-plugin@latest
```

### Private plugins

For private distribution, include the Grafana instance root URL:

```bash
export GRAFANA_ACCESS_POLICY_TOKEN=<your-token>
npx @grafana/sign-plugin@latest --rootUrls https://example.com/grafana
```

Signing adds a `MANIFEST.txt` file to the build output so Grafana can verify the plugin.

## Step 8: Publish or share it

After building and signing:

- publish publicly through the Grafana plugin review and catalog process, or
- distribute privately to the Grafana instances that should load the plugin

Before you publish, make sure your plugin has:

- clear metadata in `plugin.json`
- a useful `README.md`
- screenshots or examples when appropriate
- a changelog and versioning strategy

## Recommended next steps

After your first successful local run, the next best improvements are usually:

1. add configuration options
2. handle real query data instead of placeholders
3. improve error handling and empty states
4. add tests where they reduce regression risk
5. package and sign the plugin for the intended environment

## Useful official references

- Grafana Plugin Tools overview: `https://grafana.com/developers/plugin-tools`
- Build a panel plugin: `https://grafana.com/developers/plugin-tools/tutorials/build-a-panel-plugin`
- Anatomy of a plugin: `https://grafana.com/developers/plugin-tools/key-concepts/anatomy-of-a-plugin/`
- Set up the Docker development environment: `https://grafana.com/developers/plugin-tools/set-up/set-up-docker`
- Sign a plugin: `https://grafana.com/developers/plugin-tools/publish-a-plugin/sign-a-plugin`

## Summary

The shortest path to a working Grafana plugin is:

1. scaffold with `@grafana/create-plugin`
2. run the local Docker development environment
3. make one small change and verify it in Grafana
4. build for production
5. sign the plugin before distribution

That flow gives you a stable base whether you are building a panel, data source, or app plugin.
