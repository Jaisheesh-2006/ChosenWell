# Environment Variables Guide

This document lists all environment variables required for production deployment of ChosenWell.

---

## Frontend (Vercel)

Set these in your Vercel project settings under **Settings → Environment Variables**.

| Variable                   | Required | Description                                          | Example                                        |
| -------------------------- | -------- | ---------------------------------------------------- | ---------------------------------------------- |
| `NEXT_PUBLIC_API_URL`      | ✅ Yes   | Backend API URL                                      | `https://chosenwell-production.up.railway.app` |
| `NEXT_PUBLIC_SITE_URL`     | ✅ Yes   | Frontend site URL (used for sitemap, canonical URLs) | `https://chosenwell.co.in`                     |
| `GOOGLE_SITE_VERIFICATION` | Optional | Google Search Console verification code              | `abc123xyz`                                    |

### Example `.env.local` for local development:

```env
NEXT_PUBLIC_API_URL=http://localhost:8080
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

---

## Backend (Railway)

Set these in your Railway project under **Variables** tab.

| Variable       | Required | Description                                   | Example                                          |
| -------------- | -------- | --------------------------------------------- | ------------------------------------------------ |
| `DATABASE_URL` | ✅ Yes   | PostgreSQL connection string (Neon DB)        | `postgresql://user:pass@host/db?sslmode=require` |
| `PORT`         | Optional | Server port (Railway sets this automatically) | `8080`                                           |

### Example `.env` for local development:

```env
DATABASE_URL=postgresql://healthuser:healthpass@localhost:5432/healthiswealth?sslmode=disable
PORT=8080
```

---

## Database (Neon)

No environment variables needed - connection is configured via `DATABASE_URL` in the backend.

### Connection String Format:

```
postgresql://[user]:[password]@[host]/[database]?sslmode=require
```

**Important for Neon:**

- Always use `sslmode=require` in production
- The backend automatically adds `binary_parameters=yes` for PgBouncer compatibility

---

## Quick Setup Checklist

### Vercel (Frontend)

- [ ] `NEXT_PUBLIC_API_URL` → Your Railway backend URL
- [ ] `NEXT_PUBLIC_SITE_URL` → Your production domain (e.g., `https://chosenwell.co.in`)
- [ ] (Optional) `GOOGLE_SITE_VERIFICATION` → For Google Search Console

### Railway (Backend)

- [ ] `DATABASE_URL` → Your Neon PostgreSQL connection string

---

## Notes

1. **NEXT*PUBLIC* prefix**: Variables with this prefix are exposed to the browser. Only use for non-sensitive values.

2. **Railway auto-injects PORT**: Don't set PORT manually on Railway unless needed.

3. **Neon connection pooling**: The backend is configured to work with Neon's PgBouncer. No additional config needed.

4. **HTTPS**: All production URLs should use `https://`. The frontend enforces HSTS headers automatically.

---

## Troubleshooting

| Issue                       | Solution                                              |
| --------------------------- | ----------------------------------------------------- |
| API calls failing           | Check `NEXT_PUBLIC_API_URL` is correct and accessible |
| Sitemap showing wrong URLs  | Verify `NEXT_PUBLIC_SITE_URL` matches your domain     |
| Database connection errors  | Ensure `DATABASE_URL` has `sslmode=require` for Neon  |
| "Prepared statement" errors | Backend handles this - redeploy if persists           |
