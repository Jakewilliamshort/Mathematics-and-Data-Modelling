load('turbine_data.mat')

freq = reshape(turbine1_frequency,[length(turbine1_frequency),1]);
log_freq = log(freq);
log_freq_sq = log_freq.^2;

m1AIC = zeros(length(turbine1_hhwsp),1);
m2AIC = zeros(length(turbine1_hhwsp),1);

for i = 1:length(turbine1_hhwsp)
    noise = reshape(turbine1_measured_noise(i,:), ...
                    [length(turbine1_frequency),1]);
    data1 = table(freq,noise);
    data2 = table(log_freq,log_freq_sq,noise);

    m1 = fitlm(data1,'noise~freq');
    m2 = fitlm(data2,'noise~log_freq+log_freq_sq');
    m1AIC(i) = m1.ModelCriterion.AIC;
    m2AIC(i) = m2.ModelCriterion.AIC;
end

freq = reshape(turbine2_frequency,[length(turbine2_frequency),1]);
log_freq = log(freq);
log_freq_sq = log_freq.^2;

m3AIC = zeros(length(turbine2_hhwsp),1);
m4AIC = zeros(length(turbine2_hhwsp),1);

for i = 1:length(turbine2_hhwsp)
    noise = reshape(turbine2_measured_noise(i,:), ...
                    [length(turbine2_frequency),1]);
    data3 = table(freq,noise);
    data4 = table(log_freq,log_freq_sq,noise);

    m3 = fitlm(data3,'noise~freq');
    m4 = fitlm(data4,'noise~log_freq+log_freq_sq');
    m3AIC(i) = m3.ModelCriterion.AIC;
    m4AIC(i) = m4.ModelCriterion.AIC;
end

means = zeros(4,1);
stds = zeros(4,1);

means(1) = mean(m1AIC);
stds(1) = std(m1AIC);

means(2) = mean(m2AIC);
stds(2) = std(m2AIC);

means(3) = mean(m3AIC);
stds(3) = std(m3AIC);

means(4) = mean(m4AIC);
stds(4) = std(m4AIC);
