libname wd '/home/xxxxx/analytics';

data wd.marketing(drop=base);
    call streaminit(2025);

    array adtypes[3] $ _temporary_ ("Image" "Video" "Carousel");
    array segments[3] $ _temporary_ ("New" "Returning" "HighValue");
    array platforms[3] $ _temporary_ ("Facebook" "Instagram" "Google");

    do CustomerID = 1 to 600; 
        /* Assign factors */
        AdType   = adtypes[ceil(rand("uniform")*3)];
        Segment  = segments[ceil(rand("uniform")*3)];
        Platform = platforms[ceil(rand("uniform")*3)];

        /* Base conversion rate depending on AdType */
        if AdType="Image"     then base = rand("normal", 40, 8);
        if AdType="Video"     then base = rand("normal", 60, 10);
        if AdType="Carousel"  then base = rand("normal", 55, 9);

        /* Segment effects */
        if Segment="New"       then base = base - rand("normal", 5, 2);
        if Segment="Returning" then base = base + rand("normal", 8, 2);
        if Segment="HighValue" then base = base + rand("normal", 12, 3);

        /* Platform effects */
        if Platform="Google"    then base = base + rand("normal", 5, 2);
        if Platform="Facebook"  then base = base + rand("normal", 0, 2);
        if Platform="Instagram" then base = base - rand("normal", 3, 2);

        /* Rounded conversions to 2 decimal places */
        Conversions = round(base, 0.01);

        output;
    end;
run;



proc print data=wd.marketing;
run;

proc delete data=wd.marketing;
run;