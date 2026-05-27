CREATE TABLE batches (
    batch_id VARCHAR(10) PRIMARY KEY,
    batch_code VARCHAR(20) UNIQUE NOT NULL,
    program VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    batch_status VARCHAR(20) NOT NULL
);

CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    roll_number VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    batch_id VARCHAR(10) NOT NULL,
    admission_date DATE NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL,
    graduation_year INT CHECK (graduation_year > 2000),
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
);

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    course_status VARCHAR(20) NOT NULL,
    credit_hours INT CHECK (credit_hours > 0)
);

CREATE TABLE enrollments (
    enrollment_id VARCHAR(10) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrolled_on DATE NOT NULL,
    enrollment_status VARCHAR(20),
    final_grade VARCHAR(5),
    UNIQUE(student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE problems (
    problem_id VARCHAR(10) PRIMARY KEY,
    course_id VARCHAR(10) NOT NULL,
    problem_code VARCHAR(30) UNIQUE NOT NULL,
    title VARCHAR(150) NOT NULL,
    difficulty VARCHAR(20),
    max_score INT CHECK (max_score > 0),
    created_at DATE,
    is_active BOOLEAN,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE test_cases (
    test_case_id VARCHAR(10) PRIMARY KEY,
    problem_id VARCHAR(10) NOT NULL,
    case_no INT NOT NULL,
    input_label VARCHAR(50),
    expected_output_label VARCHAR(50),
    points INT CHECK (points >= 0),
    is_hidden BOOLEAN,
    UNIQUE(problem_id, case_no),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

CREATE TABLE contests (
    contest_id VARCHAR(10) PRIMARY KEY,
    course_id VARCHAR(10) NOT NULL,
    contest_title VARCHAR(150) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    contest_status VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE contest_problems (
    contest_id VARCHAR(10),
    problem_id VARCHAR(10),
    problem_order INT NOT NULL,
    PRIMARY KEY (contest_id, problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

CREATE TABLE submissions (
    submission_id VARCHAR(15) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    problem_id VARCHAR(10) NOT NULL,
    contest_id VARCHAR(10),
    language VARCHAR(30) NOT NULL,
    submitted_at DATETIME NOT NULL,
    status VARCHAR(30),
    score INT CHECK (score >= 0),
    runtime_ms INT CHECK (runtime_ms >= 0),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id)
);

CREATE TABLE test_results (
    result_id VARCHAR(15) PRIMARY KEY,
    submission_id VARCHAR(15) NOT NULL,
    test_case_id VARCHAR(10) NOT NULL,
    result_status VARCHAR(30),
    runtime_ms INT CHECK (runtime_ms >= 0),
    memory_kb INT CHECK (memory_kb >= 0),
    awarded_points INT CHECK (awarded_points >= 0),
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id),
    FOREIGN KEY (test_case_id) REFERENCES test_cases(test_case_id)
);

CREATE TABLE sessions (
    session_id VARCHAR(10) PRIMARY KEY,
    course_id VARCHAR(10) NOT NULL,
    session_title VARCHAR(100) NOT NULL,
    session_date DATE NOT NULL,
    session_type VARCHAR(20),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE attendance (
    attendance_id VARCHAR(10) PRIMARY KEY,
    session_id VARCHAR(10) NOT NULL,
    student_id VARCHAR(10) NOT NULL,
    attendance_status VARCHAR(20),
    marked_at DATETIME,
    UNIQUE(session_id, student_id),
    FOREIGN KEY (session_id) REFERENCES sessions(session_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE regrade_requests (
    request_id VARCHAR(10) PRIMARY KEY,
    submission_id VARCHAR(15) NOT NULL,
    student_id VARCHAR(10) NOT NULL,
    requested_at DATETIME,
    reason TEXT NOT NULL,
    request_status VARCHAR(20),
    resolved_at DATETIME,
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE plagiarism_flags (
    flag_id VARCHAR(10) PRIMARY KEY,
    submission_id VARCHAR(15) NOT NULL,
    matched_submission_id VARCHAR(15) NOT NULL,
    similarity_score DECIMAL(5,2) CHECK (similarity_score BETWEEN 0 AND 100),
    flag_status VARCHAR(20),
    created_at DATETIME,
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id),
    FOREIGN KEY (matched_submission_id) REFERENCES submissions(submission_id)
);

CREATE TABLE raw_student_import (
    raw_row_id VARCHAR(10) PRIMARY KEY,
    roll_number VARCHAR(20),
    full_name VARCHAR(100),
    email VARCHAR(100),
    batch_code VARCHAR(20),
    admission_date DATE,
    import_status VARCHAR(20),
    import_notes TEXT
);

CREATE TABLE operation_requests (
    operation_id VARCHAR(10) PRIMARY KEY,
    requested_by VARCHAR(100),
    operation_type VARCHAR(20) NOT NULL,
    target_table VARCHAR(50),
    target_record_id VARCHAR(20),
    requested_at DATETIME,
    reason TEXT,
    approval_status VARCHAR(20) NOT NULL,
    executed_at DATETIME
);