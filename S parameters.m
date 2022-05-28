
numfiles = 12;
filename = "AWS_Filter_"+(1:numfiles)+".s2p";    % Construct filenames
S = sparameters(filename(1));                    % Read file #1 for initial set-up
freq = S.Frequencies;                            % Frequency values are the same for all files
numfreq = numel(freq);                           % Number of frequency points
s21_data = zeros(numfreq,numfiles);              % Preallocate for speed
s21_groupdelay = zeros(numfreq,numfiles);        % Preallocate for speed

% Read Touchstone files
for n = 1:numfiles
    S = sparameters(filename(n));
    s21 = rfparam(S,2,1);
    s21_data(:,n) = s21;
    s21_groupdelay(:,n) = groupdelay(S,freq,2,1); 
end
s21_db = 20*log10(abs(s21_data));

figure
plot(freq/1e9,s21_db)
xlabel('Frequency (GHz)')
ylabel('Filter Response (dB)')
title('Transmission performance of 12 filters')
axis on
grid on
idx = (freq >= 2.11e9) & (freq <= 2.17e9);
s21_pass_data = s21_data(idx,:);
s21_pass_db = s21_db(idx,:);
freq_pass_ghz = freq(idx)/1e9; % Normalize to GHz

plot(freq_pass_ghz,s21_pass_db)
xlabel('Frequency (GHz)')
ylabel('Filter Response (dB)')
title('Passband variation of 12 filters')
axis([min(freq_pass_ghz) max(freq_pass_ghz) -1 0])
grid on
plot(freq_pass_ghz,mean_abs_S21_freq,'m')
hold on
plot(freq_pass_ghz,mean_abs_S21_freq + 2*std_abs_S21_freq,'r')
plot(freq_pass_ghz,mean_abs_S21_freq - 2*std_abs_S21_freq,'k')
legend('Mean','Mean + 2*STD','Mean - 2*STD')
plot(freq_pass_ghz,abs_S21_pass_freq,'c','HandleVisibility','off')
grid on
axis([min(freq_pass_ghz) max(freq_pass_ghz) 0.9 1])
ylabel('Magnitude S21')
xlabel('Frequency (GHz)')
title('S21 (Magnitude) - Statistical Analysis')
hold off
histfit(abs_S21_pass_freq(:))
grid on
axis([0.8 1 0 100])
xlabel('Magnitude S21')
ylabel('Distribution')
title('Compare filter passband response vs. a normal distribution')
plot(freq_pass_ghz_gpd,mean_grpdelay_S21,'m')
hold on
plot(freq_pass_ghz_gpd,mean_grpdelay_S21 + 2*std_grpdelay_S21,'r')
plot(freq_pass_ghz_gpd,mean_grpdelay_S21 - 2*std_grpdelay_S21,'k')
legend('Mean','Mean + 2*STD','Mean - 2*STD')
plot(freq_pass_ghz_gpd,s21_groupdelay_pass_data,'c','HandleVisibility','off')
grid on
xlim([min(freq_pass_ghz_gpd) max(freq_pass_ghz_gpd)])
ylabel('Normalized group delay S21')
xlabel('Frequency (GHz)')
title('S21 (Normalized group delay) - Statistical Analysis')
hold off
ylabel('Magnitude S21')
xlabel('Frequency (GHz)')
ax1 = gca;
ax1.XTick = 0.5:10:120.5;
ax1.XTickLabel = {2.11,'',2.12,'',2.13,'',2.14,'',2.15,'',2.16,'',2.17};
title('Analysis of variance (ANOVA) of passband S21 magnitude response')
grid on
ylabel('Normalized group delay S21')
xlabel('Frequency (GHz)')
ax2 = gca;
ax2.XTick = 0.5:4:40.5;
ax2.XTickLabel = {2.13,2.132,2.134,2.136,2.138,2.14,2.142,2.144,2.146,2.148,2.15};
title('Analysis of variance (ANOVA) of passband S21 groupdelay (normalized)')
grid on

