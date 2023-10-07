---view tables
SELECT*
FROM PortfolioProject.dbo.CovidDeaths

--SELECT*
--FROM PortfolioProject.dbo.CovidVaccinations

--select data for project

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject.dbo.CovidDeaths
order by 1,2

--Total cases vs total deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM PortfolioProject.dbo.CovidDeaths
WHERE location like 'Germany%'
ORDER BY 1,2

--Total cases vs Population

SELECT location, date, population, total_cases, (total_cases/population)*100 AS perecentage_population_infected
FROM PortfolioProject.dbo.CovidDeaths
WHERE location like 'Germany%'
ORDER BY 1,2

--Countries with highest infection rate vis a vis population

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population))*100 AS percentage_population_infected
FROM PortfolioProject.dbo.CovidDeaths
GROUP BY location, population
ORDER BY 1,2

--Countries with highest death count per population

SELECT location, MAX(cast(total_deaths as int)) AS total_death_count
FROM PortfolioProject.dbo.CovidDeaths
GROUP BY location
ORDER BY total_death_count DESC

--Continent with highest death count

SELECT continent, MAX(cast(total_deaths as int)) AS total_death_count
FROM PortfolioProject.dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC

--Join tables, CovidDeaths and CovidVaccinations

SELECT*
FROM Portfolioproject.dbo.CovidDeaths AS Deaths
JOIN Portfolioproject.dbo.CovidVaccinations AS Vaccinations
ON Deaths.date = Vaccinations.date

--Total population vs Vaccinations from the two tables

SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, SUM(cast(Vaccinations.new_vaccinations as int)) 
OVER (partition by Deaths.location)
FROM Portfolioproject.dbo.CovidDeaths AS Deaths
JOIN Portfolioproject.dbo.CovidVaccinations AS Vaccinations
ON Deaths.location = Vaccinations.location
AND Deaths.date = Vaccinations.date
WHERE Deaths.continent IS NOT NULL
ORDER BY 2,3












