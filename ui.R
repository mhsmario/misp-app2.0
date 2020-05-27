#
# This is the user-interface definition of the MISP Calculator 2.0 2020 edition
# created by Kathrin Weny, deployed 27 May 2020

library(shiny)
library(rsconnect)
library(tidyverse)
library(readxl)
library(rhandsontable)
library(DT)

data.misp     <- read.csv("data.misp.2020.csv")
data.misp.tbl1 <- data.misp[c("country", "wra", "t.18.up", "f.10.14", "f.10.19", "t.10.24", "m.18.up", "cbr", "sti", "nnmr", "mmr")]
data.misp.tbl2 <- data.misp[c("country", "mpds.all.f")]
data.misp.tbl3 <- data.misp[c("country", "hiv", "art")]
data.misp.tbl4 <- data.misp[c("country", "abortion")]

input.dem.1 <- read.csv("input.dem.1.csv")
input.dem.2 <- read.csv("input.dem.2.csv")
input.srh.1 <- read.csv("input.srh.1.csv")
input.srh.2 <- read.csv("input.srh.2.csv")
input.fp.1 <- read.csv("input.fp.1.csv")
input.fp.2 <- read.csv("input.fp.2.csv")

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  
  "MISP Calculator 2.0 2020 Version", 
  
  tabPanel("Input Data",
           
           fluidRow(
             
             br(),
             
             column(3,style='padding-left:50px',
                    
                    tags$h1("Selections"),
                    selectInput("country", 
                                label = "Choose a country",
                                choices = data.misp$country,
                                selected = "Algeria"),
                    
                    numericInput("num", 
                                 label = "Number of affected persons", 
                                 value = 100000), 
                    
                    strong("Global constants"),"are averages, calculated based on the best-available data.", 
                    strong("Country specific"), "data have been loaded from our database based on the country you select. 
      You can enter", strong("site-specific data"), "in the green fields.",
                    
                    br(),
                    br(),
                    p("You can download your input data (whatever you see on this screen) as well as the full database running in the background below:"), 
                    
                    br(),
                    
                    downloadButton("downloadData", "Download your input data"), downloadButton("downloadDatafull", "Download full dataset")),
             
             column(6,
                    
                    tags$h1("Input data"),
                    tags$h4("Demographic Indicators"),  rHandsontableOutput("table1.1"), rHandsontableOutput("table1.2"),
                    br(),
                    tags$h4("Maternal and Newborn Health"),  rHandsontableOutput("table2.1"), rHandsontableOutput("table2.2"),
                    br(),
                    tags$h4("Access to Sexual and Reproductive Health"),  rHandsontableOutput("table3.1"),  rHandsontableOutput("table3.2"),
                    br(),
                    br()
                    
             ))),
  
  tabPanel("MISP Calculations", 
           
           fluidRow(
             column(8,style='padding-left:150px',
                    
                    tags$h1("Results"), 
                    tags$h4("Demographic Indicators"),  rHandsontableOutput("table4"),
                    br(),
                    tags$h4("Maternal and Newborn Health"),  rHandsontableOutput("table5"),
                    br(),
                    tags$h4("Access to Sexual and Reproductive Health"),  rHandsontableOutput("table6")),
             
             column(2,
                    br(),
                    br(),
                    downloadButton("downloadResults", "Download results")),
             br()
           )),
  
  tabPanel("Sources", style='padding-left:50px',
           tags$h1("Sources"),
           br(),
           tags$h4("Demographic indicators"),
           p("United Nations Population Division - World Population Prospect: 2019 Revision, accessible", tags$a(href="https://population.un.org/wpp/", "here")),
           br(),
           tags$h4("Modelled family planning indicators"),
           p("UN Population Division - World Contraceptive Use 2019, accessible", tags$a(href="https://www.un.org/en/development/desa/population/publications/dataset/contraception/wcu2019.asp", "here")),
           br(),
           tags$h4("STI prevalence"),
           p("Global Burden of Disease Study 2017 (GBD 2017) Results, accessible", tags$a(href="http://ghdx.healthdata.org/gbd-2017/data-input-sources", "here")),
           br(),
           tags$h4("HIV indicators"),
           p("UN AIDS - AIDS Info - 2019 Estimates, accessible", tags$a(href="https://aidsinfo.unaids.org/", "here")),
           br(),
           tags$h4("Child mortality estimates"),
           p("United Nations Inter-agency Group for Child Mortality Estimation (UN IGME), 2019, accessible", tags$a(href="https://www.unicef.org/reports/levels-and-trends-child-mortality-report-2019", "here")),
           br(),
           tags$h4("Maternal mortality estimates"),
           p("Trends in Maternal Mortality: 2000 to 2017, WHO, UNICEF, UNFPA, World Bank Group, UNFPA, 2019, accessible", tags$a(href="https://www.who.int/reproductivehealth/publications/maternal-mortality-2000-2017/en/", "here")),
           br(),
           tags$h4("Abortion laws"),
           p("Center for Reproductive Rights, The World's Abortion Laws, 2019, accessible", tags$a(href="https://reproductiverights.org/worldabortionlaws", "here"))
  )))