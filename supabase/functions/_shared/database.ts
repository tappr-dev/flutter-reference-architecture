import * as postgres from "https://deno.land/x/postgres@v0.17.0/mod.ts";

export const pool = new postgres.Pool(Deno.env.get('SUPABASE_DB_URL')!, 3, true)
