USE world_layoff;

-- Data Cleaning -- 


-- 1.Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4.Romove any column


SELECT *
FROM layoffs;

-- creating a duplicte table to safe original one
CREATE TABLE layoff_staging
LIKE layoffs;

INSERT INTO layoff_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoff_staging;

-- Finding row_num 
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,percentage_laid_off,`date`)
FROM layoff_staging;



-- Finding duplicate and remove them 

WITH duplicate_cte AS
(
	SELECT * ,
	ROW_NUMBER() OVER(
	PARTITION BY company,location,industry,percentage_laid_off,`date`,
    stage,country,funds_raised_millions) row_num
	FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Creating a Column (row_num) to delete duplicate
CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoff_staging2
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,percentage_laid_off,`date`,
stage,country,funds_raised_millions) row_num
FROM layoff_staging;

SELECT * 
FROM layoff_staging2
WHERE row_num >1;

DELETE
FROM layoff_staging2
WHERE row_num >1;



-- Standardizing the data

-- Removing white space

SELECT company, TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company =TRIM(company);

-- Cropping Extra words

SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

SELECT *
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Removing ( . )

SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

SELECT *
FROM layoff_staging2
WHERE country LIKE 'United States%';

SELECT country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2;

UPDATE layoff_staging2
SET country =TRIM(TRAILING '.' FROM country);

-- Date formating and updaing text to date

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date`= STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoff_staging2;

SELECT `date`,
DATE_FORMAT(`date`,'%d-%b-%y')
FROM layoff_staging2;

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

-- Finding NULL values and fixing them

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Industry null fixing

SELECT *
FROM layoff_staging2
WHERE industry IS NULL
OR industry=''; 

UPDATE layoff_staging2
SET industry = NULL 
WHERE industry= '';

SELECT *
FROM layoff_staging2
WHERE company= 'Airbnb';

SELECT t1.industry,t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
SET t1.industry=t2.industry
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;



SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoff_staging2
DROP COLUMN row_num;













