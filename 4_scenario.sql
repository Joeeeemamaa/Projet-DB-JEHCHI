USE lab3;

SELECT w.arw_id, w.arw_title, w.arw_year, a.ar_fname, a.ar_lname
FROM Artwork w
JOIN Artist a ON w.ar_id = a.ar_id
WHERE w.mu_id = 'M007'
ORDER BY w.arw_year;

SELECT w.arw_id, w.arw_title, w.arw_year, a.ar_fname, a.ar_lname
FROM Artwork w
JOIN Artist a ON w.ar_id = a.ar_id
WHERE w.mu_id = 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
ORDER BY w.arw_year;

SELECT w.arw_id, w.arw_title, b.start_date, b.end_date
FROM Artwork w
JOIN to_borrow b ON w.arw_id = b.arw_id
WHERE w.mu_id = 'M007'
  AND b.start_date <= '2025-12-31'
  AND b.end_date >= '2025-01-01'
ORDER BY b.start_date;

SELECT w.arw_id, w.arw_title, w.arw_year, a.ar_fname, a.ar_lname
FROM Artwork w
JOIN Artist a ON w.ar_id = a.ar_id
WHERE w.mu_id = 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
  AND w.arw_id NOT IN (
      SELECT b.arw_id
      FROM to_borrow b
      WHERE b.start_date <= '2025-12-31'
        AND b.end_date >= '2025-01-01'
  )
ORDER BY w.arw_year;

SELECT a.ar_id, a.ar_fname, a.ar_lname, COUNT(w.arw_id) AS number_of_works
FROM Artist a
JOIN Artwork w ON a.ar_id = w.ar_id
WHERE w.mu_id = 'M007'
GROUP BY a.ar_id, a.ar_fname, a.ar_lname
ORDER BY number_of_works DESC, a.ar_lname;

SELECT w.arw_id, w.arw_title, w.arw_year, a.ar_fname, a.ar_lname, m.mu_name
FROM Artwork w
JOIN Artist a ON w.ar_id = a.ar_id
JOIN Museum m ON w.mu_id = m.mu_id
WHERE w.mu_id <> 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
ORDER BY w.arw_year, m.mu_name;

SELECT w.arw_id, w.arw_title, w.arw_year, a.ar_fname, a.ar_lname, m.mu_name
FROM Artwork w
JOIN Artist a ON w.ar_id = a.ar_id
JOIN Museum m ON w.mu_id = m.mu_id
WHERE w.mu_id <> 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
  AND w.arw_id NOT IN (
      SELECT b.arw_id
      FROM to_borrow b
      WHERE b.start_date <= '2025-12-31'
        AND b.end_date >= '2025-01-01'
  )
ORDER BY w.arw_year, m.mu_name;

SELECT COUNT(*) AS available_internal_works
FROM Artwork w
WHERE w.mu_id = 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
  AND w.arw_id NOT IN (
      SELECT b.arw_id
      FROM to_borrow b
      WHERE b.start_date <= '2025-12-31'
        AND b.end_date >= '2025-01-01'
  );

SELECT COUNT(*) AS available_external_works
FROM Artwork w
WHERE w.mu_id <> 'M007'
  AND w.arw_year BETWEEN 1800 AND 1950
  AND w.arw_id NOT IN (
      SELECT b.arw_id
      FROM to_borrow b
      WHERE b.start_date <= '2025-12-31'
        AND b.end_date >= '2025-01-01'
  );