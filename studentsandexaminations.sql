SELECT st.student_id, st.student_name, sub.subject_name, count(e.subject_name) AS attended_exams 
FROM Students st
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
ON st.student_id = e.student_id
AND sub.subject_name = e.subject_name
GROUP BY st.student_id, st.student_name, sub.subject_name
ORDER BY st.student_id,sub.subject_name;


//
WITH student_subjects AS (
    SELECT 
        st.student_id,
        st.student_name,
        sub.subject_name
    FROM Students st
    CROSS JOIN Subjects sub
),
exam_counts AS (
    SELECT
        student_id,
        subject_name,
        COUNT(*) AS attended_exams
    FROM Examinations
    GROUP BY student_id, subject_name
)
SELECT
    ss.student_id,
    ss.student_name,
    ss.subject_name,
    COALESCE(ec.attended_exams, 0) AS attended_exams
FROM student_subjects ss
LEFT JOIN exam_counts ec
    ON ss.student_id = ec.student_id
   AND ss.subject_name = ec.subject_name
ORDER BY ss.student_id, ss.subject_name;
