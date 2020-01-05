%Tema 2 SP - Cerbureanu Andrei 424D 

%Semnal triunghiular cu perioada T=40, durata semnalului D=4

D=4;
N=50; %Numarul de coeficienti 
T = 40;
f=1/T; %Frecventa semnalului
w=2*pi*f; %Pulsatia semnalului

C = zeros(1,2*N+1); %Am initializat vectorul de coeficienti cu valori nule

%Rezolutia temporala t=100ms
t = -2*T:0.1:2*T; %0.1 = 100ms 

%Contruire semnal initial:
x=abs(sawtooth(w*t,0.45));




%Calculul coeficientilor folosind formula:
for k = -N:N

C(k+N+1) = integral(@(t)((abs(sawtooth(w*t,0.45))+sawtooth(w*t,0.45)))/2.*exp(-1j*k*w*t),0,T);

end


%Reconstruirea semnalului initial:
xr=0;

for k = -N:N

xr = xr + C(k+N+1)*exp(1j*k*w*t);

end

%Deoarece in formula, suma este inmultita cu 1/T, vom inmulti si semnalul
%rezultat xr cu 1/T
xr=xr/T;


%Reprezentarea semnalului initial x si a celui reconstruit xr:
figure(1);

hold on;
plot(t,x);

plot(t,real(xr),':r','Color',[0.7 0 0])
xlabel('Timpul[s]');
ylabel('xr(t)-semnalul reconstruit');
title(' Reprezentarea semnalului initial(albastru) si a celui reconstruit(rosu) ')
axis([-40 40 -0.1 1.1])

hold off;



figure(2); % Reprezint semnalele si separat in caz de orice eventualitate.

subplot(2,1,1)
hold on;
plot(t,x);
xlabel('Timpul[s]');
ylabel('x(t)-semnalul initial');
title(' Reprezentarea semnalului initial ')
axis([-40 40 -0.1 1.1])


%Reprezentarea semnalului reconstruit xr:

subplot(2,1,2)
plot(t,real(xr),':r')
xlabel('Timpul[s]');
ylabel('xr(t)-semnalul reconstruit');
title(' Reprezentarea semnalului reconstruit ')
axis([-80 80 -0.1 1.1])

hold off;

%Reprezentarea grafica a spectrului de amplitudini
figure(3);

hold on;
plot((-N:N)*w,2*abs(C)); %Ak=2*|Ck|


for k=-N:N
stem(k*w,2*abs(C(k+N+1)),'.r'); %Functia stem realizeaza o reprezentare in forma “discreta” a datelor.
end  



xlabel('Pulsatia w [rad/s]');
ylabel('Amplitudinile Ak');
title('Spectrul de Amplitudini');
axis([-4 4 -0.1 20])

hold off



%Seria Fourier este folosita pentru a analiza
%functiile periodice descompunandu-le intr-o suma ponderata de functii sinusoidale.
%Fiecare functie sinusoidala are un coeficient(pondere).
%Reprezentarea spectrala ne arata frecventele si ponderile sinusoidelor prin care poate
%fi aproximat semnalul.
%Semnalul reconstruit pe baza coeficientilor Fourier devine din ce in ce mai
%apropiat de semnalul original, cu cat sunt luati in considerare mai multi
%termeni ai dezvoltarii.