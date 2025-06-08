# mcp-server-supabase Example

This project demonstrates how to use the [Model Context Protocol (MCP)](https://modelcontextprotocol.org/) with a Supabase backend. It provides a local development environment for experimenting with MCP, Supabase, and Postgres.

## Features

- Local Supabase stack (Postgres, Auth, Storage, Studio, etc.)
- Example schema and seed data for users, teams, and posts
- MCP server configuration for direct database access
- Ready-to-use with [Cursor](https://cursor.so) or any MCP-compatible client

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) (for running Supabase locally)
- [Supabase CLI](https://supabase.com/docs/guides/cli) (`brew install supabase/tap/supabase`)
- [Node.js](https://nodejs.org/) (for MCP server via npx)
- [Cursor](https://cursor.so) (optional, for conversational database access)

### Setup

1. **Clone the repository:**
   ```sh
   git clone https://github.com/walshe/mcp-server-supabase.git
   cd mcp-server-supabase
   ```

2. **Start Supabase locally:**
   ```sh
   supabase start
   ```

3. **Apply migrations and seed data:**
   ```sh
   supabase db reset
   ```

4. **Configure MCP server:**
   - The `.cursor/mcp.json` file is pre-configured to use the Postgres MCP server:
     ```json
     {
       "mcpServers": {
         "supabase": {
           "command": "npx",
           "args": [
             "-y",
             "@modelcontextprotocol/server-postgres",
             "postgresql://postgres:postgres@127.0.0.1:54322/postgres"
           ]
         }
       }
     }
     ```

5. **Connect with Cursor:**
   - Open Cursor and ensure the MCP tool is green (connected).
   - You can now use conversational commands like:
     ```
     how many users are in my users table?
     ```

## Example Schema

- `public.users`: User profiles
- `public.teams`: Teams
- `public.team_members`: Team membership
- `public.posts`: Posts

Seed data is provided in `supabase/seed.sql`.

## Troubleshooting

- If the MCP tool in Cursor is yellow or red, check your Supabase instance and `.cursor/mcp.json` configuration.
- Make sure Docker is running and ports are not in use by other services.

## License

MIT
