---
title: "eGFR_12m"
runtime: shiny
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Estimativa Filtração Glomerular em 1 ano no Transplante

Este calculador realiza a estimativa da filtração glomerular ao fim de um ano em receptores de transplante renais com doador falecido. Os dados necessários para o cálculo são características do doador e dados da biópsia tempo zero

```{r eruptions, echo=FALSE}
inputPanel(
   sliderInput("imc", label = "IMC Receptor (g/m2):",
              min = 0, max = 50, value = 25, step = 1),
  
  sliderInput("imc_doador", label = "IMC Doador (g/m2):",
              min = 0, max = 50, value = 25, step = 1),
  
  sliderInput("idade", label = "Idade do Doador (anos):",
              min = 0, max = 78, value = 40, step = 1),
  
  numericInput("creat", label = 'Creatinina Doador (mg/dl):',
               min = 0.5, max = 10, value = 1, step = 0.25),
  
  selectInput("has_doador", label = "Hipertensão Doador?:",
              choices = c('Nao', 'Sim'), selected = 'Nao'),
  
  selectInput("causa_morte", label = "Causa Morte Encefalica:",
              choices = c('TCE', 'Cerebrovascular', 'Sem Informacao', 'Outras'), selected = 'TCE'),
  
  selectInput("DGF", label = "Evolução para DGF Receptor?:",
              choices = c('Nao', 'Sim'), selected = 'Nao'),
  
  selectInput("rejeicao", label = "Rejeição Celular BPAR?:",
              choices = c('Nao', 'Sim'), selected = 'Nao')
)

renderText({
 
  causa_morte = ifelse(as.character(input$causa_morte == 'TCE'), 0, 
                       ifelse(as.character(input$causa_morte) == 'Cerebrovascular', -4.09, ifelse(as.character(input$causa_morte) == 'Sem Informacao', -3.56, -10.42)))
  
  has_doador = ifelse(as.character(input$has_doador) == 'Nao', 0, -3.7245)
  
  rejeicao = ifelse(as.character(input$rejeicao) == 'Nao', 0, -8.764)
  
  dgf = ifelse(as.character(input$DGF) == 'Nao', 0, -4.608)
  
  resultado = 100.54 + (input$imc * -0.706) + causa_morte + (input$imc_doador * 0.1766) + (log(input$creat) * -2.053) +
    (input$idade * -0.60738) + has_doador + rejeicao + dgf


paste('A Função Renal Estimada (ml/min) é: ', round(resultado, 2))
  

})
```




