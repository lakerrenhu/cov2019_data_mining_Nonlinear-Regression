data ag;
input 
day	daily_cases	age6 age7 age8 age9 age10 age11 cumu_cases	Tage6	
Tage7	Tage8	Tage9	Tage10	Tage11;
datalines;
3	3	0	1	2	0	0	0	3	0	1	
2	0	0	0
6	1	0	0	0	1	0	0	4	0	1	
2	1	0	0
7	2	0	0	1	1	0	0	6	0	1	
3	2	0	0
8	3	1	2	0	0	0	0	9	1	3	
3	2	0	0
9	2	0	0	2	0	0	0	11	1	3	
5	2	0	1
10	2	0	1	1	0	0	0	13	1	4	
6	2	0	1
12	8	3	0	4	1	0	0	21	4	4	
10	3	0	0
13	10	0	4	2	3	1	0	31	4	8	
12	6	1	4
14	9	3	3	2	1	0	0	40	7	11	
14	7	1	0
15	9	4	1	2	1	1	0	49	11	12	
16	8	2	0
16	17	6	4	3	4	0	0	66	17	16	
19	12	2	0
17	18	8	5	3	2	0	0	84	25	21	
22	14	2	0
18	26	6	10	5	4	1	0	110	31	31	
27	18	3	0
19	39	11	12	10	5	1	0	149	42	43	
37	23	4	0
20	49	13	16	9	8	3	0	198	55	59	
46	31	7	0
21	77	21	21	15	16	4	0	275	76	80	
61	47	11	0
22	54	13	12	14	13	2	0	329	89	92	
75	60	13	0
23	72	28	24	12	6	2	0	401	117	116	
87	66	15	0
24	143	38	42	37	21	5	0	544	155	158	
124	87	20	0
25	145	43	34	32	24	12	0	689	198	192	
156	111	32	0
26	191	46	62	47	22	14	0	880	244	254	
203	133	46	0
27	198	64	52	43	34	5	0	1078	308	306	
246	167	51	0
28	254	75	74	50	34	21	0	1332	383	380	
296	201	72	0
29	232	57	82	53	31	9	0	1564	440	462	
349	232	81	0
30	296	99	88	68	22	19	0	1860	539	550	
417	254	100	0
31	334	93	108	70	45	18	0	2194	632	658	
487	299	118	0
32	382	121	108	95	36	22	0	2576	753	766	
582	335	140	0
33	380	116	103	82	51	27	1	2956	869	869	
664	386	167	1
34	354	111	111	71	45	15	1	3310	980	980	
735	431	182	2
35	243	64	70	61	30	17	1	3553	1044	1050	
796	461	199	3
36	372	122	96	88	48	16	2	3925	1166	1146	
884	509	215	5
37	315	94	103	59	40	18	1	4240	1260	1249	
943	549	233	6
38	361	102	102	63	50	44	0	4601	1362	1351	
1006	599	277	6
39	322	97	86	62	47	29	1	4923	1459	1437	
1068	646	306	7
40	378	106	107	81	52	32	0	5301	1565	1544	
1149	698	338	7
41	343	108	105	68	39	21	2	5644	1673	1649	
1217	737	359	9
42	274	95	59	47	44	28	1	5918	1768	1708	
1264	781	387	10
43	323	90	110	60	31	31	1	6241	1858	1818	
1324	812	418	11
44	225	61	62	51	29	22	0	6466	1919	1880	
1375	841	440	11
45	104	25	37	22	12	8	0	6570	1944	1917	
1397	853	448	11
;
proc print data =ag;
run;

title "Scatterplots of total number of cases in age group 6-11";
symbol1 interpol = join
        value=three
		color = black;

symbol2 interpol=join
        value=Triangle
        color= red;

symbol3 interpol=join
        value=Dot
        color= Blue ;

symbol4 interpol=join
        value=square
        color= purple ;

symbol5 interpol=join
        value=Dash
        color= brown ;

symbol6 interpol=join
        value=star
        color= orange ;

legend1  label=none
        position=(bottom center outside);

*plot the sactterplots of all age groups;
proc gplot data = ag; 
plot (Tage6 Tage7 Tage8 Tage9 Tage10 Tage11)*day  /overlay  legend = legend1; 
run;



