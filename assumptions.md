# Assumptions

1. student_id is unique for each student.

2. roll_number and email are also unique for students.

3. batch_id correctly connects students with batches.

4. one student can enroll in multiple courses.

5. one course can have multiple students.

6. one course can have multiple coding problems.

7. one problem can have multiple test cases.

8. one contest can contain multiple problems.

9. contest_problems is used as mapping table for many-to-many relationship.

10. contest_id in submissions can be NULL for practice submissions.

11. one submission can generate multiple test results.

12. one student should have only one attendance record per session.

13. plagiarism flags compare one submission with another submission.

14. raw_student_import is temporary staging data and not part of final clean schema.

15. operation_requests is used only for admin tracking and audit purposes.

16. some raw CSV data may contain inconsistent records, so clean schema assumptions are applied.