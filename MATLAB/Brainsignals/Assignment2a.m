N = 5096*2;
Ts = 2/N;
fs = 1/Ts;
df = fs/N;
n = (0:N-1)';
t = Ts*n;
x = t.*(1-t).*rectangularPulse((t-1/2));
X = fftshift(Ts*fft(x));
k = (-N/2:N/2-1)';

subplot(3,1,1);
p = plot(t,x,'k'); set(p,'LineWidth',2); grid on;
xlabel('time,t(s)'); ylabel('x(t)');
subplot(3,1,2);
p = plot(k*df,abs(X),'k'); set (p,'LineWidth',2); grid on;
xlabel('Frequency, f(Hz'); ylabel('|X(f)|');
subplot(3,1,3);
p = plot(k*df,angle(X),'k'); set(p,'LineWidth',2); grid on;
xlabel('Frequency, f(Hz)'); ylabel('Phase of X(f)');

