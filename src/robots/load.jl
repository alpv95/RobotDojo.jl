RESIDUAL_EXPR = Dict{String, Any}()
residual_expr(model::Model) = RESIDUAL_EXPR[String(name(model)) * "_r"]
jacobian_var_expr(model::Model) = RESIDUAL_EXPR[String(name(model)) * "_rz"]
jacobian_data_expr(model::Model) = RESIDUAL_EXPR[String(name(model)) * "_rθ"]

path_robots = @get_scratch!("robots")

robots = [hopper]#, biped, quadruped]

for robot in robots
    path = joinpath(path_robots, String(name(robot)) * ".jld2")
    @load path r_model rz_model rθ_model
    RESIDUAL_EXPR[String(name(robot)) * "_r"] = eval(r_model)
    RESIDUAL_EXPR[String(name(robot)) * "_rz"] = eval(rz_model)
    RESIDUAL_EXPR[String(name(robot)) * "_rθ"] = eval(rθ_model)
end