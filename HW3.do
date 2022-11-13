** import data
import excel "/Users/gel2132/Downloads/sports-and-education.xlsx", sheet("sports-and-education") firstrow cle
> ar

** balance table data start with estout
estpost ttest AcademicQuality AthleticQuality NearBigMarket, by(Ranked2017) unequal welch

**make balance table
esttab . using "regressiontabell9.rtf", cell("mu_1(f(3)) mu_2(f(3)) b(f(3) star)") wide label collabels ("Control" "Treatment" "Difference") noobs 

**simple model
logit Ranked2017 AcademicQuality AthleticQuality NearBigMarket 

**predict propsenity score for each observation
predict propoensity_score, pr

**stacked histogram to show overlap with t and c
twoway histogram propensity_score, start(0) bc(red) freq || histogram propensity_score if Ranked2017==1, start(0) bc(blue) freq legend(order(1 "Treatment" 2 "Control")) xtitle("propensity score")

**ATT estimation with the Kernel Matching method (with blocks?)
attk AlumniDonations2018 Ranked2017 NearBigMarket AcademicQuality AthleticQuality, pscore(propensity_score) blockid(block) consump level(.001)

**reg alumnidonations propensity score
reg AlumniDonations2018 propensity_score NearBigMarket AcademicQuality AthleticQuality

**treatment effects propensity score matching
teffects psmatch (AlumniDonations2018) (Ranked2017 NearBigMarket AcademicQuality AthleticQuality)

