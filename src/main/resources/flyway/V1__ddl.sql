-- DDL: Create all tables for pet-rescue application

CREATE TABLE IF NOT EXISTS m_tbl_users (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    username         VARCHAR(100)  NOT NULL,
    email            VARCHAR(255)  NOT NULL,
    password_hash    VARCHAR(255)  NOT NULL,
    full_name        VARCHAR(255)  NOT NULL,
    phone            VARCHAR(50),
    facebook_link    VARCHAR(500),
    role             VARCHAR(50)   NOT NULL DEFAULT 'USER',
    is_active        BOOLEAN       NOT NULL DEFAULT TRUE,
    avatar_url       VARCHAR(500),
    created_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_users_username UNIQUE (username),
    CONSTRAINT uq_users_email    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS m_tbl_pets (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    type         VARCHAR(50)  NOT NULL,
    breed        VARCHAR(255),
    age          INT,
    gender       VARCHAR(20),
    description  TEXT,
    youtube_url  VARCHAR(500),
    status       VARCHAR(50)  NOT NULL DEFAULT 'AVAILABLE',
    created_by   INT          NOT NULL REFERENCES m_tbl_users (id),
    created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS m_tbl_pet_media (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    pet_id      INT          NOT NULL REFERENCES m_tbl_pets (id),
    file_url    VARCHAR(500) NOT NULL,
    media_type  VARCHAR(20)  NOT NULL DEFAULT 'IMAGE',
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS m_tbl_pet_posts (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    pet_id      INT          NOT NULL REFERENCES m_tbl_pets (id),
    title       VARCHAR(500) NOT NULL,
    content     TEXT         NOT NULL,
    author_id   INT          NOT NULL REFERENCES m_tbl_users (id),
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_tbl_adoptions (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    pet_id          INT          NOT NULL REFERENCES m_tbl_pets (id),
    user_id         INT          NOT NULL REFERENCES m_tbl_users (id),
    status          VARCHAR(50)  NOT NULL DEFAULT 'REGISTERED',
    approved_by     INT          REFERENCES m_tbl_users (id),
    cancelled_by    INT          REFERENCES m_tbl_users (id),
    reason          TEXT,
    phone           VARCHAR(50)  NOT NULL,
    facebook_link   VARCHAR(500) NOT NULL,
    notes           TEXT,
    created_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_tbl_rescues (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT          REFERENCES m_tbl_users (id),
    location      VARCHAR(500) NOT NULL,
    description   TEXT         NOT NULL,
    status        VARCHAR(50)  NOT NULL DEFAULT 'NEW',
    contact_info  VARCHAR(500) NOT NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_tbl_blogs (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(500) NOT NULL,
    content       TEXT         NOT NULL,
    author_id     INT          NOT NULL REFERENCES m_tbl_users (id),
    tags          VARCHAR(500),
    is_published  BOOLEAN      NOT NULL DEFAULT FALSE,
    view_count    INT          NOT NULL DEFAULT 0,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_tbl_donations (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    donor_name      VARCHAR(255)    NOT NULL,
    donor_email     VARCHAR(255)    NOT NULL,
    amount          DECIMAL(15, 2)  NOT NULL,
    message         TEXT,
    status          VARCHAR(50)     NOT NULL DEFAULT 'PENDING',
    transaction_id  VARCHAR(255),
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_tbl_finances (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    type         VARCHAR(20)     NOT NULL,
    amount       DECIMAL(15, 2)  NOT NULL,
    description  TEXT            NOT NULL,
    category     VARCHAR(100),
    recorded_by  INT             NOT NULL REFERENCES m_tbl_users (id),
    date         DATE            NOT NULL DEFAULT CURRENT_DATE,
    created_at   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS m_tbl_role_resource (
    role         VARCHAR(50)  NOT NULL,
    resource     VARCHAR(255) NOT NULL,
    http_method  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (role, resource, http_method)
);

CREATE TABLE IF NOT EXISTS m_tbl_site_configs (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    config_key    VARCHAR(100) NOT NULL,
    config_value  TEXT         NOT NULL,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_site_configs_key UNIQUE (config_key)
);
