--Lets work with our first table
select *
from [covid analysis]..CovidDeaths
order by 3,4

-- select the data we are going to be using
select location, date, total_cases, new_cases, total_deaths, population
from [covid analysis]..CovidDeaths
order by 1,2

-- looking at total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from [covid analysis]..CovidDeaths
order by 1,2

-- looking at total cases vs total deaths in India
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from [covid analysis]..CovidDeaths
where location like '%India%'
order by 1,2

-- looking at total case vs population
select location, date, total_cases, population, (total_cases/population)*100000000 as population_infected
from [covid analysis]..CovidDeaths
order by 1,2

--looking at countries with highest infection count
select location, population, max(total_cases) as highest_infection_count
from [covid analysis]..CovidDeaths
group by location, population
order by highest_infection_count desc

-- looking atn countries with highest death count
select location, max(cast(total_deaths as int)) as total_deathcount
from [covid analysis]..CovidDeaths
where continent is not null
group by location
order by total_deathcount desc

--Lets break things down by continent
Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [covid analysis]..CovidDeaths
where continent is null
group by location
order by TotalDeathCount desc

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [covid analysis]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


--showing continent with highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
from [covid analysis]..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc

--global numbers
select  date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from [covid analysis]..CovidDeaths
--where location like '%states%'
where continent is not null
order by 1,2

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [covid analysis]..CovidDeaths
--where location like '%states%'
where continent is not null
group by date
order by 1,2

select  sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [covid analysis]..CovidDeaths
--where location like '%states%'
where continent is not null
--group by date
order by 1,2



-- vaccination
select *
from [covid analysis]..CovidVaccinations

--joining tables
select *
from [covid analysis]..CovidDeaths dea
join [covid analysis]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date

--total population vs vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [covid analysis]..CovidDeaths dea
join [covid analysis]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3



