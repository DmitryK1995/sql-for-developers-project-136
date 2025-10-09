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
    slug VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE user_role AS ENUM ('Student', 'Teacher', 'Admin');

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teaching_group_id BIGINT REFERENCES teaching_groups(id) ON DELETE CASCADE, 
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password_hash CHAR(64),
    deleted_at TIMESTAMP,
    role user_role,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE status_default_list AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TYPE status_payments_default_list AS ENUM ('pending', 'paid', 'failed', 'refunded');

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
    status status_payments_default_list,
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
    content JSONB,
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
    text JSONB,
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