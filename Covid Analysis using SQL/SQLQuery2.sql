select *
from covidanalysis..death
where continent is not null
order by 3,4


select *
from covidanalysis..vaccination
order by 3,4

--select data that we are going to use
select location,date,total_cases,new_cases,total_deaths,population
from covidanalysis..death
where continent is not null
order by 1,2

--looking at total case vs total death
select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from covidanalysis..death
where continent is not null
order by 1,2

--looking at total case vs population
select location,date,total_cases,population,(total_cases/population)*100 as totalcasepercentage
from covidanalysis..death
where continent is not null
order by 1,2

--looking at country with highest infection rate compared to population
select  location,population,max(total_cases) as highestinfectioncount,max((total_cases/population))*100 as totalcasepercentage
from covidanalysis..death
where continent is not null
group by location,population
order by totalcasepercentage desc

--showing countries with highest death count per population
select  location, max(cast(total_deaths as int)) as totaldeathcount
from covidanalysis..death
where continent is not null
group by location
order by totaldeathcount desc

--lets break things down in continents
select  location, max(cast(total_deaths as int)) as totaldeathcount
from covidanalysis..death
where continent is null
group by location
order by totaldeathcount desc


select  continent, max(cast(total_deaths as int)) as totaldeathcount
from covidanalysis..death
where continent is not null
group by continent
order by totaldeathcount desc

--Showing the continent with the highest death count
select  continent, max(cast(total_deaths as int)) as totaldeathcount
from covidanalysis..death
where continent is not null
group by continent
order by totaldeathcount desc

--global numbers
select sum(new_cases) as totalcase_perday,sum(cast(new_deaths as int)) as totaldeath_perday, (sum(cast(new_deaths as int))/sum(new_cases))*100 as deathpercentage_perday--,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from covidanalysis..death
where continent is not null
--group by date
order by 1,2

select date,sum(new_cases) as totalcase_perday,sum(cast(new_deaths as int)) as totaldeath_perday, (sum(cast(new_deaths as int))/sum(new_cases))*100 as deathpercentage_perday--,total_deaths,(total_deaths/total_cases)*100 as deathpercentage
from covidanalysis..death
where continent is not null
group by date
order by 1,2

--JOINING BOTH THE TABLE
SELECT*
FROM covidanalysis..death dea
JOIN covidanalysis..vaccination vac 
ON dea.location = vac.location
and dea.date = vac.date

----COVID VACCINATION----
select *
from covidanalysis..vaccination

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From covidanalysis..death dea
Join covidanalysis..vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3



