# EduTrack Data Audit — Analysis Report

The queries were run in the order shown in `queries.sql`. Consequently, queries
9–12 reflect the database after the INSERT, UPDATE, and DELETE corrections.

## 1. Enrollments in Intro to Python

Result: 4 enrollments

| name | email | completion_percentage |
| --- | --- | ---: |
| Emily Watson | emily.watson@student.edutrack.com | 85 |
| Klaus Weber | klaus.weber@student.edutrack.com | 92 |
| Marco Rossi | marco.rossi@student.edutrack.com | 88 |
| Priya Sharma | priya.sharma@student.edutrack.com | 55 |

## 2. Potential Dropouts

Result: 4 enrollments below 10% completion

| id | name | email | course_title | enrollment_date | completion_percentage | passed | monthly_fee_paid |
| ---: | --- | --- | --- | --- | ---: | --- | ---: |
| 10 | Yuki Nakamura | yuki.nakamura@test.com | UI/UX Fundamentals | 2024-10-11 | 0 | false | 44.99 |
| 11 | Pierre Dubois | pierre.dubois@test.com | UI/UX Fundamentals | 2024-11-05 | 0 | false | 44.99 |
| 6 | Lucia Fernandes | lucia.fernandes@test.com | Digital Marketing 101 | 2024-07-01 | 3 | false | 29.99 |
| 5 | Lucia Fernandes | lucia.fernandes@test.com | Web Design Basics | 2024-06-20 | 5 | false | 39.99 |

## 3. Enrollments with a NULL Instructor

Result: 2 enrollments

| id | name | email | course_title | instructor_name | completion_percentage |
| ---: | --- | --- | --- | --- | ---: |
| 10 | Yuki Nakamura | yuki.nakamura@test.com | UI/UX Fundamentals | NULL | 0 |
| 11 | Pierre Dubois | pierre.dubois@test.com | UI/UX Fundamentals | NULL | 0 |

## 4. Top 5 Completion Percentages Not Yet Passed

| name | course_title | completion_percentage |
| --- | --- | ---: |
| Emily Watson | Web Design Basics | 60 |
| Priya Sharma | Intro to Python | 55 |
| Yuki Nakamura | Data Analysis with SQL | 45 |
| Emily Watson | Advanced Python | 40 |
| Pierre Dubois | Data Analysis with SQL | 20 |

## 5. Enrollments in the Latest One-Year Period

Result: 14 enrollments, ordered newest to oldest

| id | name | course_title | enrollment_date | completion_percentage | passed | monthly_fee_paid |
| ---: | --- | --- | --- | ---: | --- | ---: |
| 15 | Emily Watson | Advanced Python | 2025-03-05 | 40 | false | 69.99 |
| 14 | Pierre Dubois | Data Analysis with SQL | 2025-02-20 | 20 | false | 59.99 |
| 13 | Priya Sharma | Intro to Python | 2025-01-10 | 55 | false | 49.99 |
| 12 | Priya Sharma | Digital Marketing 101 | 2024-12-01 | 70 | true | 29.99 |
| 11 | Pierre Dubois | UI/UX Fundamentals | 2024-11-05 | 0 | false | 44.99 |
| 10 | Yuki Nakamura | UI/UX Fundamentals | 2024-10-11 | 0 | false | 44.99 |
| 9 | Yuki Nakamura | Data Analysis with SQL | 2024-09-03 | 45 | false | 59.99 |
| 8 | Marco Rossi | Intro to Python | 2024-08-09 | 88 | true | 49.99 |
| 6 | Lucia Fernandes | Digital Marketing 101 | 2024-07-01 | 3 | false | 29.99 |
| 5 | Lucia Fernandes | Web Design Basics | 2024-06-20 | 5 | false | 39.99 |
| 4 | Klaus Weber | Data Analysis with SQL | 2024-05-01 | 78 | true | 59.99 |
| 2 | Emily Watson | Web Design Basics | 2024-04-15 | 60 | false | 39.99 |
| 7 | Marco Rossi | Advanced Python | 2024-03-25 | 95 | true | 69.99 |
| 3 | Klaus Weber | Intro to Python | 2024-03-20 | 92 | true | 49.99 |

## 6. Insert the Missing Enrollment

Result: 1 row inserted

| id | student_id | course_id | enrollment_date | completion_percentage | passed | monthly_fee_paid |
| ---: | ---: | ---: | --- | ---: | --- | ---: |
| 16 | 3 | 5 | 2025-04-01 | 0 | false | 69.99 |

## 7. Assign the Default Instructor

Result: 2 NULL instructor rows updated to `Pending assignment`

| id | title | instructor_name |
| ---: | --- | --- |
| 6 | UI/UX Fundamentals | Pending assignment |
| 7 | Email Campaigns | Pending assignment |

## 8. Delete Test-Account Enrollments

The confirmation SELECT returned 7 rows:

| id | name | email | course_title |
| ---: | --- | --- | --- |
| 5 | Lucia Fernandes | lucia.fernandes@test.com | Web Design Basics |
| 6 | Lucia Fernandes | lucia.fernandes@test.com | Digital Marketing 101 |
| 9 | Yuki Nakamura | yuki.nakamura@test.com | Data Analysis with SQL |
| 10 | Yuki Nakamura | yuki.nakamura@test.com | UI/UX Fundamentals |
| 11 | Pierre Dubois | pierre.dubois@test.com | UI/UX Fundamentals |
| 14 | Pierre Dubois | pierre.dubois@test.com | Data Analysis with SQL |
| 16 | Lucia Fernandes | lucia.fernandes@test.com | Advanced Python |

Result: all 7 confirmed rows were deleted; no non-test enrollment was removed.

## 9. Enrollments by Category

| category | enrollment_count |
| --- | ---: |
| Programming | 6 |
| Data | 1 |
| Design | 1 |
| Marketing | 1 |

## 10. Average Completion by Course

| course_title | average_completion |
| --- | ---: |
| Web Design Basics | 60.00 |
| Advanced Python | 67.50 |
| Digital Marketing 101 | 70.00 |
| Data Analysis with SQL | 78.00 |
| Intro to Python | 80.00 |

## 11. Courses with More Than 3 Enrollments

| course_title | enrollment_count |
| --- | ---: |
| Intro to Python | 4 |

## 12. Total Revenue by Category

| category | total_revenue |
| --- | ---: |
| Programming | 339.94 |
| Data | 59.99 |
| Design | 39.99 |
| Marketing | 29.99 |
