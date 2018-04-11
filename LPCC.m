% close all
% clear all
% clc
% MM=307244;
% I = audioread('work50-1-all 00_00_00-00_00_30.wav',[1 MM]);%����ԭʼ����
function Z=LPCC(wav)
I=wav(:,1);
% subplot(3,1,1),plot(I);
% title('ԭʼ��������')
%��ָ��֡λ�ý��мӴ�����
Q = I';
N = 256; % ����
Hamm = hamming(N); % �Ӵ�
frame = 30;%��Ҫ������֡λ��
M = Q(((frame - 1) * (N / 2) + 1):((frame - 1) * (N / 2) + N));
Frame = M .* Hamm';%�Ӵ��������֡
[B,F,T] = specgram(I,N,N/2,N);
[m,n] = size(B);
for i = 1:m
FTframe1(i) = B(i,frame);
end
%%%%%
P =12; % Ԥ��������

ai = lpc(Frame,P); % ����lpcϵ��
LP = filter([0 -ai(2:end)],1,Frame); % ��������֡�����򷽳�
FFTlp = fft(LP);
E = Frame - LP; % Ԥ�����
% subplot(3,1,2),plot(1:N,Frame,1:N,LP,'-r');grid;
% title('ԭʼ������Ԥ����������')
% subplot(3,1,3),plot(E);grid;
% title('Ԥ�����');

fLength(1 : 2 * N) = [M,zeros(1,N)];
Xm = fft(fLength,2 * N);
X = Xm .* conj(Xm);
Y = fft(X , 2 * N);
Rk = Y(1 : N);
PART = sum(ai(2 : P + 1) .* Rk(1 : P));
G = sqrt(sum(Frame.^2) - PART);
A = (FTframe1 - FFTlp(1 : length(F'))) ./ FTframe1 ;
% subplot(2,1,1),plot(F',20*log(abs(FTframe1)),F',(20*log(abs(1 ./ A))),'-r');grid;
% xlabel('Ƶ��/dB');ylabel('����');
% title('��ʱ��');
% subplot(2,1,2),plot(F',(20*log(abs(G ./ A))));grid;
% xlabel('Ƶ��/dB');ylabel('����');
% 
% title('LPC��');



%���Ԥ�����ĵ���

pitch = fftshift(rceps(E));

M_pitch = fftshift(rceps(Frame));
Z=M_pitch;

% subplot(2,1,1),plot(M_pitch);grid;
% 
% xlabel('����֡');ylabel('/dB');
% 
% title('ԭʼ����֡����');
% 
% subplot(2,1,2),plot(pitch);grid;
% 
% xlabel('����֡');ylabel('/dB');
% 
% title('Ԥ������');
% 
% 
% 
% %��������ͼ
% 
% ai1 = lpc(I,P); % ����ԭʼ����lpcϵ��
% 
% LP1 = filter([0 -ai(2:end)],1,I); % ����ԭʼ���������򷽳�
% 
% subplot(2,1,1);
% 
% specgram(I,N,N/2,N);
% 
% title('ԭʼ��������ͼ');
% 
% subplot(2,1,2);
% 
% specgram(LP1,N,N/2,N);
% 
% title('Ԥ����������ͼ');
