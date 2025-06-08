-- Insert sample users
insert into auth.users (id, email)
values 
    ('d0d8c3c0-5b9a-4b7d-9b1a-0b5b9b4b7d9b', 'john.doe@example.com'),
    ('e1e9d4d1-6c0b-5c8e-0c2b-1c6c0c5c8e0c', 'jane.smith@example.com'),
    ('f2f0e5e2-7d1c-6d9f-1d3c-2d7d1d6d9f1d', 'bob.wilson@example.com');

insert into public.users (id, email, full_name, avatar_url)
values 
    ('d0d8c3c0-5b9a-4b7d-9b1a-0b5b9b4b7d9b', 'john.doe@example.com', 'John Doe', 'https://api.dicebear.com/7.x/avataaars/svg?seed=John'),
    ('e1e9d4d1-6c0b-5c8e-0c2b-1c6c0c5c8e0c', 'jane.smith@example.com', 'Jane Smith', 'https://api.dicebear.com/7.x/avataaars/svg?seed=Jane'),
    ('f2f0e5e2-7d1c-6d9f-1d3c-2d7d1d6d9f1d', 'bob.wilson@example.com', 'Bob Wilson', 'https://api.dicebear.com/7.x/avataaars/svg?seed=Bob');

-- Insert sample teams
insert into public.teams (id, name, description)
values 
    ('a1a9b4b1-5c0a-4c7d-0b1a-1b5b0b4b7d0b', 'Engineering', 'The core engineering team'),
    ('b2b0c5c2-6d1b-5d8e-1c2b-2c6c1c5c8e1c', 'Design', 'The creative design team'),
    ('c3c1d6d3-7e2c-6e9f-2d3c-3d7d2d6d9f2d', 'Product', 'The product management team');

-- Insert team members
insert into public.team_members (team_id, user_id, role)
values 
    ('a1a9b4b1-5c0a-4c7d-0b1a-1b5b0b4b7d0b', 'd0d8c3c0-5b9a-4b7d-9b1a-0b5b9b4b7d9b', 'admin'),
    ('a1a9b4b1-5c0a-4c7d-0b1a-1b5b0b4b7d0b', 'e1e9d4d1-6c0b-5c8e-0c2b-1c6c0c5c8e0c', 'member'),
    ('b2b0c5c2-6d1b-5d8e-1c2b-2c6c1c5c8e1c', 'e1e9d4d1-6c0b-5c8e-0c2b-1c6c0c5c8e0c', 'admin'),
    ('c3c1d6d3-7e2c-6e9f-2d3c-3d7d2d6d9f2d', 'f2f0e5e2-7d1c-6d9f-1d3c-2d7d1d6d9f1d', 'admin');

-- Insert sample posts
insert into public.posts (id, title, content, author_id, team_id)
values 
    ('d4d2e7e4-8f3d-7f0a-3e4d-4e8e3e7e0a3e', 'Welcome to Engineering Team', 'Welcome everyone to our engineering team!', 'd0d8c3c0-5b9a-4b7d-9b1a-0b5b9b4b7d9b', 'a1a9b4b1-5c0a-4c7d-0b1a-1b5b0b4b7d0b'),
    ('e5e3f8f5-9e4e-8e1b-4f5e-5f9f4f8f1b4f', 'Design System Update', 'We are updating our design system to version 2.0', 'e1e9d4d1-6c0b-5c8e-0c2b-1c6c0c5c8e0c', 'b2b0c5c2-6d1b-5d8e-1c2b-2c6c1c5c8e1c'),
    ('f6f4e9e6-0e5f-9e2c-5e6f-6e0e5e9e2c5e', 'Product Roadmap Q2', 'Here is our product roadmap for Q2', 'f2f0e5e2-7d1c-6d9f-1d3c-2d7d1d6d9f1d', 'c3c1d6d3-7e2c-6e9f-2d3c-3d7d2d6d9f2d'); 