"""
prog_2.jl

Reads xmin, xmax, n from prog_2.dat,
computes y = x + sin(pi*x),
writes results to prog_2.res,
prints the table to console,
and plots the graph.
"""

using Printf
using Plots

function main()
    input_file = "prog_2.dat"
    if !isfile(input_file)
        println("Input file '", input_file, "' not found.")
        return
    end

    open(input_file, "r") do io
        line1 = readline(io)
        parts = split(strip(line1))
        if length(parts) < 3
            error("First line of $input_file must contain xmin xmax n")
        end
        xmin = parse(Float64, parts[1])
        xmax = parse(Float64, parts[2])
        n = parse(Int, parts[3])

        author = !eof(io) ? strip(readline(io)) : ""

        step = (xmax - xmin) / (n - 1)

        xs = [xmin + i*step for i in 0:(n-1)]
        ys = [x + sin(pi*x) for x in xs]

        # --- Write to file ---
        open("prog_2.res", "w") do out
            println(out, "*")
            println(out, "Function: y = x + sin(pi*x)")
            println(out, "*")
            println(out, "   X        |       Y")
            println(out, "---------------------------")
            for (x, y) in zip(xs, ys)
                @printf(out, "%8.4f   %10.6f\n", x, y)
            end
            println(out, "---------------------------")
            println(out, "Prepared by: \"Aruzhan Bolatkhan\", " * author)
        end

        # --- Display on screen (as a table) ---
        println("\nTable of results:")
        println("   X        |       Y")
        println("---------------------------")
        for (x, y) in zip(xs, ys)
            @printf("%8.4f   %10.6f\n", x, y)
        end
        println("---------------------------")

        println("\nResults written to prog_2.res")

        # --- Plot ---
        plot(xs, ys,
            title = "Graph of y = x + sin(pi*x)",
            xlabel = "x",
            ylabel = "y",
            lw = 2,
            legend = false,
            grid = true)
        savefig("prog_2.png")
        println("Graph saved to prog_2.png")
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
