-- 1. Enrollments in Intro to Python
SELECT
    s.name,
    s.email,
    e.completion_percentage
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE c.title = 'Intro to Python'
ORDER BY s.name;

-- 2. Potential dropouts (less than 10% complete)
SELECT
    e.id,
    s.name,
    s.email,
    c.title AS course_title,
    e.enrollment_date,
    e.completion_percentage,
    e.passed,
    e.monthly_fee_paid
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE e.completion_percentage < 10
ORDER BY e.completion_percentage, e.id;

-- 3. Enrollments whose course has no assigned instructor
SELECT
    e.id,
    s.name,
    s.email,
    c.title AS course_title,
    c.instructor_name,
    e.completion_percentage
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE c.instructor_name IS NULL
ORDER BY e.id;

-- 4. Five highest completion percentages among students not yet passed
SELECT
    s.name,
    c.title AS course_title,
    e.completion_percentage
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE e.passed = FALSE
ORDER BY e.completion_percentage DESC, e.id
LIMIT 5;

-- 5. Enrollments in the dataset's latest one-year period
SELECT
    e.id,
    s.name,
    c.title AS course_title,
    e.enrollment_date,
    e.completion_percentage,
    e.passed,
    e.monthly_fee_paid
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE e.enrollment_date >= (
    SELECT MAX(enrollment_date) - INTERVAL '1 year'
    FROM enrollments
)
ORDER BY e.enrollment_date DESC, e.id DESC;

-- 6. Insert the missing enrollment described in edutrack.sql
INSERT INTO enrollments
    (
        student_id,
        course_id,
        enrollment_date,
        completion_percentage,
        passed,
        monthly_fee_paid
    )
SELECT
    s.id,
    c.id,
    DATE '2025-04-01',
    0,
    FALSE,
    69.99
FROM students AS s
CROSS JOIN courses AS c
WHERE s.email = 'lucia.fernandes@test.com'
  AND c.title = 'Advanced Python'
  AND NOT EXISTS (
      SELECT 1
      FROM enrollments AS existing
      WHERE existing.student_id = s.id
        AND existing.course_id = c.id
        AND existing.enrollment_date = DATE '2025-04-01'
  )
RETURNING *;

-- 7. Assign the default value only to NULL instructors
UPDATE courses
SET instructor_name = 'Pending assignment'
WHERE instructor_name IS NULL
RETURNING id, title, instructor_name;

-- 8. Confirm, then delete, enrollments tied to @test.com accounts
SELECT
    e.id,
    s.name,
    s.email,
    c.title AS course_title
FROM enrollments AS e
JOIN students AS s ON s.id = e.student_id
JOIN courses AS c ON c.id = e.course_id
WHERE s.email LIKE '%@test.com'
ORDER BY e.id;

DELETE FROM enrollments AS e
USING students AS s
WHERE e.student_id = s.id
  AND s.email LIKE '%@test.com'
RETURNING e.id, e.student_id, e.course_id;

-- 9. Enrollment count by category
SELECT
    c.category,
    COUNT(*) AS enrollment_count
FROM enrollments AS e
JOIN courses AS c ON c.id = e.course_id
GROUP BY c.category
ORDER BY enrollment_count DESC, c.category;

-- 10. Average completion percentage by course, lowest to highest
SELECT
    c.title AS course_title,
    ROUND(AVG(e.completion_percentage), 2) AS average_completion
FROM enrollments AS e
JOIN courses AS c ON c.id = e.course_id
GROUP BY c.title
ORDER BY average_completion, c.title;

-- 11. Courses with more than three enrollments
SELECT
    c.title AS course_title,
    COUNT(*) AS enrollment_count
FROM enrollments AS e
JOIN courses AS c ON c.id = e.course_id
GROUP BY c.title
HAVING COUNT(*) > 3
ORDER BY enrollment_count DESC, c.title;

-- 12. Total revenue by category, highest to lowest
SELECT
    c.category,
    SUM(e.monthly_fee_paid) AS total_revenue
FROM enrollments AS e
JOIN courses AS c ON c.id = e.course_id
GROUP BY c.category
ORDER BY total_revenue DESC, c.category;
