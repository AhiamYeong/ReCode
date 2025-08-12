CREATE DATABASE IF NOT EXISTS recode;
USE recode;

-- USERS
CREATE TABLE IF NOT EXISTS users (
                                     user_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                     recode_id VARCHAR(255) NOT NULL,
    boj_id VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nickname VARCHAR(20) NOT NULL,
    image VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    user_tier INT NOT NULL,
    bio VARCHAR(255),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
    );

-- FOLLOWS
CREATE TABLE IF NOT EXISTS follows (
                                       follow_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                       follower_id BIGINT NOT NULL,
                                       following_id BIGINT NOT NULL,
                                       FOREIGN KEY (follower_id) REFERENCES users(user_id),
    FOREIGN KEY (following_id) REFERENCES users(user_id)
    );

-- NOTES
CREATE TABLE IF NOT EXISTS notes (
                                     note_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                     user_id BIGINT NOT NULL,
                                     problem_id BIGINT NOT NULL,
                                     problem_name VARCHAR(255) NOT NULL,
    problem_tier INT NOT NULL,
    note_title VARCHAR(255) NOT NULL,
    content LONGTEXT NOT NULL,
    success_code LONGTEXT,
    success_code_start INT,
    success_code_end INT,
    fail_code_start INT,
    fail_code_end INT,
    fail_code LONGTEXT,
    view_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_public TINYINT(1) NOT NULL DEFAULT 1,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,
    comment_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    fail_language VARCHAR(20),
    success_language VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    );

-- COMMENTS
CREATE TABLE IF NOT EXISTS comments (
                                        comment_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                        user_id BIGINT NOT NULL,
                                        note_id BIGINT NOT NULL,
                                        content TEXT NOT NULL,
                                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                        FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (note_id) REFERENCES notes(note_id)
    );

-- LIKES
CREATE TABLE IF NOT EXISTS likes (
                                     like_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                     note_id BIGINT NOT NULL,
                                     user_id BIGINT NOT NULL,
                                     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                     FOREIGN KEY (note_id) REFERENCES notes(note_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    );

-- TAGS
CREATE TABLE IF NOT EXISTS tags (
                                    tag_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                    tag_name VARCHAR(20) NOT NULL UNIQUE
    );

-- NOTES_TAGS (N:N 관계)
CREATE TABLE IF NOT EXISTS notes_tags (
                                          tag_id BIGINT NOT NULL,
                                          note_id BIGINT NOT NULL,
                                          PRIMARY KEY (tag_id, note_id),
    FOREIGN KEY (tag_id) REFERENCES tags(tag_id),
    FOREIGN KEY (note_id) REFERENCES notes(note_id)
    );
