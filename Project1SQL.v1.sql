Select * 
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Selects all the data from  the database from the excel spreadsheet
--Select Data we will be using 

Select Location, date , total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2

--Observing total cases vs total deaths in the US

Select Location, date , total_cases, total_deaths, ((total_deaths/total_cases)*100) as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states'
order by 1,2

--Displays what percentage of the population got Covid in the US

Select Location, date , population, total_cases, (total_cases/population)*100 as InfectedPercentage
From PortfolioProject..CovidDeaths
Where location like '%states'
order by 1,2

--Observe Countries with the Highest Infection Rate in Relation to the Population
--use desc function to show highest to lowest rate of infection in relation to the population

Select Location, Population, Max(total_cases) as InfectionCount, Max((total_cases/population)*100) as PercentInfected
From PortfolioProject..CovidDeaths
Group by location, population
Order by PercentInfected desc

--Displays the Countries with highest death count per population (mortality rate)

Select location, population, Max(cast( total_deaths as int)) as TotalDeaths, Max((total_deaths/population)*100) as DeathPercentage
--Cast is not needed but used it to test funtion
From PortfolioProject..CovidDeaths
where continent is not null
Group by location, population
Order by DeathPercentage desc

--Focus on the US

Select location,  Max(cast(total_deaths as int)) as TotalDeaths
From PortfolioProject..CovidDeaths
Where location like '%states'
Group by location
Order by TotalDeaths desc

--GLOBAL SCOPE 

Select SUM(new_cases)as total_cases, SUM(cast(new_deaths as int))as total_deaths, SUM (cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like %states%
Where continent is not null
--Group by date
order by 1,2


--Population vs Vaccinated

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1,2,3