{smcl}
{* 26apr2017}{...}
{cmd:help xtmixediou}{right: ({browse "http://www.stata-journal.com/article.html?article=st0487":SJ17-3: st0487})}
{hline}

{title:Title}

{p2colset 5 19 16 2}{...}
{p2col :{cmd:xtmixediou} {hline 2}}Linear mixed-effects integrated Ornstein-Uhlenbeck model{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 18 2}
{cmd:xtmixediou} {depvar} [{indepvars}] {ifin}{cmd:,}
{cmd:id(}{it:{help varname:levelvar}}{cmd:)}
{cmd:time(}{it:{help varname:timevar}}{cmd:)}
[{it:options}] 

{synoptset 28 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent :* {opt id(levelvar)}}define the group structure variable for the random effects{p_end}
{p2coldent :* {opt time(timevar)}}define the variable for the measurement times of {it:depvar}{p_end}
{synopt :{opt nofec:onstant}}suppress the constant term for the fixed portion of the model{p_end}
{synopt :{opt re:ffects(varlist)}}define the random effects of the model{p_end}
{synopt :{opt norec:onstant}}suppress the constant term for the random portion of the model{p_end}
{synopt :{cmd:iou(}{it:{help xtmixediou##ioutype:ioutype}}{cmd:)}}specify the parameterization of the integrated Ornstein-Uhlenbeck (IOU) process used in estimation{p_end}
{synopt :{opt brown:ian}}specify a scaled Brownian motion (BM) process, which is a special case of the IOU process{p_end}
{synopt :{opt svdata:derived}}starting values derived from the data{p_end}
{synopt :{opt alg:orithm(algorithm_spec)}}maximization algorithm{p_end}
{synopt :{opt iter:ate(#)}}perform maximum of # iterations; default is {cmd:iterate(16000)}{p_end}
{synopt :{opt dif:ficult}}use a different stepping algorithm in nonconcave regions{p_end}
{synopt :{opt nolo:g}}suppress the display of iteration log{p_end}
{synopt :{opt tr:ace}}display the current parameter vector in iteration log{p_end}
{synopt :{opt grad:ient}}display the current gradient in iteration log{p_end}
{synopt :{opt showstep}}report steps within an iteration log{p_end}
{synopt :{opt hess:ian}}display the current Hessian matrix in iteration log{p_end}
{synoptline}
{p 4 6 2}* {cmd:id()} and {cmd:time()} are required.

{marker algorithm_spec}{...}
{p 4 6 2}
where {it:algorithm_spec} is

{p 8 8 2}
{it:algorithm} [{it:#} [{it:algorithm} [{it:#}]] ...]

{p 4 6 2}
and {it:algorithm} is {c -(}{opt nr}|{opt fs}|{opt ai}{c )-}.{p_end}

{marker ioutype}{...}
{synoptset 10}{...}
{synopthdr :ioutype}
{synoptline}
{synopt :{opt at}}IOU parameterization is alpha and tau, the default{p_end}
{synopt :{opt ao}}IOU parameterization is alpha and omega = (tau{c 178}/alpha{c 178}){p_end}
{synopt :{opt lnat}}IOU parameterization is ln(alpha) and tau{p_end}
{synopt :{opt lnao}}IOU parameterization is ln(alpha) and omega = (tau{c 178}/alpha{c 178}){p_end}
{synopt :{opt isat}}IOU parameterization is 1/(alpha{c 178}) and tau{p_end}
{synopt :{opt isao}}IOU parameterization is 1/(alpha{c 178}) and omega = (tau{c 178}/alpha{c 178}){p_end}
{synoptline}


{title:Description}

{pstd}
{cmd:xtmixediou} fits a two-level linear mixed-effects model with an added IOU
nonstationary stochastic process that can be applied to balanced and
unbalanced longitudinal continuous data.  The model allows for different
levels of derivative tracking (that is, the degree to which a subject's
longitudinal measurements maintain the same trajectory over long periods of
time).  Note that a linear mixed-effects model without an IOU process assumes
strong derivative tracking (that is, a subject's measurements follow the same
trajectory over long periods).  The IOU process also allows the variance of
the within-subject errors to change over time and allows for serial
correlation, where the correlation between two measurements (within a subject)
decreases with increasing time difference.

{pstd}
The IOU process is parameterized by two parameters, alpha and tau (or
functions of alpha and tau).  Parameter alpha is a measure of the degree of
derivative tracking, where a small value indicates strong derivative tracking.
Parameter tau serves as a scaling parameter.  As alpha tends toward infinity
and the ratio tau{c 178}/alpha{c 178} is held constant, the IOU process
becomes the scaled BM process, which is parameterized by a single parameter,
phi.

{pstd}
The overall error distribution of the linear mixed-effects model is assumed to
be Gaussian.  The model is fit using restricted maximum-likelihood (REML)
estimation.
 

{title:Options}

{phang}
{opt id(levelvar)} defines the variable for identifying individuals (that is,
the level-2 units).  {it:levelvar} may be a numeric variable or a string
variable.  {cmd:id()} is required.

{phang}
{opt time(timevar)} defines the numeric variable for the observation time
points of {it:depvar}.  {cmd:time()} is required.

{phang}
{opt nofeconstant} suppresses the constant term for the fixed portion of the
model.  By default, a constant term is included in the fixed portion of the
model.

{phang}
{opt reffects(varlist)} defines the random effects of the model.
{cmd:xtmixediou} automatically includes a constant term in the random effects.
For two or more random effects, an unstructured covariance matrix is assumed
(that is, all variances and covariances are distinctly estimated).  Factor
variables are not allowed.  The default is a random intercept.

{phang}
{opt noreconstant} suppresses the constant term for the random effects of the
model.  By default, a constant term is included in the random portion of the
model.

{phang}
{opt iou(ioutype)} specifies the parameterization of the IOU process used
during REML estimation.  Six different parameterizations of the IOU process
are allowed (see {it:{help xtmixediou##ioutype:ioutype}}).  The default
parameterization is alpha and tau ({cmd:iou(at)}).  Changing the IOU
parameterization may improve convergence.  For example, parameterizations
ln(alpha) or 1/(alpha{c 178}) may be useful if alpha is suspected to be large.
There is no guarantee that the other parameterizations work better than the
default.

{phang}
{opt brownian} specifies a scaled BM process, a special case of the IOU
process that is parameterized by a single parameter, phi.  The BM process
represents no derivative tracking, and the fitted model then becomes the
linear mixed-effects BM model.

{phang}
{opt svdataderived} specifies that the starting values of all of the model's
variance parameters (that is, the random-effects variances and covariances,
IOU or BM parameters, and measurement-error variance) are derived from the
data.  The option {cmd:svdataderived} assumes the user specified (using the
{cmd:reffects()} or {cmd:noreconstant} option) that the random effects include
only a random intercept, a random linear slope, or both.  The default fits a
linear mixed-effects model -- without an added IOU or BM process -- using
Stata's {cmd:mixed} command.  The resulting expectation-maximization
estimates are used as the starting values for the random-effects variances and
covariances as well as the measurement-error variance, while the starting
values for the IOU or BM parameters are set to small positive values (that is,
representing strong derivative tracking).  {cmd:xtmixediou} saves the starting
values to matrix {cmd:e(sv)}.

{phang}
{opt algorithm(algorithm_spec)} specifies the optimization algorithm to use to
perform REML estimation.  The following algorithms are allowed:

{pmore}
{cmd:algorithm(nr)}, the default, specifies the Newton-Raphson (NR) algorithm.

{pmore}
{cmd:algorithm(fs)} specifies the Fisher scoring (FS) algorithm.

{pmore}
{cmd:algorithm(ai)} specifies the average information algorithm.

{pmore}
You can switch between algorithms by specifying more than one in the
{cmd:algorithm()} option.  By default, an algorithm is used for five
iterations before switching to the next algorithm.  To specify a different
number of iterations, include the number after the algorithm's abbreviation in
the option.  For example, specifying {cmd:algorithm(fs 10 nr 100)} requests
10 iterations with the FS algorithm, followed by 100 iterations with the NR
algorithm, then another 10 iterations with the FS algorithm, and so on.  The
process continues until convergence or until the maximum number of iterations
is reached.

{pmore}  
Convergence of the NR algorithm may be improved by starting with a few (say,
three) iterations of the FS or average information algorithm, especially when
the starting values of the parameters are suspected to be far from the REML
estimates.

{phang}
{opt iterate(#)} specifies the maximum number of iterations.  When the number
of iterations equals {cmd:iterate()}, the optimizer stops and presents the
current results.  If convergence is declared before this threshold is reached,
it will stop when convergence is declared.  The default is
{cmd:iterate(16000)}.

{phang}
{opt difficult} specifies that the likelihood function will probably be
difficult to maximize because of  nonconcave regions (that is, when the
message "not concave" appears repeatedly)  and that the standard stepping
algorithm is not working well.  {opt difficult} specifies that a different
stepping algorithm be used in the nonconcave regions.  There is no guarantee
that {opt difficult} will work better than the default. You should use the
{opt difficult} option only when the default stepper declares convergence and
the last iteration is "not concave" or when the default stepper is repeatedly
issuing "not concave" messages and producing only tiny improvements in the log
likelihood.

{phang}
{opt nolog} suppresses the display of the iteration log showing the progress
of the log likelihood.  The log is displayed by default.

{phang}
{opt trace} adds a display of the current parameter vector to the iteration
log.

{phang}
{opt gradient} adds a display of the current gradient vector to the iteration
log.

{phang}
{opt showstep} adds a report on the steps within an iteration to the iteration
log.

{phang}
{opt hessian} adds a display of the current negative Hessian matrix to the
iteration log.


{title:Examples}

{pstd}
Random intercept IOU model{p_end}
{phang2}{cmd:. xtmixediou ln_cd4 measurement age sex, id(patient_id) time(measurement)}

{pstd}
Random intercept and random slope IOU model, with the IOU process
parameterized as eta = ln(alpha) and tau{p_end}
{phang2}{cmd:. xtmixediou ln_cd4 measurement age sex, id(patient_id) time(measurement) re(measurement) iou(et)}

{pstd}
Random intercept and random slope IOU model, with all starting values derived
from the data{p_end}
{phang2}{cmd:. xtmixediou ln_cd4 measurement age sex, id(patient_id) time(measurement) re(measurement) svdata}

{pstd}
Random intercept and random slope IOU model, with estimation performed using
10 FS iterations followed by 100 NR iterations{p_end}
{phang2}{cmd:. xtmixediou ln_cd4 measurement age sex, id(patient_id) time(measurement) re(measurement) algorithm(fs 10 nr 100)}


{title:Stored results}

{phang}
{cmd:xtmixediou} stores the following in {cmd:e():}

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Scalars}{p_end}
{synopt :{cmd:e(N)}}number of observations{p_end}
{synopt :{cmd:e(k)}}number of parameters{p_end}
{synopt :{cmd:e(k_f)}}number of fixed-effects parameters{p_end}
{synopt :{cmd:e(k_r)}}number of random-effects parameters{p_end}
{synopt :{cmd:e(k_res)}}number of residual-error parameters{p_end}
{synopt :{cmd:e(ll_reml)}}restricted log likelihood{p_end}
{synopt :{cmd:e(converged)}}{cmd:1} if converged, {cmd:0} otherwise{p_end}

{p2col 5 15 19 2: Macros}{p_end}
{synopt :{cmd:e(cmd)}}{cmd:xtmixediou}{p_end}
{synopt :{cmd:e(cmdline)}}command as typed{p_end}
{synopt :{cmd:e(depvar)}}dependent variable{p_end}
{synopt :{cmd:e(title)}}title in estimation output{p_end}
{synopt :{cmd:e(id)}}variable identifying level-2 units{p_end}
{synopt :{cmd:e(time)}}{it:timevar}, the time-point variable for {it:depvar}{p_end}
{synopt :{cmd:e(revars)}}random-effects variables{p_end}
{synopt :{cmd:e(redim)}}random-effects dimension{p_end}
{synopt :{cmd:e(iou)}}{cmd:iou()} specification{p_end}
{synopt :{cmd:e(method)}}{cmd:REML}{p_end}
{synopt :{cmd:e(ml_method)}}type of {cmd:ml} method{p_end}
{synopt :{cmd:e(opt)}}type of optimization{p_end}
{synopt :{cmd:e(predict)}}program used to implement {cmd:predict}{p_end}
{synopt :{cmd:e(properties)}}{cmd:b V}{p_end}

{p2col 5 15 19 2: Matrices}{p_end}
{synopt :{cmd:e(b)}}coefficient vector{p_end}
{synopt :{cmd:e(V)}}variance-covariance matrix of the estimators{p_end}
{synopt :{cmd:e(sv)}}starting values of the variance parameters{p_end}
{synopt :{cmd:e(N_g)}}group counts{p_end}
{synopt :{cmd:e(g_min)}}group-size minimum{p_end}
{synopt :{cmd:e(g_avg)}}group-size average{p_end}
{synopt :{cmd:e(g_max)}}group-size maximum{p_end}

{p2col 5 15 19 2: Functions}{p_end}
{synopt :{cmd:e(sample)}}marks estimation sample{p_end}


{title:Author}

{pstd}
Rachael A. Hughes{break}
Bristol Medical School{break}
University of Bristol{break}
Bristol, UK{break}
rachael.hughes@bristol.ac.uk{break}


{title:Also see}

{p 4 14 2}Article:  {it:Stata Journal}, volume 17, number 3: {browse "http://www.stata-journal.com/article.html?article=st0487":st0487}{p_end}

{p 7 14 2}Help:  {help xtmixediou postestimation} (if installed){p_end}
