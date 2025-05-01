{smcl}
{* 08feb2016}{...}
{cmd:help xtmixediou postestimation}{right: ({browse "http://www.stata-journal.com/article.html?article=st0487":SJ17-3: st0487})}
{hline}

{title:Title}

{p2colset 5 34 36 2}{...}
{p2col :{hi:xtmixediou postestimation} {hline 2}}Obtains predictions after estimation of the linear mixed-effects integrated Ornstein-Uhlenbeck model{p_end}
{p2colreset}{...}


{title:Syntax for predict}

{p 8 15 2}
{cmd:predict} {newvar} {ifin} 
[{cmd:,} {it:options}] 

{synoptset 10}{...}
{synopthdr}
{synoptline}
{synopt :{opt xb}}calculate linear prediction for the fixed portion of the model only; the default{p_end}
{synopt :{opt stdp}}calculate standard error of the fixed portion linear prediction{p_end}
{synopt :{opt fit:ted}}calculate fitted values{p_end}
{synopt :{opt res:iduals}}calculate residuals{p_end}
{synoptline}


{title:Description}

{pstd}
{cmd:predict} creates a new variable containing predictions such as linear
predictions, standard errors, fitted values, and residuals.


{title:Options}

{phang}
{opt xb}, the default, calculates the linear prediction for the fixed
portion of the model only.

{phang}
{opt stdp} calculates the standard error of the fixed portion linear
prediction.

{phang}
{opt fitted} calculates the fitted values, that is, the fixed portion linear
prediction plus contributions based on predicted random effects and the
realizations of the integrated Ornstein-Uhlenbeck (or Brownian motion)
process.

{phang}
{opt residuals} calculates the residuals, that is, the response minus fitted
values.


{title:Examples}

{phang}
Generate linear prediction for the fixed portion of the model{p_end}
{space 10}{cmd:. predict xbvar} 
{space 4}or 
{space 10}{cmd:. predict xbvar, xb}

{phang}
Generate standard error of the linear predictor xb{p_end}
{space 10}{cmd:. predict stdpvar, stdp}

{phang}
Generate fitted values{p_end}
{space 10}{cmd:. predict fittedvar, fit}

{phang}
Generate (level-1) residuals{p_end}
{space 10}{cmd:. predict residualvar, res}


{title:Author}

{pstd}
Rachael A. Hughes{break}
Bristol Medical School{break}
University of Bristol{break}
Bristol, UK{break}
rachael.hughes@bristol.ac.uk{break}


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 17, number 3: {browse "http://www.stata-journal.com/article.html?article=st0487":st0487}{p_end}

{p 7 14 2}Help:  {helpb xtmixediou} (if installed){p_end}
