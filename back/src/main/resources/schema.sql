CREATE TABLE users (
    user_id BIGINT NOT NULL PRIMARY KEY,
    record_id VARCHAR(255) NOT NULL,
    boj_id VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nickname VARCHAR(20) NOT NULL,
    image VARCHAR(255),
    password VARCHAR(20) NOT NULL,
    user_tier INT NOT NULL,
    bio VARCHAR(255),
    is_deleted BOOLEAN NOT NULL
);

CREATE TABLE follows (
    follow_id BIGINT NOT NULL PRIMARY KEY,
    follower_id BIGINT NOT NULL,
    following_id BIGINT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (following_id) REFERENCES users(user_id)
);

CREATE TABLE notes (
    note_id BIGINT NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    problem_id INT NOT NULL,
    problem_name VARCHAR(255) NOT NULL,
    problem_tier INT NOT NULL,
    note_title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    success_code TEXT,
    success_code_start INT,
    success_code_end INT,
    fail_code_start INT,
    fail_code_end INT,
    fail_code TEXT,
    view_count INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    is_public BOOLEAN NOT NULL DEFAULT TRUE,
    is_deleted BOOLEAN NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id BIGINT NOT NULL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    note_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (note_id) REFERENCES notes(note_id)
);

CREATE TABLE likes (
    like_id BIGINT NOT NULL PRIMARY KEY,
    note_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    FOREIGN KEY (note_id) REFERENCES notes(note_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE tags (
    tag_id INT NOT NULL PRIMARY KEY,
    tag_name VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE notes_tags (
    tag_id INT NOT NULL,
    note_id BIGINT NOT NULL,
    PRIMARY KEY (tag_id, note_id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id),
    FOREIGN KEY (note_id) REFERENCES notes(note_id)
);