*poisson dist;
proc genmod data = ag;
model Tage6 = day /  dist = Poisson link = log type3;
output out = new1 p = pv6 ;   * output statement creates an output file "new" that 
includes predicted means;
run;
proc print data = new1;
var day Tage6 pv6;
run;

proc genmod data = ag;
model Tage7 = day /  dist = Poisson link = log type3;
output out = new2 p = pv7 ;   * output statement creates an output file "new" that 
includes predicted means;
run;

proc genmod data = ag;
model Tage8 = day /  dist = Poisson link = log type3;
output out = new3 p = pv8 ;   * output statement creates an output file "new" that 
includes predicted means;
run;

proc genmod data = ag;
model Tage9 = day /  dist = Poisson link = log type3;
output out = new4 p = pv9 ;   * output statement creates an output file "new" that 
includes predicted means;
run;

proc genmod data = ag;
model Tage10 = day /  dist = Poisson link = log type3;
output out = new5 p = pv10 ;   * output statement creates an output file "new" that 
includes predicted means;
run;

proc genmod data = ag;
model Tage11 = day /  dist = Poisson link = log type3;
output out = new6 p = pv11 ;   * output statement creates an output file "new" that 
includes predicted means;
run;

data all;
merge new1 new2 new3 new4 new5 new6;
run;
 proc print data = all (obs=10);
run;

title "Trends of total number of cases in age group 6-11 (Poisson)";
symbol1 interpol = none
        value=circle
		color = black;
symbol2 interpol = join
        value=circle
		color = black;
symbol3 interpol=none
        value=Triangle
        color= red;
symbol4 interpol=join
        value=Triangle
        color= red;
symbol5 interpol=none
        value=Dot
        color= Blue ;
symbol6 interpol=join
        value=Dot
        color= Blue ;
symbol7 interpol=none
        value=square
        color= purple ;
symbol8 interpol=join
        value=square
        color= purple ;
symbol9 interpol=none
        value=Dash
        color= brown ;
symbol10 interpol=join
        value=Dash
        color= brown ;

symbol11 interpol=none
        value=plus
        color= orange;
symbol12 interpol=join
        value=plus
        color= orange ;

legend2  label=none
        position=(bottom center outside);

*plot the sactterplots of all age groups;
proc gplot data = all; 
plot (Tage6 pv6 Tage7 pv7 Tage8 pv8 Tage9 pv9 Tage10 pv10 Tage11 pv11)*day  /overlay 
 legend = legend2; 
run;



*MM model;
proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage6 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new1 p= p6 r=resid;
run;

proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage7 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new2 p= p7 r=resid;
run;

proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage8 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new3 p= p8 r=resid;
run;

proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage9 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new4 p= p9 r=resid;
run;

proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage10 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new5 p= p10 r=resid;
run;

proc nlin data = ag; 
parms  theta1 = -18.36  theta2 = -18.69  theta3=-0.0145;
model Tage11 = theta1*day/ (theta2 + day + theta3*day*day);
output out = new6 p= p11 r=resid;
run;

data all;
merge new1 new2 new3 new4 new5 new6;
run;
 proc print data = all (obs=10);
run;

title "Trends of total number of cases in age group 6-11 (MM model)";
symbol1 interpol = none
        value=circle
		color = black;
symbol2 interpol = join
        value=circle
		color = black;
symbol3 interpol=none
        value=Triangle
        color= red;
symbol4 interpol=join
        value=Triangle
        color= red;
symbol5 interpol=none
        value=Dot
        color= Blue ;
symbol6 interpol=join
        value=Dot
        color= Blue ;
symbol7 interpol=none
        value=square
        color= purple ;
symbol8 interpol=join
        value=square
        color= purple ;
symbol9 interpol=none
        value=Dash
        color= brown ;
symbol10 interpol=join
        value=Dash
        color= brown ;

symbol11 interpol=none
        value=plus
        color= orange;
symbol12 interpol=join
        value=plus
        color= orange ;

legend1  label=none
        position=(bottom center outside);

*plot the sactterplots of all age groups;
proc gplot data = all; 
plot (Tage6 p6 Tage7 p7 Tage8 p8 Tage9 p9 Tage10 p10 Tage11 p11)*day  /overlay  
legend = legend1; 
run;
