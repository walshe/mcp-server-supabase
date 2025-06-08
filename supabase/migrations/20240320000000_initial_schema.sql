-- Create users table (extends Supabase auth.users)
create table public.users (
    id uuid references auth.users on delete cascade not null primary key,
    email text unique not null,
    full_name text,
    avatar_url text,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create teams table
create table public.teams (
    id uuid default gen_random_uuid() primary key,
    name text not null,
    description text,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create team_members junction table
create table public.team_members (
    team_id uuid references public.teams on delete cascade not null,
    user_id uuid references public.users on delete cascade not null,
    role text not null check (role in ('admin', 'member')),
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    primary key (team_id, user_id)
);

-- Create posts table
create table public.posts (
    id uuid default gen_random_uuid() primary key,
    title text not null,
    content text not null,
    author_id uuid references public.users on delete cascade not null,
    team_id uuid references public.teams on delete cascade not null,
    created_at timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- Create RLS policies
alter table public.users enable row level security;
alter table public.teams enable row level security;
alter table public.team_members enable row level security;
alter table public.posts enable row level security;

-- Users policies
create policy "Users can view their own profile"
    on public.users for select
    using (auth.uid() = id);

create policy "Users can update their own profile"
    on public.users for update
    using (auth.uid() = id);

-- Teams policies
create policy "Team members can view their teams"
    on public.teams for select
    using (
        exists (
            select 1 from public.team_members
            where team_id = teams.id
            and user_id = auth.uid()
        )
    );

create policy "Team admins can update their teams"
    on public.teams for update
    using (
        exists (
            select 1 from public.team_members
            where team_id = teams.id
            and user_id = auth.uid()
            and role = 'admin'
        )
    );

-- Team members policies
create policy "Team members can view team members"
    on public.team_members for select
    using (
        exists (
            select 1 from public.team_members
            where team_id = team_members.team_id
            and user_id = auth.uid()
        )
    );

-- Posts policies
create policy "Team members can view posts"
    on public.posts for select
    using (
        exists (
            select 1 from public.team_members
            where team_id = posts.team_id
            and user_id = auth.uid()
        )
    );

create policy "Team members can create posts"
    on public.posts for insert
    with check (
        exists (
            select 1 from public.team_members
            where team_id = posts.team_id
            and user_id = auth.uid()
        )
    );

create policy "Authors can update their own posts"
    on public.posts for update
    using (author_id = auth.uid());

create policy "Authors can delete their own posts"
    on public.posts for delete
    using (author_id = auth.uid());

-- Create updated_at trigger function
create or replace function public.handle_updated_at()
returns trigger as $$
begin
    new.updated_at = timezone('utc'::text, now());
    return new;
end;
$$ language plpgsql;

-- Add updated_at triggers
create trigger handle_users_updated_at
    before update on public.users
    for each row
    execute function public.handle_updated_at();

create trigger handle_teams_updated_at
    before update on public.teams
    for each row
    execute function public.handle_updated_at();

create trigger handle_posts_updated_at
    before update on public.posts
    for each row
    execute function public.handle_updated_at(); 