function G=Lattice(n)
G = delsq(numgrid('S',n+2));
G = graph(G,'omitselfloops');
end
