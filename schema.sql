-- Kör en gång i Supabase: SQL Editor -> New query -> klistra in -> Run
create table if not exists public.hbk_docs (
  team_code text not null,
  id text not null,
  data jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (team_code, id)
);
alter table public.hbk_docs enable row level security;
-- Prototypnivå: lagkoden är nyckeln. Bara förnamn lagras.
create policy "hbk anon read"  on public.hbk_docs for select to anon using (true);
create policy "hbk anon write" on public.hbk_docs for insert to anon with check (true);
create policy "hbk anon update" on public.hbk_docs for update to anon using (true) with check (true);
alter publication supabase_realtime add table public.hbk_docs;
