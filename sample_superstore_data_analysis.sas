Title'Analysis of Sample Superstore data';

/* Sample SuperStore Data importing */;
FILENAME REFFILE '/home/u63515412/data/SampleSuperstore.csv';

PROC IMPORT DATAFILE=REFFILE DBMS=CSV OUT=WORK.store;
	GETNAMES=YES;
RUN;

/* 	sst data with name samstore */;

data samstore;
	set work.store;

proc print data=samstore (obs=15);
	/* Data Sorting and Missing Value Analysis */;

proc sort data=samstore nodupkey;
	by _all_;

PROC MEANS data=samstore nmiss;
	var postal_code sales quantity profit discount;

proc freq data=work.samstore;
	table Ship_Mode Segment Country State Region Category Sub_Category Quantity 
		Discount / missing;

	/* Descriptive Statistics */;

proc means data=samstore n max mean median mode var stddev;
	var Sales quantity discount profit;
	title 'Descriptive Statistics';

	/* Graphical Presentation of data */;

proc sgplot data=samstore;
	vbar ship_mode;
	xaxis grid;
	yaxis grid;
run;

proc gchart data=samstore;
	pie3d segment / explode='cunsumer' plabel=(h=1.8 color=red);
	;
	run;

proc sgplot data=samstore;
	vbar state / group=city groupdisplay=stack;
run;

proc sgplot data=samstore;
	vbar category / group=sub_category groupdisplay=cluster;
	xaxis grid;
	yaxis grid;
run;

proc sgplot data=samstore;
	vbox sales / group=ship_mode;
	title 'boxplot of variable(sales)';
	xaxis grid;
	yaxis grid;
run;

proc univariate data=samstore;
	hist profit / normal;
	title 'Histogram of variable(profit)';
run;

proc corr data=samstore;
	var sales discount quantity profit;

proc sgscatter data=samstore;
	matrix sales discount quantity profit;