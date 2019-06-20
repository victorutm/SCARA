clc;
clear all;
close all;

nombre = DXFtool('ruth_2.DXF');

l1=100; l2=75; l3=75; d3=30;
%DH = [THETA D A ALPHA SIGMA] where OFFSET is zero.
%'standard'    for standard D&H parameters (default).
%DH = [THETA D A ALPHA SIGMA]
%D is unused in a revolute joint
%THETA is unused in a prismatic joint
L0 = Link([0,l1,0,0,0]);
L1 = Link([0,0,l2,0,0]);
L2 = Link([0,0,l3,pi,0]);
L3 = Link([0,0,0,0,d3]); 
L3.qlim = [0 30];
scara=SerialLink([L0  L1 L2 L3], 'name', 'SCARA');
area=140;
W=[-area area -area area 0 area];
f1 = figure;
scara.plot([0 0 0 0],'workspace', W,'delay',0.017);

for i=nombre.ne:-1:1
    X=nombre.entities(i).spline.X;
    Y=nombre.entities(i).spline.Y;
    sz=size(X);
    for j=1:sz
        x=X(j);
        y=Y(j);
        z=10 ; 
        [d3, q2, q1]=cinv_SCARA(l1,l2,l3,x,y,z) ;
        scara.plot([0 q1 q2 d3],'workspace', W,'delay',0.017);
    end
end


f2=figure;
hold on
axis equal
for i=nombre.ne:-1:1
    X=nombre.entities(i).spline.X;
    Y=nombre.entities(i).spline.Y;
    sz=size(X);
    for j=1:sz
        x=nombre.entities(i).spline.X(j);
        y=nombre.entities(i).spline.Y(j);
        plot(x,y,'*-');
        pause(0.02);
    end
end


