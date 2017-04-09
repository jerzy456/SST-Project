clear all

syms        x1 x2 real
a           = 2;
f0(x1,x2)   = x2^2-a*x2*norm([x1;x2])^2+norm([x1;x2])^4;

gf0         = gradient(f0)
g2f0        = hessian(f0)

dx1         = .02;
dx2         = .02;
X1          = -.5:dx1:.5;
X2          = 0:dx2:1.15;
[x1,x2]     = meshgrid(X1,X2);

figure(2)
clf
surf(x1,x2,double(f0(x1,x2)))

figure(3)
clf
contour(x1,x2,f0(x1,x2),40)
hold on

z           = [0.1;0.25];
df          = double(gf0(z(1),z(2)));
dx          = [0.15;-0.1];

quiver(z(1),z(2),df(1),df(2),'MaxHeadSize',.9)
quiver(z(1),z(2),-df(1),-df(2),'MaxHeadSize',.9)
quiver(z(1),z(2),dx(1),dx(2),'MaxHeadSize',.9)
text(z(1)*1.1,z(2)*1.1,'$\mathbf{z}$',...
    'Interpreter','latex','Fontsize',12)
text((z(1)+df(1))*1.1,z(2)+df(2),'$\mathbf{z}+\nabla f_0(\mathbf{z})$',...
    'Interpreter','latex','Fontsize',12)
text((z(1)-df(1))*1.01,z(2)-df(2),'$\mathbf{z}-\nabla f_0(\mathbf{z})$',...
    'Interpreter','latex','Fontsize',12)
text((z(1)+dx(1))*1.01,z(2)+dx(2),'$\mathbf{z}+\mathrm{d}\mathbf{x}$',...
    'Interpreter','latex','Fontsize',12)

z           = [0;.525];
dx          = [.02;-.02];

FONC        = double(gf0(z(1),z(2)))
SONC        = dx(1)'*g2f0(z(1)+dx(1),z(2)+dx(2))*dx; SONC = double(SONC)
convexity   = schur(double(g2f0(z(1)+dx(1),z(2)+dx(2))))

z           = [0;0];
dx          = [.02;-.02];

FONC        = double(gf0(z(1),z(2)))
SONC        = dx(1)'*g2f0(z(1)+dx(1),z(2)+dx(2))*dx; SONC = double(SONC)
convexity   = schur(double(g2f0(z(1)+dx(1),z(2)+dx(2))))