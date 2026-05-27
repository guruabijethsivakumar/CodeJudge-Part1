# Normalization Notes
## Redundant Data Examples

### 1. Student details repetition
If student name, email, or roll number is stored in submissions, attendance, or regrade tables, same data repeats many times.

Better design: Store student details only in students table and use student_id as foreign key.

### 2. Course details repetition
If course title or course code is stored in enrollments, problems, contests, or sessions, same data repeats again.

Better design: Store course details only in courses table and connect using course_id.

### 3. Problem details repetition
If problem title or max score is stored in submissions or contest mapping, repeated data increases.

Better design: Store problem details only in problems table.

## Separating Data into Different Tables

### 1. Contest and Problems
A contest can contain multiple problems and one problem can appear in multiple contests.

Better design: contest_problems mapping table.

### 2. Students and Courses
One student can join many courses and one course can have many students.

Better design: enrollments table.

## Functional Dependency Examples

### 1.
student_id -> full_name, email, roll_number, batch_id

Meaning: If student_id is known, all student details can be found.

### 2.
course_id -> course_code, course_title, credit_hours

Meaning: Course details depend only on course_id.

## Partial Dependency Example
In contest_problems:

(contest_id, problem_id) is composite key.

problem_order depends on full composite key.

If any column depends only on one part of composite key, partial dependency happens.

## Normal Form Analysis

### 1NF
The design follows 1NF because:
- each column stores single value
- no repeating groups
- atomic values are used

### 2NF
The design follows 2NF because:
- non-key attributes fully depend on primary key
- many-to-many relationships are separated

### 3NF
The design follows 3NF because:
- transitive dependencies are reduced
- repeated information is avoided
- master data is stored separately

## Trade-offs
Normalized design reduces redundancy and improves consistency.

But too much normalization increases JOIN complexity.

So this design keeps balance between normalization and practical use.