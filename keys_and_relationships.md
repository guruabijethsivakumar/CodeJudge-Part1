# Keys and Relationships

## students
Primary Key:
- student_id

Candidate Keys:
- student_id
- roll_number
- email

Alternate Keys:
- roll_number
- email

Foreign Key:
- batch_id -> batches(batch_id)

Constraints:
- full_name NOT NULL
- email UNIQUE
- roll_number UNIQUE
- graduation_year CHECK (> 2000)

Reason:
student_id uniquely identifies each student.

---

## batches
Primary Key:
- batch_id

Candidate Keys:
- batch_id
- batch_code

Alternate Key:
- batch_code

Constraints:
- batch_code UNIQUE
- program NOT NULL

Reason:
Each batch should be unique.

---

## courses
Primary Key:
- course_id

Candidate Keys:
- course_id
- course_code

Alternate Key:
- course_code

Constraints:
- course_title NOT NULL
- credit_hours CHECK (credit_hours > 0)

Reason:
Each course should have unique course code.

---

## enrollments
Primary Key:
- enrollment_id

Foreign Keys:
- student_id -> students(student_id)
- course_id -> courses(course_id)

Candidate Key:
- enrollment_id

Composite Unique:
- (student_id, course_id)

Constraints:
- enrolled_on NOT NULL

Reason:
Same student should not join same course multiple times.

---

## problems
Primary Key:
- problem_id

Foreign Key:
- course_id -> courses(course_id)

Candidate Keys:
- problem_id
- problem_code

Alternate Key:
- problem_code

Constraints:
- title NOT NULL
- max_score CHECK (max_score > 0)

---

## test_cases
Primary Key:
- test_case_id

Foreign Key:
- problem_id -> problems(problem_id)

Composite Key:
- (problem_id, case_no)

Constraints:
- points CHECK (points >= 0)

Reason:
One problem should not have duplicate case numbers.

---

## contests
Primary Key:
- contest_id

Foreign Key:
- course_id -> courses(course_id)

Constraints:
- contest_title NOT NULL
- end_time > start_time

---

## contest_problems
Composite Primary Key:
- (contest_id, problem_id)

Foreign Keys:
- contest_id -> contests(contest_id)
- problem_id -> problems(problem_id)

Constraints:
- problem_order NOT NULL

Reason:
This is a mapping table between contests and problems.

---

## submissions
Primary Key:
- submission_id

Foreign Keys:
- student_id -> students(student_id)
- problem_id -> problems(problem_id)
- contest_id -> contests(contest_id)

Constraints:
- language NOT NULL
- runtime_ms CHECK (runtime_ms >= 0)
- score CHECK (score >= 0)

---

## test_results
Primary Key:
- result_id

Foreign Keys:
- submission_id -> submissions(submission_id)
- test_case_id -> test_cases(test_case_id)

Constraints:
- awarded_points CHECK (awarded_points >= 0)

---

## sessions
Primary Key:
- session_id

Foreign Key:
- course_id -> courses(course_id)

Constraints:
- session_title NOT NULL

---

## attendance
Primary Key:
- attendance_id

Foreign Keys:
- session_id -> sessions(session_id)
- student_id -> students(student_id)

Composite Unique:
- (session_id, student_id)

Reason:
One student should have only one attendance record per session.

---

## regrade_requests
Primary Key:
- request_id

Foreign Keys:
- submission_id -> submissions(submission_id)
- student_id -> students(student_id)

Constraints:
- reason NOT NULL

---

## plagiarism_flags
Primary Key:
- flag_id

Foreign Keys:
- submission_id -> submissions(submission_id)
- matched_submission_id -> submissions(submission_id)

Constraints:
- similarity_score CHECK (0 to 100)

---

## raw_student_import
Primary Key:
- raw_row_id

Reason:
Temporary raw import table.

---

## operation_requests
Primary Key:
- operation_id

Constraints:
- operation_type NOT NULL
- approval_status NOT NULL

Reason:
Used for admin tracking.