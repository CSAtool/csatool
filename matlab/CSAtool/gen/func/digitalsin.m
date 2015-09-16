function [signal,t]=digitalsin(fin,fs,A,OS,periods,nin)
%[signal,t]=digitalsin(fin,fs,A,OS,periods)
%This function produces generates a sampled sinusoid and its timeframe.
%Frequency, amplitude, baseline and duration (in periods) of the sinusoid 
%are input parameters.
%INPUT:
% fin : frequency;
% A: amplitude;
% fs: sampling frequency;
% OS: baseline (offset);
% periods: duration of the sinusoid in periods;
%
% OUTPUT:
%signal : y values of the sinusoid;
%t: timeframe;
points=(periods*fs/fin)-1;
t=0:points;
t=t/fs;
noise = randn(length(t),1)*nin;
%sizenoise=size(noise)
signal = OS+A*sin(2*pi*fin*t);
%sizesig=size(signal)
signal=signal+noise';
end

