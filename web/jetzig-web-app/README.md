# Jetzig Web App

A minimal web application built with the Jetzig framework (Zig). It demonstrates:

- Routing and view handling in `src/app/views/`
- Zmpl templating (`.zmpl`) with partials
- Static assets served from `public/`
- Optional middleware structure

---

## Tech Stack

- Zig (see `build.zig` / `build.zig.zon`)
- [Jetzig](https://github.com/jetzig-framework/jetzig) (web framework)
- [Zmpl](https://github.com/jetzig-framework/zmpl) (templating)
- [Zmd](https://github.com/jetzig-framework/zmd) (markdown rendering)
- TailwindCSS (via CDN in template)
- HTMX (via CDN in template)

---

## Project Structure

```sh
.
├── build.zig
├── build.zig.zon
├── config/
│   └── database.zig               # Database adapter configuration (null by default)
├── public/                        # Static assets (served from "/")
│   ├── favicon.ico
│   ├── jetzig.png
│   ├── styles.css
│   └── zmpl.png
├── src/
│   ├── app/
│   │   ├── middleware/
│   │   │   └── DemoMiddleware.zig
│   │   └── views/
│   │       ├── root.zig           # Controller for "/"
│   │       └── root/
│   │           ├── _content.zmpl  # Partial
│   │           └── index.zmpl     # Template for GET /
│   └── main.zig                   # Jetzig app options and entry
└── .jetzig                        # Project marker
```

Key files to note:

- `src/main.zig`: Configures Jetzig options (middleware chain, store/cache/job settings, cookies, markdown fragments, etc.) and imports routes/static.
- `src/app/views/root.zig`: Implements `index()` for GET `/`. Demonstrates setting response data and headers.
- `src/app/views/root/index.zmpl`: Zmpl template rendering the page and including a partial.
- `src/app/views/root/_content.zmpl`: Partial template, uses `@args` to accept data from the parent.
- `config/database.zig`: Environment-specific database adapter config. Currently `.null` adapter for all envs.

---

## Prerequisites

- Zig installed (0.12.x or newer recommended)
- Internet access for first-time dependency fetch (Jetzig is referenced in `build.zig.zon` by URL and hash)

Check Zig:

```sh
zig version
```

---

## Install Dependencies

Zig package fetching is integrated with the build system. On first build, run:

```sh
zig build --fetch
```

This will download dependencies specified in `build.zig.zon` (e.g., Jetzig).

---

## Build & Run

- Build the executable:

```sh
zig build
```

- Run the app (build + run):

```sh
zig build run
```

By default, Jetzig apps serve on `http://localhost:8080/`. Open that URL in your browser.

You can append a query parameter to see dynamic data flow into the template:

```sh
http://localhost:8080/?message=hello
```

`src/app/views/root.zig` picks up `message` via `request.params()` and exposes it as `.message_param` for `index.zmpl` to render.

---

## Testing

This project wires a `test` step in `build.zig` that runs both library and executable tests from `src/main.zig`:

```sh
zig build test
```

---

## Database Configuration

The database configuration lives in `config/database.zig`.

- Default: `.null` adapter for all environments (any DB call will fail, which is useful while there is no DB).
- PostgreSQL example configs are provided but commented out. You can enable them and/or configure via environment variables:
  - `JETQUERY_HOSTNAME`
  - `JETQUERY_PORT`
  - `JETQUERY_USERNAME`
  - `JETQUERY_PASSWORD`
  - `JETQUERY_DATABASE`

Example snippet (uncomment and adapt in `config/database.zig`):

```zig
.testing = .{
    .adapter = .postgresql,
    .hostname = "localhost",
    .port = 5432,
    .username = "postgres",
    .password = "password",
    .database = "myapp_testing",
},
```

---

## Middleware

A demo middleware is provided at `src/app/middleware/DemoMiddleware.zig`. To enable it, modify `pub const middleware` in `src/main.zig`:

```zig
pub const jetzig_options = struct {
    pub const middleware: []const type = &.{ @import("app/middleware/DemoMiddleware.zig") };
};
```

Middleware callbacks include `afterRequest`, `beforeResponse`, and `afterResponse` for logging or modifying request/response behavior.

---

## Static Assets

Files under `public/` are served from the site root:

- `public/jetzig.png` -> `/jetzig.png`
- `public/styles.css` -> `/styles.css`

The main template already links `styles.css` and includes example images.

---

## Zmpl Templating Tips

- Use `@partial` to include partial templates and pass data. See `src/app/views/root/index.zmpl` calling `root/_content.zmpl`:

```zmpl
@partial root/content(message: .welcome_message)
```

- In partials, declare arguments at the top with `@args`. See `src/app/views/root/_content.zmpl`:

```zmpl
@args message: *ZmplValue
```

- Data fields are set from view code using `jetzig.Data`. See `root.zig` using `data.object()` and `put()`.

---

## Configuration (selected from `src/main.zig`)

- `public_content_path = "public"` controls the static directory.
- `store`, `job_queue`, and `cache` default to in-memory backends. You can switch to file/valkey backends.
- Cookie options differ by environment; production enables `same_site`, `secure`, and `http_only`.
- Markdown rendering fragments are customized for Tailwind classes.

Adjust these in `pub const jetzig_options`.

---

## Environment

Jetzig commonly uses environments like `development`, `testing`, and `production`.

- Defaults are geared towards development.
- Ensure your runtime environment variables match any DB or mailer configuration you enable.

---

## Common Commands

- Fetch deps: `zig build --fetch`
- Build: `zig build`
- Run: `zig build run`
- Test: `zig build test`

---

## Troubleshooting

- If dependencies fail to fetch, re-run `zig build --fetch` and ensure you have network access.
- If static files are not loading, confirm `public/` exists and `public_content_path` is set to `"public"`.
- For database errors with the null adapter, switch to a real adapter in `config/database.zig`.

---

## License

Add your preferred license and include a `LICENSE` file at the repository root.
