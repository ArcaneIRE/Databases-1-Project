# Project Spec

***Due Date: Tuesday 6th December 2022, 23:59***  
*Grade: 30% of module*  
*Include **both** names in files if duoing*

## 1. Models and Planning

- Logical & Physical Data Modelling
- Database design decisions

### Requirements

- Provide a logical model demonstrating the entities, attributes and relationships of your database.
  - Can use paper (scanned, images) or software such as Lucid Chart
- Provide a physical model demonstrating the entities, attributes and relationships of your database.
  - Can use any software
  - Final model, code should be based off this

## 2. Implementation

- Build database in oracle
- Populate database
- Construct complex Queries

### Requirements

- Create tables based on data models
  - Tables must match model
- Populate models with data
  - 5+ rows per table
  - Data should be persisted (commit?)
  - Ensure that queries result in data being returned for all queries
        - E.g., if there is a query for salaries above 40k, include salaries above 40k
- Provide SQL statements to demonstrate the following:  
    *SQL comments must be included to explain how each was implemented and which requirement is being addressed*
  - One `UPDATE` or one `DELETE` combined with a `subquery`
  - One selection function `CASE`/`DECODE`
  - One `INNER JOIN` using a `GROUP` function
  - One `LEFT OUTER JOIN`
  - One `RIGHT OUTER JOIN`
  - One `UNION`
  - One `INTERSECT`
  - One `VIEW`
- Must run without errors

## Submission

- Must be a zipped folder
- Named like: `DB1_CA2_StudentNumber1_StudentNumber2.zip`
- Include Student Numbers at the start of each file
- Clearly comment
  
### Required Files

1. Word document describing database and containing
    - Modelling screenshots as per template
    - Outline of key decisions
2. The DDL file (`.sql`)
3. The DML file (`.sql`)

### Notes

- Any material used must be referenced
- Submit via ‘assignment section’ on brightspace
- Extensions must be requested by email
- 5% penalty for each day beyond submission date
- Latest Submission: Tuesday, December 13th 2022 by 23:59
- Can lose 5% for submissions that do not fulfil requirements (names)
