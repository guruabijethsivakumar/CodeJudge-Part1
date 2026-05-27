# ER Diagram (Text Format)

batches
- batch_id (PK)

students
- student_id (PK)
- batch_id (FK)

courses
- course_id (PK)

enrollments
- enrollment_id (PK)
- student_id (FK)
- course_id (FK)

problems
- problem_id (PK)
- course_id (FK)

test_cases
- test_case_id (PK)
- problem_id (FK)

contests
- contest_id (PK)
- course_id (FK)

contest_problems
- contest_id (PK, FK)
- problem_id (PK, FK)

submissions
- submission_id (PK)
- student_id (FK)
- problem_id (FK)
- contest_id (FK)

test_results
- result_id (PK)
- submission_id (FK)
- test_case_id (FK)

sessions
- session_id (PK)
- course_id (FK)

attendance
- attendance_id (PK)
- session_id (FK)
- student_id (FK)

regrade_requests
- request_id (PK)
- submission_id (FK)
- student_id (FK)

plagiarism_flags
- flag_id (PK)
- submission_id (FK)
- matched_submission_id (FK)

Relationships:

batches 1 -> many students

students many -> many courses (through enrollments)

courses 1 -> many problems

problems 1 -> many test_cases

courses 1 -> many contests

contests many -> many problems (through contest_problems)

students 1 -> many submissions

submissions 1 -> many test_results

courses 1 -> many sessions

sessions 1 -> many attendance

students 1 -> many attendance

students 1 -> many regrade_requests