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

CREATE TABLE TeachingGroups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug varchar(255),
    created_at timestamp,
    updated_at timestamp
)

CREATE TABLE Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    teaching_group_id BIGINT REFERENCES TeachingGroups(id),
    name varchar(255),
    email varchar(255),
    password_hash CHAR(64) NOT NULL,
    linkEdGroup varchar(255),
    role VARCHAR(20) CHECK (role IN ('student', 'teacher', 'admin')),
    created_at timestamp,
    updated_at timestamp
);