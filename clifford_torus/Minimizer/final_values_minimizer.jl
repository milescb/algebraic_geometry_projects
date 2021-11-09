using DataFrames, CSV, Statistics

df = CSV.read("/Users/milescochran-branson/OneDrive - Lawrence University/3.1_classes/Algebriac_geometry/Problem_14_Write-Up/julia_code/minimize_values10.txt", DataFrame)

#min_point_avg = sum.(eachcol(df)) ./ length(df[!, 1])
min_distance_avg = sum(df[!, 5]) / length(df[!, 5])
min_distance_std = std(df[!, 5])

d_min = df[1, 5]
min_point = [df[1,1], df[1, 2], df[1, 3], df[1, 4]]

for i in 2:length(df[!, 1])
    d_temp = df[i, 5]
    if d_temp < d_min
        global d_min = d_temp
        global min_point = [df[i,1], df[i, 2], df[i, 3], df[i, 4]]
    end;
end;

println(d_min)
println(min_point)