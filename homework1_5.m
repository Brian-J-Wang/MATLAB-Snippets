%CODE
Fminus1 = 1;
Fminus2 = 1;

while true
    
    Fminus1 = Fminus1 + Fminus2;
    Fminus2 = Fminus1 - Fminus2;
    if (Fminus1 >= 1000 && Fminus2 < 1000)
        break
    end
end

disp(Fminus2);
