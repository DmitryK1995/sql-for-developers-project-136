CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    price INT,
    program_type varchar(255),
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    description text,
    created_at timestamp,
    deleted_at timestamp,
    updated_at timestamp
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    description text,
    created_at timestamp,
    deleted_at timestamp,
    updated_at timestamp
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    content text,
    video_url varchar(255),
    position int,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    course_id BIGINT REFERENCES Courses (id)
);

CREATE TABLE course_modules (
    module_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (module_id, course_id),
    FOREIGN KEY (course_id) REFERENCES courses(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE program_modules (
    program_id INT NOT NULL,
    module_id INT NOT NULL,
    PRIMARY KEY (module_id, program_id),
    FOREIGN KEY (program_id) REFERENCES programs(id),
    FOREIGN KEY (module_id) REFERENCES modules(id)
);

CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug varchar(255),
    created_at timestamp,
    updated_at timestamp
);

CREATE TYPE user_role AS ENUM ('student', 'teacher', 'admin');

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teaching_group_id BIGINT REFERENCES teaching_groups(id),
    name varchar(255),
    email varchar(255),
    password_hash CHAR(64) NOT NULL,
    deleted_at timestamp,
    role user_role,
    created_at timestamp,
    updated_at timestamp
);

CREATE TYPE status_default_list AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id),
    program_id BIGINT REFERENCES programs(id),
    status status_default_list,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments(id),
    amount INT,
    status status_default_list,
    paid_at TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id),
    program_id BIGINT REFERENCES programs(id),
    status status_default_list,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id),
    program_id BIGINT REFERENCES programs(id),
    url varchar(255),
    issued_at TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id),
    name varchar(255),
    content JSON,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id),
    name varchar(255),
    url varchar(255),
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id),
    lesson_id BIGINT REFERENCES lessons(id),
    text JSON,
    created_at timestamp,
    updated_at timestamp
);

CREATE TYPE blog_status AS ENUM ('created', 'in moderation', 'published', 'archived');

CREATE TABLE blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id),
    name varchar(255),
    content text,
    status blog_status,
    created_at timestamp,
    updated_at timestamp
);