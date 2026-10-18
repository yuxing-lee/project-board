-- 專案進度看板:把原本的 projects 表改成不用登入、大家共用
alter table public.projects drop constraint if exists projects_pkey;
alter table public.projects drop constraint if exists projects_user_id_fkey;
alter table public.projects alter column user_id drop not null;
alter table public.projects alter column user_id drop default;
alter table public.projects add primary key (id);

drop policy if exists "projects_select_own" on public.projects;
drop policy if exists "projects_insert_own" on public.projects;
drop policy if exists "projects_update_own" on public.projects;
drop policy if exists "projects_delete_own" on public.projects;
drop policy if exists "projects_open" on public.projects;
create policy "projects_open" on public.projects for all to anon, authenticated using (true) with check (true);

grant select, insert, update, delete on public.projects to anon, authenticated;
