# Statistical Analysis with SAS

A collection of SAS programs, examples, and projects covering statistical analysis, data exploration, hypothesis testing, regression, ANOVA, and other applied analytics techniques.

## About This Repository

This repository provides practical examples of statistical analysis using SAS. It includes reusable SAS programs, sample analyses, and step-by-step demonstrations of commonly used statistical methods.

The repository is suitable for students, analysts, researchers, and data professionals who want to strengthen their SAS programming and statistical analysis skills.

## Topics Covered

- SAS programming fundamentals
- Data import and preparation
- Data exploration
- Descriptive statistics
- Data visualization
- Probability distributions
- Hypothesis testing
- Confidence intervals
- Correlation analysis
- Simple linear regression
- Multiple linear regression
- Analysis of variance
- Categorical data analysis
- Model diagnostics
- Statistical result interpretation

## Repository Structure

```text
Statistical-Analysis-With-SAS/
│
├── data/                 # Sample datasets
├── programs/             # SAS program files
├── assets/               # Images and supporting resources
└── README.md
```

The repository structure may evolve as additional topics and projects are added.

## Requirements

The SAS programs can be run using one of the following environments:

- SAS Studio
- SAS OnDemand for Academics
- SAS 9.4
- SAS Viya
- Another compatible SAS environment

## Getting Started

Clone the repository:

```bash
git clone https://github.com/theanalyticschool/Statistical-Analysis-With-SAS.git
```

Navigate to the project directory:

```bash
cd Statistical-Analysis-With-SAS
```

Open the required `.sas` file in your SAS environment and run the program.

## Example SAS Program

```sas
proc import datafile="data/sample_data.csv"
    out=work.sample_data
    dbms=csv
    replace;
    guessingrows=max;
run;

proc contents data=work.sample_data;
run;

proc means data=work.sample_data
    mean median std min max;
run;
```

## Learning Objectives

By working through the examples in this repository, you will learn how to:

- Prepare and validate data in SAS
- Generate descriptive summaries
- Select an appropriate statistical method
- Test statistical assumptions
- Build and evaluate statistical models
- Interpret SAS output
- Communicate analytical findings clearly

## Contributing

Contributions, corrections, and suggestions are welcome.

To contribute:

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Commit your changes.
5. Push the branch to your fork.
6. Submit a pull request.

## Disclaimer

The datasets and examples in this repository are intended for educational purposes. Results should be independently validated before applying the code to production, academic research, or business decisions.

## Author

**Analytics School**

GitHub: [theanalyticschool](https://github.com/theanalyticschool)