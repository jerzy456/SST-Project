clear all

syms        x1 x2 x3 x4 ...
            q11 q12 q13 q14 ...
            q21 q22 q23 q24 ...
            q31 q32 q33 q34 ...
            q41 q42 q43 q44 ...
            c1 c2 c3 c4 ...
            a11 a12 a13 a14 ...
            a21 a22 a23 a24 ...
            a31 a32 a33 a34 ...
            a41 a42 a43 a44 ...
            b1 b2 b3 b4 x y real

X           = [x1;x2;x3;x4];
Q           = [ q11 q12 q13 q14;
                q21 q22 q23 q24;
                q31 q32 q33 q34;
                q41 q42 q43 q44 ];
c           = [ c1; c2; c3; c4];
A           = [ a11 a12 a13 a14;
                a21 a22 a23 a24;
                a31 a32 a33 a34;
                a41 a42 a43 a44 ];
b           = [ b1; b2; b3; b4];


f0(x1,x2,x3,x4) ...
            = [x1;x2;x3;x4]'*Q*[x1;x2;x3;x4] + c'*[x1;x2;x3;x4];
f1(x1,x2,x3,x4) ...
            = A(1,:)*[x1;x2;x3;x4] - b(1);
f2(x1,x2,x3,x4) ...
            = A(2,:)*[x1;x2;x3;x4] - b(2);
F           = [f1,f2]';


clear x y gf0 g2f0 gF gY
n                   = 2;
m                   = 2;

gf0(1:n+m,1)        = gradient(f0)
g2f0(1:n+m,1:n+m)   = hessian(f0)
gF(1:m,1:n+m)       = jacobian(F)

Bs                  = combnk(1:n+m,m);
Ns                  = zeros(1,n);
for k = 1:size(Bs,1)
    Ns(k,1:n)       = setdiff(1:n+m,Bs(k,:));
    x(1:n,k)        = X(Ns(k,:));
    y(1:m,k)        = X(Bs(k,:));
    gxF(1:m,1:n,k)  = gF(1:m,Ns(k,:));
    gyF(1:m,1:m,k)  = gF(1:m,Bs(k,:));
    gY(1:m,1:n,k)   = -gyF(1:m,1:m,k)\gxF(1:m,1:n,k);
    mu(1:m,k)       = -gyF(1:m,1:m,k)\gf0(Bs(k,:));
end
x0  = [x;y]

a11 = 1;    a12 = -2;   a13 = 1;    a14 = 1;
a21 = 1;    a22 = 1;    a23 = 1/2;  a24 = 1-1e-9;
b1  = 1;    b2  = 1;    b3 = 1;     b4 = -1;
A   = (subs(A)); A = double(A(1:m,1:n+m)); b = double(subs(b(1:m,1)));
gY  = double(subs(gY))

q11 = 1;    q12 = 0;    q13 = 0;    q14 = 0;
q21 = 0;    q22 = .1;   q23 = 0;    q24 = 0;
q31 = 0;    q32 = 0;    q33 = .1;   q34 = 0;
q41 = 0;    q42 = 0;    q43 = 0;    q44 = 1-1e-3;
c1  = 1;    c2  = 3;    c3 = 3;     c4 = 1;
Q   = double(subs(Q)); c = double(subs(c));
f0  = subs(f0); convexity   = schur(Q)