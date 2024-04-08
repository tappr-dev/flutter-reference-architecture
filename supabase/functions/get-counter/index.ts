import {corsHeaders} from "../_shared/cors.ts";
import {pool} from "../_shared/database.ts";

Deno.serve(async (req) => {
    if (req.method === 'OPTIONS') {
        return new Response('ok', {headers: corsHeaders})
    }
    if (req.method !== 'GET') return new Response('Method Not Allowed', {status: 405, headers: corsHeaders})

    try {
        const connection = await pool.connect()

        try {
            const result = await connection.queryObject(
                'SELECT value, updated_at FROM counters WHERE id = 0');
            const body = JSON.stringify(result.rows[0], null, 2)
            return new Response(body, {
                status: 200,
                headers: {...corsHeaders, 'Content-Type': 'application/json; charset=utf-8'},
            })
        } finally {
            connection.release()
        }
    } catch (err) {
        console.error(err)
        return new Response(String(err?.message ?? err), {status: 500, headers: corsHeaders})
    }
})
