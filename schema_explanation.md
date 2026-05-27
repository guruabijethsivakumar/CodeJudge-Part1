# Schema Understanding – CodeJudge Database
## Overview
This dataset is about a coding platform called CodeJudge.It stores student details, course details, coding problems, contests, submissions, attendance, plagiarism checking, regrade requests, and admin operations.Some tables contain main system data and some tables contain activity records.

## students
This table stores student details.
Important columns:
- student_id → unique student id
- roll_number → student roll number
- full_name → student name
- email → student email
- batch_id → student batch
Relationship:
batch_id connects with batches.
Note:
Student details should be stored only here.

## batches
This table stores batch information.
Important columns:
- batch_id
- batch_code
- program
- start_date
- end_date
- batch_status
Relationship:
One batch can have many students.

## courses
This table stores course details.
Important columns:
- course_id
- course_code
- course_title
- course_status
- credit_hours
Relationship:
One course can have many students, problems, contests, and sessions.

## enrollments
This table stores which student joined which course.
Important columns:
- enrollment_id
- student_id
- course_id
- enrolled_on
- final_grade
Relationships:
- student_id → students
- course_id → courses
Note:
This table handles many-to-many relationship between students and courses.

## problems
This table stores coding problems.
Important columns:
- problem_id
- course_id
- problem_code
- title
- difficulty
- max_score
Relationship:
course_id connects with courses.

## test_cases
This table stores test cases for coding problems.
Important columns:
- test_case_id
- problem_id
- case_no
- points
- is_hidden
Relationship:
problem_id connects with problems.
Note:
One problem can have many test cases.

## contests
This table stores contest details.
Important columns:
- contest_id
- course_id
- contest_title
- start_time
- end_time
- contest_status
Relationship:
course_id connects with courses.

## contest_problems
This table connects contests and problems.
Important columns:
- contest_id
- problem_id
- problem_order
Relationships:
- contest_id → contests
- problem_id → problems
Note:
One contest can contain many problems.

## submissions
This table stores student code submissions.
Important columns:
- submission_id
- student_id
- problem_id
- contest_id
- language
- status
- score
Relationships:
- student_id → students
- problem_id → problems
- contest_id → contests
Note:
contest_id can be empty for practice submissions.

## test_results
This table stores result for each test case.
Important columns:
- result_id
- submission_id
- test_case_id
- result_status
- awarded_points
Relationships:
- submission_id → submissions
- test_case_id → test_cases
Note:
One submission can have multiple test results.

## sessions
This table stores class/lab sessions.
Important columns:
- session_id
- course_id
- session_title
- session_date
- session_type
Relationship:
course_id connects with courses.

## attendance
This table stores attendance details.
Important columns:
- attendance_id
- session_id
- student_id
- attendance_status
Relationships:
- session_id → sessions
- student_id → students

## regrade_requests
This table stores requests for re-evaluation.
Important columns:
- request_id
- submission_id
- student_id
- reason
- request_status
Relationships:
- submission_id → submissions
- student_id → students

## plagiarism_flags
This table stores plagiarism checking records.
Important columns:
- flag_id
- submission_id
- matched_submission_id
- similarity_score
- flag_status
Relationships:
Both submission ids connect with submissions.

## raw_student_import
This table stores temporary imported student data.
Important columns:
- raw_row_id
- roll_number
- full_name
- email
- batch_code
- import_status
Note:
This is raw data and not part of final clean schema.

## operation_requests
This table stores admin operation requests.
Important columns:
- operation_id
- requested_by
- operation_type
- target_table
- approval_status
Note:
Used for admin tracking and database operations.