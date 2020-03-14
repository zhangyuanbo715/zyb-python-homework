SELECT * FROM cran_logs LIMIT 10;

-- 9.1 give the total number of recordings in this table

SELECT count(*) FROM cran_logs;

-- 9.2 the number of packages listed in this table?

SELECT count(DISTINCT package) FROM cran_logs;

-- 9.3 How many times the package "Rcpp" was downloaded?

SELECT count(*) FROM cran_logs WHERE package='Rcpp';

-- 9.4 How many recordings are FROM China ("CN")?

SELECT count(*) FROM cran_logs WHERE country='CN';

-- 9.5 Give the package name and how many times they're downloaded. ORDER BY the 2nd column descently.

SELECT package, count(*) FROM cran_logs GROUP BY package  ORDER BY count(*) DESC;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM

ALTER TABLE cran_logs ALTER time TYPE time using time::time;
SELECT package,count(*) FROM cran_logs WHERE time BETWEEN '09:00:00' AND '11:00:00' GROUP BY package ORDER BY count(*) DESC;

-- 9.7 How many recordings are FROM China ("CN") or Japan("JP") or Singapore ("SG")?
SELECT count(*) FROM cran_logs WHERE country IN ('CN', 'JP', 'SG');

-- 9.8 Print the countries whose downloaded are more than the downloads FROM China ("CN")

SELECT country, count(*) FROM cran_logs GROUP BY country HAVING count(*)>(SELECT count(*) FROM cran_logs WHERE country='CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages

SELECT avg(DISTINCT length(package)) FROM cran_logs;

-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).

SELECT package, count(*) FROM cran_logs GROUP BY package ORDER BY count(*) desc limit 1 offset 1;

-- 9.11 Print the name of the package whose download count is bigger than 1000.

SELECT package, count(*) FROM cran_logs GROUP BY package HAVING count(*)>1000 ORDER BY count(*) DESC;

-- 9.12 The field "r_os" is the operating system of the users.
    -- 	Here we would like to know what main system we have (ignore version number), the relevant counts, and the proportion (in percentage).

SELECT a.r_os,a.num,a.num/sum(a.num) over() perc FROM (SELECT r_os,count(*) num FROM cran_logs GROUP BY r_os) a;