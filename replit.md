# Trinket - Open Source Coding Platform

## Overview
Trinket is an open-source browser-based coding platform that lets users write and run Python, HTML, and other languages in the browser. It includes a full LMS (Learning Management System) with course creation, student tracking, and interactive coding exercises.

## Architecture
- **Backend**: Node.js with Hapi.js v20 web framework
- **Database**: MongoDB (via Mongoose)
- **Templating**: Nunjucks (server-side HTML rendering)
- **CSS**: SCSS compiled via Vite
- **Frontend**: AngularJS 1.x with jQuery
- **Code execution**: Skulpt (Python-to-JavaScript compiler, client-side)
- **Session storage**: MongoDB-backed sessions via custom Catbox engine
- **Queue**: In-memory queue (Redis optional)

## Project Structure
```
trinket-oss/
├── app.js              # Main application entry point (Hapi server)
├── start.sh            # Startup script (starts MongoDB + app)
├── config/
│   ├── default.yaml    # Base configuration
│   ├── local.yaml      # Local overrides (gitignored, required)
│   ├── local.example.yaml  # Template for local.yaml
│   ├── routes.js       # Web routes
│   ├── api_routes.js   # API routes
│   ├── db.js           # MongoDB connection
│   └── redis.js        # Redis connection (optional)
├── lib/
│   ├── controllers/    # Route handlers
│   ├── models/         # Mongoose models
│   ├── util/           # Utilities (nunjucks, mailer, etc.)
│   └── views/          # Nunjucks HTML templates
├── public/             # Static assets (CSS, JS, images, components)
├── static/scss/        # SCSS source files
└── vite.config.mjs     # Vite config (CSS compilation only)
```

## Key Configuration (config/local.yaml)
- App runs on port 5000 at `0.0.0.0`
- MongoDB: `localhost:27017/trinket`
- Redis: disabled (uses in-memory fallback)
- Session password: set in `config/local.yaml`

## Running the Application
The `start.sh` script handles startup:
1. Starts MongoDB (forks to `/tmp/mongodb-data`)
2. Starts the Node.js app on port 5000

**Workflow command**: `bash start.sh`

## Building CSS
```bash
npm run build:css   # One-time build
npm run watch:css   # Watch mode
```

## Frontend Components
The `public/components/` directory contains bower components (Ace Editor, Skulpt, etc.) downloaded from GitHub releases (`v1.0.0/public-components.tgz`). These are NOT in git and must be downloaded separately.

## Dependencies
- MongoDB 7.0 (system dependency via Nix)
- Node.js 20
- npm packages (via `npm install`)

## User Management
```bash
npm run make-admin user@example.com  # Promote user to admin
```

## Features (from config/default.yaml)
- **Python** (Skulpt, client-side): enabled by default
- **Courses/LMS**: enabled
- **HTML/CSS/JS trinkets**: disabled by default
- **Server-side languages** (Python3, Java, R, Pygame): disabled (require separate backends)

## Environment Notes
- `config/local.yaml` is gitignored and required for running
- MongoDB data stored at `/tmp/mongodb-data` (ephemeral)
- Session cookie: `isSecure: false` (HTTP dev mode)
