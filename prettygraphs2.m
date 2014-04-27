%Henry M. Clever
%February 15, 2014
%Function to make nice graphs
%For a better visual effect, you might choose to had larger dots along your
%graph. However, the simple way to do this presents a problem because it 
%can only space them with relation to position in your data set. If you
%have data that's all clumped together in some positions the graph of the
%larger dots won't look nice. This fixes that problem because it spaces the
%dots with relation to the y distance as well as the x distance.

clc;clear;

a=load('JohnsonData.m');
a=a(2:502,:);
tr=10.^(2-a);
next=zeros(501,2);
next(:,1)=a(:,1);
next(:,2)=tr(:,2);


%this part builds a new matrix that finds the distance between points --the
%wavelength values are all the same (1) but this finds the distance between
%vertical y axis values
a6=([a(2:501,1),tr(2:501,2),zeros(500,4)]);
for i=2:500
    a6(i,3)=abs(a6(i,2)-a6(i-1,2));
end

%this square root function is the actual distance finder for both y axis and
%wavelength
a6(:,4)=(1+a6(:,3).^2).^0.5;
a6(1,5)=a6(1,4);
for i=2:500
    a6(i,5)=a6(i-1,5)+a6(i,4);
end
a6(:,6)=round(a6(:,5));


%this adds the values from the previous matrix to the ones that match to
%build a set which identifies locations of missing values
a7=([(1:600)',zeros(600,2)]);
for j=1:500
    for i=1:600
        if a6(j,6)==a7(i,1)
            a7(i,2)=a6(j,1);
            a7(i,3)=a6(j,2);
        end
    end
end

%this big statement is what interpolates to add the numbers between the
%missing parts
for j=2:596
    if all([a7(j,2)==0,a7(j-1,2)||0,a7(j+1,2)||0])
        a7(j,2)=(a7(j-1,2)+a7(j+1,2))/2;
        a7(j,3)=(a7(j-1,3)+a7(j+1,3))/2;
    end
    if all([a7(j,2)==0,a7(j-1,2)||0,a7(j+1,2)==0,a7(j+2,2)||0])
        a7(j,2)=((a7(j+2,2)-a7(j-1,2))*.3333)+a7(j-1,2);         
        a7(j+1,2)=((a7(j+2,2)-a7(j-1,2))*.6667)+a7(j-1,2); 
        a7(j,3)=((a7(j+2,3)-a7(j-1,3))*.3333)+a7(j-1,3);         
        a7(j+1,3)=((a7(j+2,3)-a7(j-1,3))*.6667)+a7(j-1,3); 
    end
    if all([a7(j,2)==0,a7(j-1,2)||0,a7(j+1,2)==0,a7(j+2,2)==0,a7(j+3,2)||0])
        a7(j,2)=((a7(j+3,2)-a7(j-1,2))*.25)+a7(j-1,2);
        a7(j+1,2)=((a7(j+3,2)-a7(j-1,2))*.50)+a7(j-1,2);
        a7(j+2,2)=((a7(j+3,2)-a7(j-1,2))*.75)+a7(j-1,2);
        a7(j,3)=((a7(j+3,3)-a7(j-1,3))*.25)+a7(j-1,3);
        a7(j+1,3)=((a7(j+3,3)-a7(j-1,3))*.50)+a7(j-1,3);
        a7(j+2,3)=((a7(j+3,3)-a7(j-1,3))*.75)+a7(j-1,3);
    end
    if all([a7(j,2)==0,a7(j-1,2)||0,a7(j+1,2)==0,a7(j+2,2)==0,a7(j+3,2)==0,a7(j+4,2)||0])
        a7(j,2)=((a7(j+4,2)-a7(j-1,2))*.2)+a7(j-1,2);
        a7(j+1,2)=((a7(j+4,2)-a7(j-1,2))*.4)+a7(j-1,2);
        a7(j+2,2)=((a7(j+4,2)-a7(j-1,2))*.6)+a7(j-1,2);
        a7(j+3,2)=((a7(j+4,2)-a7(j-1,2))*.8)+a7(j-1,2);
        a7(j,3)=((a7(j+4,3)-a7(j-1,3))*.2)+a7(j-1,3);
        a7(j+1,3)=((a7(j+4,3)-a7(j-1,3))*.4)+a7(j-1,3);
        a7(j+2,3)=((a7(j+4,3)-a7(j-1,3))*.6)+a7(j-1,3);
        a7(j+3,3)=((a7(j+4,3)-a7(j-1,3))*.8)+a7(j-1,3);
    end
end     

plot(a7(:,2),a7(:,3),'r-',a7(1:10:600,2),a7(1:10:600,3),'rs','LineWidth',2);hold on


axis([400 700 0 100]);
set(gca,'YTickLabel',[])
