
create extension if not exists pgcrypto;
create table if not exists public.exams (
 id uuid primary key default gen_random_uuid(),
 slug text not null unique,
 title text not null,
 opens_at timestamptz not null,
 last_entry_at timestamptz not null,
 ends_at timestamptz not null,
 duration_minutes integer not null check(duration_minutes between 1 and 360),
 questions jsonb not null default '[]'::jsonb,
 published boolean not null default false,
 created_at timestamptz not null default now(),
 constraint exam_times check(opens_at <= last_entry_at and last_entry_at < ends_at)
);
create table if not exists public.attempts (
 id uuid primary key default gen_random_uuid(),
 exam_id uuid not null references public.exams(id) on delete cascade,
 candidate_name text not null check(length(candidate_name) between 3 and 120),
 token_hash text not null unique,
 started_at timestamptz not null default now(),
 deadline_at timestamptz not null,
 submitted_at timestamptz,
 answers jsonb,
 correct integer,
 wrong integer,
 blank integer,
 percentage numeric(5,2)
);
create index if not exists attempts_exam_idx on public.attempts(exam_id);
alter table public.exams enable row level security;
alter table public.attempts enable row level security;
revoke all on public.exams from anon, authenticated;
revoke all on public.attempts from anon, authenticated;
-- All access is through Netlify Functions using the server-side service role key.
