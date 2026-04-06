-- DML: Seed role-resource permissions

-- Role-resource permissions
INSERT INTO m_tbl_role_resource (role, resource, http_method) VALUES
    -- /users – ADMIN only
    ('ADMIN',     '/users',                    'GET'),
    ('ADMIN',     '/users',                    'POST'),

    -- /adoptions – any authenticated role
    ('USER',      '/adoptions',                'GET'),
    ('USER',      '/adoptions',                'POST'),
    ('VOLUNTEER', '/adoptions',                'GET'),
    ('VOLUNTEER', '/adoptions',                'POST'),
    ('ADMIN',     '/adoptions',                'GET'),
    ('ADMIN',     '/adoptions',                'POST'),

    -- /adoptions/*/approve – ADMIN and VOLUNTEER only
    ('ADMIN',     '/adoptions/*/approve',      'POST'),
    ('VOLUNTEER', '/adoptions/*/approve',      'POST'),

    -- /adoptions/*/cancel – any authenticated role
    ('USER',      '/adoptions/*/cancel',       'POST'),
    ('VOLUNTEER', '/adoptions/*/cancel',       'POST'),
    ('ADMIN',     '/adoptions/*/cancel',       'POST'),

    -- /rescues – any authenticated role
    ('USER',      '/rescues',                  'GET'),
    ('USER',      '/rescues',                  'POST'),
    ('VOLUNTEER', '/rescues',                  'GET'),
    ('VOLUNTEER', '/rescues',                  'POST'),
    ('ADMIN',     '/rescues',                  'GET'),
    ('ADMIN',     '/rescues',                  'POST'),

    -- /rescues/*/status – ADMIN and VOLUNTEER only
    ('ADMIN',     '/rescues/*/status',         'POST'),
    ('VOLUNTEER', '/rescues/*/status',         'POST'),

    -- /rescues/*/delete – ADMIN only
    ('ADMIN',     '/rescues/*/delete',         'POST'),

    -- /pets write operations – ADMIN and VOLUNTEER
    ('ADMIN',     '/pets/new',                 'GET'),
    ('ADMIN',     '/pets/new',                 'POST'),
    ('VOLUNTEER', '/pets/new',                 'GET'),
    ('VOLUNTEER', '/pets/new',                 'POST'),
    ('ADMIN',     '/pets/*/edit',              'GET'),
    ('ADMIN',     '/pets/*/edit',              'POST'),
    ('VOLUNTEER', '/pets/*/edit',              'GET'),
    ('VOLUNTEER', '/pets/*/edit',              'POST'),
    ('ADMIN',     '/pets/*/delete',            'POST'),
    ('ADMIN',     '/pets/*/media/*/delete',    'POST'),
    ('VOLUNTEER', '/pets/*/media/*/delete',    'POST'),

    -- /config – ADMIN only
    ('ADMIN',     '/config',                   'GET'),
    ('ADMIN',     '/config',                   'POST'),

    -- /profile – any authenticated user
    ('USER',      '/profile',                  'GET'),
    ('USER',      '/profile',                  'POST'),
    ('VOLUNTEER', '/profile',                  'GET'),
    ('VOLUNTEER', '/profile',                  'POST'),
    ('ADMIN',     '/profile',                  'GET'),
    ('ADMIN',     '/profile',                  'POST'),

    -- /blog write operations – ADMIN and VOLUNTEER
    ('ADMIN',     '/blog/new',                 'GET'),
    ('ADMIN',     '/blog/new',                 'POST'),
    ('VOLUNTEER', '/blog/new',                 'GET'),
    ('VOLUNTEER', '/blog/new',                 'POST'),
    ('ADMIN',     '/blog/*/edit',              'GET'),
    ('ADMIN',     '/blog/*/edit',              'POST'),
    ('VOLUNTEER', '/blog/*/edit',              'GET'),
    ('VOLUNTEER', '/blog/*/edit',              'POST'),
    ('ADMIN',     '/blog/*/delete',            'POST'),

    -- /blog/upload-image – ADMIN and VOLUNTEER
    ('ADMIN',     '/blog/upload-image',        'POST'),
    ('VOLUNTEER', '/blog/upload-image',        'POST'),

    -- /wishes – ADMIN only
    ('ADMIN',     '/wishes',                   'GET'),
    ('ADMIN',     '/wishes/*/approve',         'POST'),
    ('ADMIN',     '/wishes/*/receive',         'POST'),
    ('ADMIN',     '/wishes/*/delete',          'POST')

ON CONFLICT (role, resource, http_method) DO NOTHING;
