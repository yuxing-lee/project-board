-- 專案進度看板:不用登入的共用資料表
-- 打開網址的人都能讀取和修改同一份資料。

create table if not exists public.shared_projects (
  id         text        primary key,
  data       jsonb       not null,
  updated_at timestamptz not null default now()
);

alter table public.shared_projects enable row level security;

drop policy if exists "shared_read"   on public.shared_projects;
drop policy if exists "shared_insert" on public.shared_projects;
drop policy if exists "shared_update" on public.shared_projects;
drop policy if exists "shared_delete" on public.shared_projects;

create policy "shared_read"   on public.shared_projects for select to anon, authenticated using (true);
create policy "shared_insert" on public.shared_projects for insert to anon, authenticated with check (true);
create policy "shared_update" on public.shared_projects for update to anon, authenticated using (true) with check (true);
create policy "shared_delete" on public.shared_projects for delete to anon, authenticated using (true);

grant select, insert, update, delete on public.shared_projects to anon, authenticated;
