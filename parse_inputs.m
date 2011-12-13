function [options] = ...
    parse_inputs(options)
% Parse input PV pairs.

%=== allowed parameters
okargs=fieldnames(options);

%=== defaults
def_options=struct( ...
    'Display', 'Plot', ...
    'MaxIterations', 100, ...
    'PopulationSize', 50, ...
    'MaxFeatures', 0, ...
    'MinFeatures', 0, ...
    'ConfoundingFactors', [], ...
    'Repetitions', 100, ...
    'OptDir', 0, ...
    'FitnessFcn', 'fit_LR', ...% This should have the exact same name as the .m function
    'CostFcn', 'cost_RMSE', ... % This should have the exact same name as the .m function
    'CrossoverFcn', 'crsov_SP', ... % This should have the exact same name as the .m function
    'MutationFcn', 'mut_SP', ...
    'MutationRate', 0.06, ...
    'CrossValidationFcn', 'xval_None', ...
    'CrossValidationParam',[], ...
    'PlotFcn', 'plot_All', ...% This should have the exact same name as the .m function
    'ErrorGradient', 0.01, ...
    'ErrorIterations', 10, ...
    'FileName',[], ...
    'Parallelize', 0, ...
    'Elitism',10 , ...
    'MinimizeFeatures',false, ...
    'PopulationEvolutionAxe', [],...
    'FitFunctionEvolutionAxe', [],...
    'CurrentPopulationAxe', [],...
    'CurrentScoreAxe', []...
    );

def_fn=fieldnames(def_options);

%=== parse inputs, replace empty fields with default values
for k = 1:length(def_fn)
    idx=strcmp(okargs,def_fn{k});
    if isempty(options.(okargs{idx}))
        options.(okargs{idx})=def_options.(okargs{idx});
    end
end


% Parse functions
opt_fn=fieldnames(options);
fcn_idx=strfind(opt_fn, 'Fcn'); % Find field names which store functions
fcn_idx=find(cellfun(@(x) ~isempty(x),fcn_idx)==1);
for k=1:length(fcn_idx)
    % Parse functions into cells containing function handles
    [options.(opt_fn{fcn_idx(k)})] = ...
        parse_functions(opt_fn{fcn_idx(k)},options.(opt_fn{fcn_idx(k)}));
end

%TODO: Check xvalFcn and xvalParam are internally consistent
end
