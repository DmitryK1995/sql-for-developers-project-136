CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    cost INT,
    typeName varchar(255),
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    description text,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    description text,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name varchar(255),
    content text,
    linkVideo varchar(255),
    coursePosition int,
    created_at timestamp,
    updated_at timestamp,
    linkCourse varchar(255),
    course_id BIGINT REFERENCES Courses (id),
    is_deleted boolean
);

CREATE TABLE module_courses (
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
)

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
    linkEdGroup varchar(255),
    role user_role,
    created_at timestamp,
    updated_at timestamp
);

CREATE TYPE status_default_list AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_user BIGINT REFERENCES users(id),
    id_program BIGINT REFERENCES programs(id),
    status status_default_list,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_enrollment BIGINT REFERENCES enrollments(id),
    amount INT,
    status status_default_list,
    date TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_user BIGINT REFERENCES users(id),
    id_program BIGINT REFERENCES programs(id),
    status status_default_list,
    begin_date TIMESTAMP,
    end_date TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_user BIGINT REFERENCES users(id),
    id_program BIGINT REFERENCES programs(id),
    url varchar(255),
    release_date TIMESTAMP,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_lesson BIGINT REFERENCES lessons(id),
    name varchar(255),
    content JSON,
    created_at timestamp,
    updated_at timestamp
);

CREATE TABLE exercise (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    id_lesson BIGINT REFERENCES lessons(id),
    name varchar(255),
    url varchar(255),
    created_at timestamp,
    updated_at timestamp
)