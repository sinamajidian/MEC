
clear all
close all
p = logspace(-4,-.295);

l=1000;
c=2;
for  k=1:length(p)
    Pc1(k)=binocdf(floor(c/2),c,p(k))^l;
end
c=10;
for  k=1:length(p)
    Pc2(k)=binocdf(floor(c/2),c,p(k))^l;
end
c=100;
for  k=1:length(p)
    Pc3(k)=binocdf(floor(c/2),c,p(k))^l;
end



c_u1=randi([1,2],l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_u1(j)/2),c_u1(j),p(k));
    end
    Pu1(k)=a;
end
c_u2=randi([1,10],l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_u2(j)/2),c_u2(j),p(k));
    end
    Pu2(k)=a;
end
c_u3=randi([1,100],l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_u3(j)/2),c_u3(j),p(k));
    end
    Pu3(k)=a;
end



c_p1=poissrnd(2,l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_p1(j)/2),c_p1(j),p(k));
    end
    Pp1(k)=a;
end
c_p2=poissrnd(10,l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_p2(j)/2),c_p2(j),p(k));
    end
    Pp2(k)=a;
end
c_p3=poissrnd(100,l,1);
for k=1:length(p)
    a=1;
    for j=1:l
        a=a*binocdf(floor(c_p3(j)/2),c_p3(j),p(k));
    end
    Pp3(k)=a;
end


close all
semilogx(p,Pc1)
hold on
semilogx(p,Pc2)
semilogx(p,Pc3)
semilogx(p,Pu1)
semilogx(p,Pu2)
semilogx(p,Pu3)
semilogx(p,Pp1)
semilogx(p,Pp2)
semilogx(p,Pp3)

legend('Constant c=2','Constant c=10','Constant c=100','Uniform on [1,2]','Uniform on [1,10]','Uniform on [1,100]','Poisson with \lambda=2','Poisson with \lambda=10','Poisson with \lambda=100')


ylabel('P\{c-MEC\}','FontSize',14)
xlabel('Sequencing error rate','FontSize',14)
